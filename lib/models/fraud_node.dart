class FraudNode {
  final String id;
  final String type;
  final String name;
  final double riskScore;
  final List<String> connections;
  final Map<String, dynamic> attributes;

  FraudNode({
    required this.id,
    required this.type,
    required this.name,
    required this.riskScore,
    required this.connections,
    required this.attributes,
  });

  factory FraudNode.fromJson(Map<String, dynamic> json) {
    return FraudNode(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      riskScore: (json['riskScore'] as num).toDouble(),
      connections: List<String>.from(json['connections'] as List),
      attributes: json['attributes'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'riskScore': riskScore,
      'connections': connections,
      'attributes': attributes,
    };
  }
}
