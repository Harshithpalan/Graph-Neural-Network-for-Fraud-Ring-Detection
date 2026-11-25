import 'package:flutter/material.dart';
import '../models/fraud_ring.dart';

class RingsListWidget extends StatelessWidget {
  final List<FraudRing> rings;

  const RingsListWidget({
    super.key,
    required this.rings,
  });

  @override
  Widget build(BuildContext context) {
    if (rings.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Text('No fraud rings detected'),
          ),
        ),
      );
    }

    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: rings.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final ring = rings[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purple.withOpacity(0.2),
              child: Icon(
                Icons.group_work,
                color: Colors.purple,
                size: 20,
              ),
            ),
            title: Text(
              ring.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${ring.size} members • ${(ring.confidenceScore * 100).toStringAsFixed(0)}% confidence'),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: ring.patterns.map((pattern) {
                    return Chip(
                      label: Text(
                        pattern,
                        style: const TextStyle(fontSize: 11),
                      ),
                      backgroundColor: Colors.blue.withOpacity(0.1),
                      visualDensity: VisualDensity.compact,
                    );
                  }).toList(),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${(ring.totalValueAtRisk / 1000).toStringAsFixed(0)}K',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  _formatTimestamp(ring.detectedAt),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          );
        },
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
