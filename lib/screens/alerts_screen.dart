import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../models/fraud_alert.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fraud Alerts'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _buildFilterChips(),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          List<FraudAlert> filteredAlerts;

          if (_selectedFilter == 'all') {
            filteredAlerts = appState.alerts;
          } else {
            filteredAlerts = appState.getAlertsByStatus(_selectedFilter);
          }

          if (filteredAlerts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No alerts found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredAlerts.length,
            itemBuilder: (context, index) {
              final alert = filteredAlerts[index];
              return _buildAlertCard(alert);
            },
          );
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All', 'all'),
            const SizedBox(width: 8),
            _buildFilterChip('Pending', 'pending'),
            const SizedBox(width: 8),
            _buildFilterChip('Investigating', 'investigating'),
            const SizedBox(width: 8),
            _buildFilterChip('Resolved', 'resolved'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      selectedColor: Colors.blue.withValues(alpha: 0.2),
      checkmarkColor: Colors.blue,
    );
  }

  Widget _buildAlertCard(FraudAlert alert) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(alert.status).withOpacity(0.2),
          child: Icon(
            _getStatusIcon(alert.status),
            color: _getStatusColor(alert.status),
          ),
        ),
        title: Text(
          alert.type,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          _formatTimestamp(alert.timestamp),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        trailing: Chip(
          label: Text(
            '${(alert.riskScore * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 12),
          ),
          backgroundColor: _getRiskColor(alert.riskScore).withValues(alpha: 0.2),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(alert.description),
                const SizedBox(height: 16),
                const Text(
                  'Involved Entities',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: alert.involvedEntities.map((entity) {
                    return Chip(
                      label: Text(
                        entity,
                        style: const TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.grey[200],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          _showEntityDetails(context, alert);
                        },
                        icon: const Icon(Icons.info_outline),
                        label: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _updateAlertStatus(context, alert);
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('Mark Resolved'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Icons.pending;
      case 'investigating':
        return Icons.search;
      case 'resolved':
        return Icons.check_circle;
      default:
        return Icons.help_outline;
    }
  }

  Color _getRiskColor(double riskScore) {
    if (riskScore >= 0.8) {
      return Colors.red;
    } else if (riskScore >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  void _showEntityDetails(BuildContext context, FraudAlert alert) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Entity Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Alert ID: ${alert.id}'),
            const SizedBox(height: 8),
            Text('Type: ${alert.type}'),
            const SizedBox(height: 8),
            Text('Risk Score: ${(alert.riskScore * 100).toStringAsFixed(1)}%'),
            const SizedBox(height: 8),
            Text('Status: ${alert.status}'),
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

  void _updateAlertStatus(BuildContext context, FraudAlert alert) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Alert ${alert.id} marked as resolved'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
