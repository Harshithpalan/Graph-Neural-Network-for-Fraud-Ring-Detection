class FraudAlert {
  final String id;
  final String type;
  final String description;
  final double riskScore;
  final DateTime timestamp;
  final String status;
  final List<String> involvedEntities;

  FraudAlert({
    required this.id,
    required this.type,
    required this.description,
    required this.riskScore,
    required this.timestamp,
    required this.status,
    required this.involvedEntities,
  });

  factory FraudAlert.fromJson(Map<String, dynamic> json) {
    return FraudAlert(
      id: json['id'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: json['status'] as String,
      involvedEntities: List<String>.from(json['involvedEntities'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'description': description,
      'riskScore': riskScore,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'involvedEntities': involvedEntities,
    };
  }
}
