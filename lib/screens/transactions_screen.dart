import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_state.dart';
import '../models/transaction.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: _buildFilterChips(),
        ),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          List<Transaction> filteredTransactions;

          if (_selectedFilter == 'all') {
            filteredTransactions = appState.transactions;
          } else {
            filteredTransactions = appState.getTransactionsByStatus(_selectedFilter);
          }

          if (filteredTransactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No transactions found',
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
            itemCount: filteredTransactions.length,
            itemBuilder: (context, index) {
              final transaction = filteredTransactions[index];
              return _buildTransactionCard(transaction);
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
            _buildFilterChip('Flagged', 'flagged'),
            const SizedBox(width: 8),
            _buildFilterChip('Cleared', 'cleared'),
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

  Widget _buildTransactionCard(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(transaction.status).withValues(alpha: 0.2),
          child: Icon(
            _getStatusIcon(transaction.status),
            color: _getStatusColor(transaction.status),
            size: 20,
          ),
        ),
        title: Text(
          '${transaction.fromEntity} → ${transaction.toEntity}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${transaction.currency} ${transaction.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatTimestamp(transaction.timestamp),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            if (transaction.flaggedReason != null) ...[
              const SizedBox(height: 4),
              Text(
                'Flagged: ${transaction.flaggedReason}',
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.red,
                ),
              ),
            ],
          ],
        ),
        trailing: Chip(
          label: Text(
            transaction.status.toUpperCase(),
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
          backgroundColor: _getStatusColor(transaction.status).withOpacity(0.2),
        ),
        isThreeLine: true,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'flagged':
        return Colors.red;
      case 'cleared':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'flagged':
        return Icons.flag;
      case 'cleared':
        return Icons.check_circle;
      case 'pending':
        return Icons.pending;
      default:
        return Icons.help_outline;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
