class LoginResponse {
  final String token;
  final UserModel user;

  LoginResponse({required this.token, required this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json["data"]["token"],
      user: UserModel.fromJson(json["data"]["user"]),
    );
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String role;
  final String country;
  final int isVerified;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.country,
    required this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      fullName: json["full_name"],
      email: json["email"],
      role: json["role"],
      country: json["country"],
      isVerified: json["is_verified"],
    );
  }
}