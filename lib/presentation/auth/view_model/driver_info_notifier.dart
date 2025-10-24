import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/auth_models/driver_info_state.dart';


/// Single Notifier managing full DriverInfoState
class DriverInfoNotifier extends StateNotifier<DriverInfoState> {
  DriverInfoNotifier() : super(DriverInfoState.empty());

  /// Update driver info
  void updateInitialRegisterInfo(Map<String, dynamic> info){
    state = state.copyWith(
      initialRegisterInfo: {...state.initialRegisterInfo, ...info},
    );
  }
  /// Update personal info
  void updatePersonalInfo(Map<String, dynamic> info) {
    state = state.copyWith(
      personalInfo: {...state.personalInfo, ...info},
    );
  }

  /// Update legal documents
  void updateLegalDocuments(Map<String, dynamic> docs) {
    state = state.copyWith(
      legalDocuments: {...state.legalDocuments, ...docs},
    );
  }

  /// Update vehicle info
  void updateVehicleInfo(Map<String, dynamic> info) {
    state = state.copyWith(
      vehicleInfo: {...state.vehicleInfo, ...info},
    );
  }

  /// Update bank/payment info
  void updateBankPaymentInfo(Map<String, dynamic> info) {
    state = state.copyWith(
      bankPaymentInfo: {...state.bankPaymentInfo, ...info},
    );
  }

  /// Update agreement info
  void updateAgreement(Map<String, dynamic> info) {
    state = state.copyWith(
      agreement: {...state.agreement, ...info},
    );
  }

  /// Reset all state to empty
  void reset() {
    state = DriverInfoState.empty();
  }
}
