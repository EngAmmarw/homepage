// models/user.dart

class User {
  final String id; // Unique identifier for the user
  final String name; // Full name of the user
  final String email; // Email address of the user
  final String phoneNumber; // Phone number of the user
  final String profileImage; // URL of the user's profile image
  final double balance; // User's account balance

  // Constructor for initializing the User object
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImage,
    required this.balance,
  });

  // Factory method to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImage: json['profileImage'] as String,
      balance: (json['balance'] as num).toDouble(),
    );
  }

  // Method to convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'balance': balance,
    };
  }

  // Method to update user balance
  User copyWith({double? balance}) {
    return User(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
      balance: balance ?? this.balance,
    );
  }
}
