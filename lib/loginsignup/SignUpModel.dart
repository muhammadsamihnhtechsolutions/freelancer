class SignupModel {
  final String fullName;
  final String email;
  final String password;
  final String role;
  final String country;

  SignupModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.role,
    required this.country,
  });

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "password": password,
        "role": role,
        "country": country,
      };
}