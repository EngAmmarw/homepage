// Models/payment_request.dart

class PaymentRequest {
  final String receiverAccountNumber;
  final String senderAccountNumber;
  final String paymentDate;
  final int paymentAmount;
  final String paymentType;

  PaymentRequest({
    required this.receiverAccountNumber,
    required this.senderAccountNumber,
    required this.paymentDate,
    required this.paymentAmount,
    required this.paymentType,
  });

  Map<String, dynamic> toJson() {
    return {
      'receiverAccountNumber': receiverAccountNumber,
      'senderAccountNumber': senderAccountNumber,
      'paymentDate': paymentDate,
      'paymentAmount': paymentAmount,
      'paymentType': paymentType,
    };
  }
}
