import 'package:flutter/material.dart';
import '../models/fraud_alert.dart';

class AlertsListWidget extends StatelessWidget {
  final List<FraudAlert> alerts;

  const AlertsListWidget({
    super.key,
    required this.alerts,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'investigating':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text('No alerts available'),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: alerts.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final alert = alerts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStatusColor(alert.status).withOpacity(0.2),
              child: Icon(
                Icons.warning,
                color: _getStatusColor(alert.status),
                size: 20,
              ),
            ),
            title: Text(
              alert.type,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(alert.description),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildBadge('Risk: ${(alert.riskScore * 100).toStringAsFixed(0)}%', Colors.red),
                    const SizedBox(width: 8),
                    _buildBadge(alert.status, _getStatusColor(alert.status)),
                  ],
                ),
              ],
            ),
            trailing: Text(
              _formatTimestamp(alert.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            isThreeLine: true,
          );
        },
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
