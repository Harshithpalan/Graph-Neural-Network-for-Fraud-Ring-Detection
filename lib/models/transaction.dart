class Transaction {
  final String id;
  final String fromEntity;
  final String toEntity;
  final double amount;
  final String currency;
  final DateTime timestamp;
  final String status;
  final String? flaggedReason;

  Transaction({
    required this.id,
    required this.fromEntity,
    required this.toEntity,
    required this.amount,
    required this.currency,
    required this.timestamp,
    required this.status,
    this.flaggedReason,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      fromEntity: json['fromEntity'] as String,
      toEntity: json['toEntity'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      flaggedReason: json['flaggedReason'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fromEntity': fromEntity,
      'toEntity': toEntity,
      'amount': amount,
      'currency': currency,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'flaggedReason': flaggedReason,
    };
  }
}
