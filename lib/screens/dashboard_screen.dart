import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../widgets/stats_card.dart';
import '../widgets/alerts_list_widget.dart';
import '../widgets/rings_list_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fraud Ring Detection Dashboard',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Graph Neural Network Analysis',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: 'Pending Alerts',
                        value: appState.pendingAlertsCount.toString(),
                        icon: Icons.warning_amber_outlined,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        title: 'Investigating',
                        value: appState.investigatingAlertsCount.toString(),
                        icon: Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        title: 'Resolved',
                        value: appState.resolvedAlertsCount.toString(),
                        icon: Icons.check_circle,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        title: 'Fraud Rings',
                        value: appState.rings.length.toString(),
                        icon: Icons.group_work,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StatsCard(
                        title: 'Avg Risk Score',
                        value: (appState.avgRiskScore * 100).toStringAsFixed(1) + '%',
                        icon: Icons.show_chart,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                StatsCard(
                  title: 'Total Value at Risk',
                  value: '\$${appState.totalValueAtRisk / 1000000}M',
                  icon: Icons.account_balance,
                  color: Colors.amber,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Recent Fraud Rings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                RingsListWidget(rings: appState.rings),
                const SizedBox(height: 32),
                const Text(
                  'Recent Alerts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                AlertsListWidget(alerts: appState.alerts),
              ],
            ),
          );
        },
      ),
    );
  }
}
