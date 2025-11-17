import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:deligo_driver/data/models/ride_data_model/Driver.dart';
import 'package:deligo_driver/presentation/account_page/view_model/ride_data_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/state/app_state.dart';
import '../../../data/models/common_response.dart';
import '../../../data/models/driver_details_response/driver_details_response.dart';
import '../../../data/models/profile_model/get_profile/GetProfileModel.dart';
import '../../auth/provider/auth_providers.dart';
import '../view_model/profile_notifier.dart';

// final profilePhotoUploadNotifierProvider =
//     StateNotifierProvider.autoDispose<ProfilePhotoUploadNotifier, AppState<CommonResponse>>(
//         (ref) => ProfilePhotoUploadNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final selectedProfilePhotoProvider = StateNotifierProvider<SelectedProfilePhotoNotifier, File?>(
    (ref) => SelectedProfilePhotoNotifier());

final driverDetailsNotifierProvider = StateNotifierProvider<DriverDetailsViewModel, AppState<GetProfileModel>>(
    (ref) => DriverDetailsViewModel(ref: ref, authRepo: ref.read(authRepoProvider)));
final rideDataCountProvider = StateNotifierProvider<RideDataNotifier, AppState<RideDataCount?>>(
    (ref) => RideDataNotifier(ref: ref, repo: ref.read(authRepoProvider)));

final updateProfileProvider = StateNotifierProvider<UpdateProfileNotifier, AppState<CommonResponse>>(
    (ref) => UpdateProfileNotifier(ref: ref, authRepo: ref.read(authRepoProvider)));

final selectedAvatarProvider = StateNotifierProvider<SelectedAvatarNotifierProvider, Tuple2<int?, String?>>(
    (ref) => SelectedAvatarNotifierProvider());
