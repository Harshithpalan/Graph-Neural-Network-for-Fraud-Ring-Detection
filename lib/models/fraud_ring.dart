class FraudRing {
  final String id;
  final String name;
  final int size;
  final double confidenceScore;
  final DateTime detectedAt;
  final List<String> memberIds;
  final List<String> patterns;
  final double totalValueAtRisk;

  FraudRing({
    required this.id,
    required this.name,
    required this.size,
    required this.confidenceScore,
    required this.detectedAt,
    required this.memberIds,
    required this.patterns,
    required this.totalValueAtRisk,
  });

  factory FraudRing.fromJson(Map<String, dynamic> json) {
    return FraudRing(
      id: json['id'] as String,
      name: json['name'] as String,
      size: json['size'] as int,
      confidenceScore: (json['confidenceScore'] as num).toDouble(),
      detectedAt: DateTime.parse(json['detectedAt'] as String),
      memberIds: List<String>.from(json['memberIds'] as List),
      patterns: List<String>.from(json['patterns'] as List),
      totalValueAtRisk: (json['totalValueAtRisk'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'size': size,
      'confidenceScore': confidenceScore,
      'detectedAt': detectedAt.toIso8601String(),
      'memberIds': memberIds,
      'patterns': patterns,
      'totalValueAtRisk': totalValueAtRisk,
    };
  }
}
