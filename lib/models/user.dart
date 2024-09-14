// models/user.dart

class User {
  final String userAccountID;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String language;
  final String balance;

  User({
    required this.userAccountID,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.language,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
