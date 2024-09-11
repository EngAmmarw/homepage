// payment.dart

class Payment {
  final String id; // Unique identifier for the payment
  final String userId; // ID of the user making or receiving the payment
  final double amount; // Amount of the payment
  final String currency; // Currency of the payment (e.g., USD, EUR)
  final DateTime date; // Date when the payment was made
  final String status; // Status of the payment (e.g., pending, completed)
  final String description; // Optional description of the payment
  final String type; // Type of payment (e.g., transfer, deposit, withdrawal)

  Payment({
    required this.id,
    required this.userId,
    required this.amount,
    required this.currency,
    required this.date,
    required this.status,
    this.description = '',
    required this.type,
  });

  // Factory method to create a Payment object from JSON
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      userId: json['userId'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      description: json['description'] ?? '',
      type: json['type'],
    );
  }

  // Method to convert Payment object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'amount': amount,
      'currency': currency,
      'date': date.toIso8601String(),
      'status': status,
      'description': description,
      'type': type,
    };
  }
}
