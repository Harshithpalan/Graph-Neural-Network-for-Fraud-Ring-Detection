import 'package:flutter/foundation.dart';
import '../services/fraud_detection_service.dart';
import '../models/fraud_alert.dart';
import '../models/fraud_ring.dart';
import '../models/fraud_node.dart';
import '../models/transaction.dart';

class AppState extends ChangeNotifier {
  final FraudDetectionService _fraudService = FraudDetectionService();

  List<FraudAlert> get alerts => _fraudService.alerts;
  List<FraudRing> get rings => _fraudService.rings;
  List<FraudNode> get nodes => _fraudService.nodes;
  List<Transaction> get transactions => _fraudService.transactions;

  int get pendingAlertsCount => _fraudService.getAlertsByStatus('pending').length;
  int get investigatingAlertsCount => _fraudService.getAlertsByStatus('investigating').length;
  int get resolvedAlertsCount => _fraudService.getAlertsByStatus('resolved').length;

  double get avgRiskScore {
    if (_fraudService.nodes.isEmpty) return 0.0;
    final totalRisk = _fraudService.nodes.fold<double>(0.0, (sum, node) => sum + node.riskScore);
    return totalRisk / _fraudService.nodes.length;
  }

  double get totalValueAtRisk {
    return _fraudService.rings.fold<double>(0.0, (sum, ring) => sum + ring.totalValueAtRisk);
  }

  AppState() {
    _fraudService.initializeMockData();
  }

  FraudNode? getNodeById(String id) {
    return _fraudService.getNodeById(id);
  }

  List<FraudNode> getConnectedNodes(String nodeId) {
    return _fraudService.getConnectedNodes(nodeId);
  }

  List<FraudAlert> getAlertsByStatus(String status) {
    return _fraudService.getAlertsByStatus(status);
  }

  List<Transaction> getTransactionsByStatus(String status) {
    return _fraudService.getTransactionsByStatus(status);
  }
}
