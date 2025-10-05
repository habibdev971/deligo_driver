class RegisterDataModel {
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final String gender;
  final String? password;
  final String email;
  final String? idToken;
  RegisterDataModel({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.password,
    required this.email,
    this.idToken,
  });
}
