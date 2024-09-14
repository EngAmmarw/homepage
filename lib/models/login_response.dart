// Models/login_response.dart

class LoginResponse {
  final bool success;
  final UserData? data;

  LoginResponse({required this.success, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'],
      data: json['success'] ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String userAccountID;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String language;

  UserData({
    required this.userAccountID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.language,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userAccountID: json['userAccountID'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      language: json['language'],
    );
  }
}
