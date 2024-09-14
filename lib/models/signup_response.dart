// Models/signup_response.dart

class SignupResponse {
  final bool success;
  final UserData? data;

  SignupResponse({required this.success, this.data});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
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
  final String balance;

  UserData({
    required this.userAccountID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.language,
    required this.balance,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userAccountID: json['userAccountID'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      language: json['language'],
      balance: json['balance'],
    );
  }
}
