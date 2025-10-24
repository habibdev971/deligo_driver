class DriverInfoState {
  final Map<String, dynamic> initialRegisterInfo;
  final Map<String, dynamic> personalInfo;
  final Map<String, dynamic> legalDocuments;
  final Map<String, dynamic> vehicleInfo;
  final Map<String, dynamic> bankPaymentInfo;
  final Map<String, dynamic> agreement;

  const DriverInfoState({
    required this.initialRegisterInfo,
    required this.personalInfo,
    required this.legalDocuments,
    required this.vehicleInfo,
    required this.bankPaymentInfo,
    required this.agreement,
  });

  /// Creates a copy of this state with updated fields
  DriverInfoState copyWith({
    Map<String, dynamic>? initialRegisterInfo,
    Map<String, dynamic>? personalInfo,
    Map<String, dynamic>? legalDocuments,
    Map<String, dynamic>? vehicleInfo,
    Map<String, dynamic>? bankPaymentInfo,
    Map<String, dynamic>? agreement,
  }) => DriverInfoState(
    initialRegisterInfo: initialRegisterInfo ?? this.initialRegisterInfo,
    personalInfo: personalInfo ?? this.personalInfo,
    legalDocuments: legalDocuments ?? this.legalDocuments,
    vehicleInfo: vehicleInfo ?? this.vehicleInfo,
    bankPaymentInfo: bankPaymentInfo ?? this.bankPaymentInfo,
    agreement: agreement ?? this.agreement,
  );

  /// Returns an empty initial state
  factory DriverInfoState.empty() => const DriverInfoState(
    initialRegisterInfo: {},
    personalInfo: {},
    legalDocuments: {},
    vehicleInfo: {},
    bankPaymentInfo: {},
    agreement: {},
  );

  @override
  String toString() =>
      'DriverInfoState(initialRegisterInfo: $initialRegisterInfo, personalInfo: $personalInfo, legalDocuments: $legalDocuments, vehicleInfo: $vehicleInfo, bankPaymentInfo: $bankPaymentInfo, agreement: $agreement)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DriverInfoState &&
        other.initialRegisterInfo == initialRegisterInfo &&
        other.personalInfo == personalInfo &&
        other.legalDocuments == legalDocuments &&
        other.vehicleInfo == vehicleInfo &&
        other.bankPaymentInfo == bankPaymentInfo &&
        other.agreement == agreement;
  }

  @override
  int get hashCode =>
      initialRegisterInfo.hashCode ^
      personalInfo.hashCode ^
      legalDocuments.hashCode ^
      vehicleInfo.hashCode ^
      bankPaymentInfo.hashCode ^
      agreement.hashCode;
}
