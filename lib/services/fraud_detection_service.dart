import '../models/fraud_alert.dart';
import '../models/fraud_ring.dart';
import '../models/fraud_node.dart';
import '../models/transaction.dart';

class FraudDetectionService {
  List<FraudAlert> _alerts = [];
  List<FraudRing> _rings = [];
  List<FraudNode> _nodes = [];
  List<Transaction> _transactions = [];

  List<FraudAlert> get alerts => _alerts;
  List<FraudRing> get rings => _rings;
  List<FraudNode> get nodes => _nodes;
  List<Transaction> get transactions => _transactions;

  void initializeMockData() {
    _generateMockAlerts();
    _generateMockRings();
    _generateMockNodes();
    _generateMockTransactions();
  }

  void _generateMockAlerts() {
    _alerts = [
      FraudAlert(
        id: 'ALT-001',
        type: 'Suspicious Pattern',
        description: 'Circular payment detected among 5 entities',
        riskScore: 0.92,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'pending',
        involvedEntities: ['ENT-001', 'ENT-002', 'ENT-003', 'ENT-004', 'ENT-005'],
      ),
      FraudAlert(
        id: 'ALT-002',
        type: 'Velocity Breach',
        description: 'High transaction frequency detected',
        riskScore: 0.78,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        status: 'investigating',
        involvedEntities: ['ENT-006', 'ENT-007'],
      ),
      FraudAlert(
        id: 'ALT-003',
        type: 'Amount Anomaly',
        description: 'Unusually large transaction pattern',
        riskScore: 0.85,
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        status: 'resolved',
        involvedEntities: ['ENT-008'],
      ),
      FraudAlert(
        id: 'ALT-004',
        type: 'Geographic Anomaly',
        description: 'Transactions from multiple locations in short time',
        riskScore: 0.67,
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        status: 'pending',
        involvedEntities: ['ENT-009', 'ENT-010'],
      ),
    ];
  }

  void _generateMockRings() {
    _rings = [
      FraudRing(
        id: 'RING-001',
        name: 'Payment Circle Alpha',
        size: 5,
        confidenceScore: 0.94,
        detectedAt: DateTime.now().subtract(const Duration(hours: 2)),
        memberIds: ['ENT-001', 'ENT-002', 'ENT-003', 'ENT-004', 'ENT-005'],
        patterns: ['circular_payments', 'time_based_clustering'],
        totalValueAtRisk: 450000.0,
      ),
      FraudRing(
        id: 'RING-002',
        name: 'Shell Network Beta',
        size: 8,
        confidenceScore: 0.87,
        detectedAt: DateTime.now().subtract(const Duration(days: 1)),
        memberIds: ['ENT-011', 'ENT-012', 'ENT-013', 'ENT-014', 'ENT-015', 'ENT-016', 'ENT-017', 'ENT-018'],
        patterns: ['shell_company_pattern', 'layered_transactions'],
        totalValueAtRisk: 1200000.0,
      ),
      FraudRing(
        id: 'RING-003',
        name: 'Identity Cluster Gamma',
        size: 3,
        confidenceScore: 0.76,
        detectedAt: DateTime.now().subtract(const Duration(days: 2)),
        memberIds: ['ENT-019', 'ENT-020', 'ENT-021'],
        patterns: ['shared_identifiers', 'device_fingerprint_match'],
        totalValueAtRisk: 85000.0,
      ),
    ];
  }

  void _generateMockNodes() {
    _nodes = [
      FraudNode(
        id: 'ENT-001',
        type: 'merchant',
        name: 'Alpha Electronics',
        riskScore: 0.88,
        connections: ['ENT-002', 'ENT-005'],
        attributes: {'region': 'NA', 'category': 'electronics', 'age_months': 24},
      ),
      FraudNode(
        id: 'ENT-002',
        type: 'merchant',
        name: 'Beta Solutions',
        riskScore: 0.82,
        connections: ['ENT-001', 'ENT-003'],
        attributes: {'region': 'NA', 'category': 'services', 'age_months': 18},
      ),
      FraudNode(
        id: 'ENT-003',
        type: 'merchant',
        name: 'Gamma Corp',
        riskScore: 0.79,
        connections: ['ENT-002', 'ENT-004'],
        attributes: {'region': 'EU', 'category': 'consulting', 'age_months': 12},
      ),
      FraudNode(
        id: 'ENT-004',
        type: 'merchant',
        name: 'Delta Inc',
        riskScore: 0.91,
        connections: ['ENT-003', 'ENT-005'],
        attributes: {'region': 'EU', 'category': 'retail', 'age_months': 6},
      ),
      FraudNode(
        id: 'ENT-005',
        type: 'merchant',
        name: 'Epsilon Ltd',
        riskScore: 0.85,
        connections: ['ENT-004', 'ENT-001'],
        attributes: {'region': 'NA', 'category': 'wholesale', 'age_months': 30},
      ),
      FraudNode(
        id: 'ENT-006',
        type: 'customer',
        name: 'Customer A',
        riskScore: 0.45,
        connections: ['ENT-007'],
        attributes: {'region': 'APAC', 'account_age_days': 365, 'vip': false},
      ),
      FraudNode(
        id: 'ENT-007',
        type: 'customer',
        name: 'Customer B',
        riskScore: 0.52,
        connections: ['ENT-006'],
        attributes: {'region': 'APAC', 'account_age_days': 180, 'vip': true},
      ),
    ];
  }

  void _generateMockTransactions() {
    _transactions = [
      Transaction(
        id: 'TXN-001',
        fromEntity: 'ENT-001',
        toEntity: 'ENT-002',
        amount: 15000.0,
        currency: 'USD',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        status: 'flagged',
        flaggedReason: 'Circular payment pattern',
      ),
      Transaction(
        id: 'TXN-002',
        fromEntity: 'ENT-002',
        toEntity: 'ENT-003',
        amount: 12000.0,
        currency: 'USD',
        timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        status: 'flagged',
        flaggedReason: 'Circular payment pattern',
      ),
      Transaction(
        id: 'TXN-003',
        fromEntity: 'ENT-003',
        toEntity: 'ENT-004',
        amount: 18000.0,
        currency: 'EUR',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'flagged',
        flaggedReason: 'Circular payment pattern',
      ),
      Transaction(
        id: 'TXN-004',
        fromEntity: 'ENT-004',
        toEntity: 'ENT-005',
        amount: 14000.0,
        currency: 'EUR',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
        status: 'flagged',
        flaggedReason: 'Circular payment pattern',
      ),
      Transaction(
        id: 'TXN-005',
        fromEntity: 'ENT-005',
        toEntity: 'ENT-001',
        amount: 16000.0,
        currency: 'USD',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        status: 'flagged',
        flaggedReason: 'Circular payment pattern',
      ),
      Transaction(
        id: 'TXN-006',
        fromEntity: 'ENT-006',
        toEntity: 'ENT-007',
        amount: 5000.0,
        currency: 'USD',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        status: 'cleared',
        flaggedReason: null,
      ),
      Transaction(
        id: 'TXN-007',
        fromEntity: 'ENT-007',
        toEntity: 'ENT-006',
        amount: 5000.0,
        currency: 'USD',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        status: 'cleared',
        flaggedReason: null,
      ),
    ];
  }

  List<FraudAlert> getAlertsByStatus(String status) {
    return _alerts.where((alert) => alert.status == status).toList();
  }

  List<FraudRing> getRingsByMinConfidence(double minConfidence) {
    return _rings.where((ring) => ring.confidenceScore >= minConfidence).toList();
  }

  List<FraudNode> getNodesByMinRiskScore(double minRiskScore) {
    return _nodes.where((node) => node.riskScore >= minRiskScore).toList();
  }

  List<Transaction> getTransactionsByStatus(String status) {
    return _transactions.where((txn) => txn.status == status).toList();
  }

  FraudNode? getNodeById(String id) {
    try {
      return _nodes.firstWhere((node) => node.id == id);
    } catch (e) {
      return null;
    }
  }

  List<FraudNode> getConnectedNodes(String nodeId) {
    final node = getNodeById(nodeId);
    if (node == null) return [];
    return node.connections.map((id) => getNodeById(id)).whereType<FraudNode>().toList();
  }
}
