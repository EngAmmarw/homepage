// lib/Models/user_response.dart

class UserResponse {
  final bool success;
  final UserData data;

  UserResponse({required this.success, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      success: json['success'],
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final String userId;

  UserData({required this.userId});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'],
    );
  }
}
