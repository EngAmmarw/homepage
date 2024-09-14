// Models/payment_response.dart

class PaymentResponse {
  final bool success;
  final PaymentData? data;

  PaymentResponse({required this.success, this.data});

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'],
      data: json['success'] ? PaymentData.fromJson(json['data']) : null,
    );
  }
}

class PaymentData {
  final String paymentID;
  final String receiverAccountNumber;
  final String senderAccountNumber;
  final String paymentAmount;
  final String paymentDate;
  final String paymentType;

  PaymentData({
    required this.paymentID,
    required this.receiverAccountNumber,
    required this.senderAccountNumber,
    required this.paymentAmount,
    required this.paymentDate,
    required this.paymentType,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      paymentID: json['paymentID'],
      receiverAccountNumber: json['receiverAccountNumber'],
      senderAccountNumber: json['senderAccountNumber'],
      paymentAmount: json['paymentAmount'],
      paymentDate: json['paymentDate'],
      paymentType: json['paymentType'],
    );
  }
}
