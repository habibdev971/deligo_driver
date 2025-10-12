import 'dart:developer';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/helpers.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_models/register_data_model.dart';

ValueNotifier<FirebaseAuthService> firebaseAuthNotifier = ValueNotifier(
  FirebaseAuthService(),
);
final authLoadingProvider = StateProvider<bool>((ref) => false);

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _verificationId;
  int? _forceResendingToken;

  User? get user => auth.currentUser;
  bool get isLoggedIn => user != null;

  /// 🔹 1. Sign in with mobile (send OTP)
  Future<void> signInWithMobile(
    String phoneNumber, {
    required void Function(bool) onLoadingChange,
    // RegisterDataModel? data,
  }) async {
    onLoadingChange(true);

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: _forceResendingToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        showNotification(
          message: 'Phone number automatically verified',
          isSuccess: true,
        );
        onLoadingChange(false);
        // NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
      },
      verificationFailed: (FirebaseAuthException error) {
        log('Verification failed: ${error.code} - ${error.message}');
        showNotification(message: error.message ?? 'Verification failed');
        onLoadingChange(false);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _verificationId = verificationId;
        _forceResendingToken = forceResendingToken;
        log('Verification ID: $verificationId');
        showNotification(message: 'OTP sent to $phoneNumber', isSuccess: true);
        onLoadingChange(false);
        NavigationService.pushNamed(AppRoutes.verifyFirebaseOtp, arguments: phoneNumber);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        // _forceResendingToken = 1;
        showNotification(message: 'OTP timeout, please request again');
        onLoadingChange(false);
      },
    );
  }

  /// 🔹 2. Verify OTP
  Future<bool> verifyOTP(
    String otp, {
    required void Function(bool) onLoadingChange,
    required void Function() onSuccess,
  }) async {
    if (_verificationId == null) {
      showNotification(message: 'Verification ID not found');
      return false;
    }
    onLoadingChange(true);
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential);

      log('verification id: ${credential.verificationId}');
      log('signIn method: ${credential.signInMethod}');

      showNotification(
        message: 'Phone verification successful',
        isSuccess: true,
      );
      onSuccess();
      // NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
      return true;
    } catch (e) {
      log('OTP verification failed: $e');
      showNotification(message: 'Invalid OTP, please try again');
      return false;
    } finally {
      onLoadingChange(false);
    }
  }

  /// 🔹 3. Resend OTP
  Future<void> resendOTP(
    String phoneNumber, {
    required void Function(bool) onLoadingChange,
  }) async {
    if (_forceResendingToken == null) {
      showNotification(
        message: 'No OTP request found. Please try login again.',
      );
      return;
    }

    onLoadingChange(true);

    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      forceResendingToken: _forceResendingToken,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        showNotification(
          message: 'Phone number automatically verified',
          isSuccess: true,
        );
        onLoadingChange(false);
        // NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
      },
      verificationFailed: (FirebaseAuthException error) {
        log('Resend failed: ${error.code} - ${error.message}');
        showNotification(message: error.message ?? 'Resend failed');
        onLoadingChange(false);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _verificationId = verificationId;
        _forceResendingToken = forceResendingToken;
        log('Resent Verification ID: $verificationId');
        showNotification(
          message: 'OTP resent to $phoneNumber',
          isSuccess: true,
        );
        onLoadingChange(false);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        showNotification(message: 'OTP timeout, please request again');
        onLoadingChange(false);
      },
    );
  }

  /// 🔹 4. Sign out
  Future<void> signOut() async {
    await auth.signOut();
    // await _googleSignIn.signOut();
    showNotification(message: 'Signed out successfully', isSuccess: true);
  }
}
