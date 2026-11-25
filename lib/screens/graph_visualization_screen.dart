import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../models/fraud_node.dart';

class GraphVisualizationScreen extends StatelessWidget {
  const GraphVisualizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Network Graph'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showLegend(context);
            },
          ),
        ],
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.nodes.isEmpty) {
            return const Center(
              child: Text('No nodes to display'),
            );
          }

          return CustomPaint(
            size: Size.infinite,
            painter: GraphPainter(
              nodes: appState.nodes,
              getNodeById: appState.getNodeById,
            ),
          );
        },
      ),
    );
  }

  void _showLegend(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Graph Legend'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _legendItem('Merchant', Colors.blue),
            _legendItem('Customer', Colors.green),
            _legendItem('High Risk (>0.8)', Colors.red),
            _legendItem('Medium Risk (0.5-0.8)', Colors.orange),
            _legendItem('Low Risk (<0.5)', Colors.grey),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}

class GraphPainter extends CustomPainter {
  final List<FraudNode> nodes;
  final FraudNode? Function(String) getNodeById;

  GraphPainter({
    required this.nodes,
    required this.getNodeById,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width < size.height ? size.width * 0.35 : size.height * 0.35;

    final nodePositions = <String, Offset>{};

    for (int i = 0; i < nodes.length; i++) {
      final angle = (2 * math.pi * i) / nodes.length;
      final x = centerX + radius * math.cos(angle);
      final y = centerY + radius * math.sin(angle);
      nodePositions[nodes[i].id] = Offset(x, y);
    }

    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (final node in nodes) {
      for (final connectionId in node.connections) {
        final startPos = nodePositions[node.id];
        final endPos = nodePositions[connectionId];

        if (startPos != null && endPos != null) {
          paint.color = Colors.grey.withValues(alpha: 0.5);
          canvas.drawLine(startPos, endPos, paint);
        }
      }
    }

    for (final node in nodes) {
      final pos = nodePositions[node.id];
      if (pos == null) continue;

      final nodeColor = _getNodeColor(node);
      final nodeRadius = _getNodeRadius(node);

      final circlePaint = Paint()
        ..color = nodeColor
        ..style = PaintingStyle.fill;

      canvas.drawCircle(pos, nodeRadius, circlePaint);

      final borderPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      canvas.drawCircle(pos, nodeRadius, borderPaint);

      final textPainter = TextPainter(
        text: TextSpan(
          text: node.name,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          pos.dx - textPainter.width / 2,
          pos.dy + nodeRadius + 4,
        ),
      );
    }
  }

  Color _getNodeColor(FraudNode node) {
    if (node.riskScore >= 0.8) {
      return Colors.red;
    } else if (node.riskScore >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  double _getNodeRadius(FraudNode node) {
    return 20.0 + (node.riskScore * 15);
  }

  @override
  bool shouldRepaint(GraphPainter oldDelegate) {
    return oldDelegate.nodes != nodes;
  }
}
