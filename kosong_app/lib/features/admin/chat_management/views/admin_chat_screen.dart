import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AdminChatScreen extends StatelessWidget {
  const AdminChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tickets = [
      {
        'id': '#TK-001',
        'customer': 'Ahmad Pratama',
        'subject': 'WiFi tidak berfungsi di Selasar Kopi',
        'priority': 'high',
        'status': 'open',
        'time': '5 menit lalu',
      },
      {
        'id': '#TK-002',
        'customer': 'Siti Nurhaliza',
        'subject': 'Pertanyaan tentang promo member',
        'priority': 'medium',
        'status': 'open',
        'time': '1 jam lalu',
      },
      {
        'id': '#TK-003',
        'customer': 'Budi Santoso',
        'subject': 'Masalah pembayaran order sudah diperbaiki',
        'priority': 'low',
        'status': 'resolved',
        'time': '2 jam lalu',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support Tickets'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppTheme.margin),
        itemCount: tickets.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceMd),
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppTheme.spaceMd),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getPriorityColor(ticket['priority']).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    ticket['id'].toString().substring(4),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _getPriorityColor(ticket['priority']),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              title: Text(
                ticket['subject'],
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    ticket['customer'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(ticket['status']).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          ticket['status'] == 'open' ? 'Open' : 'Resolved',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: _getStatusColor(ticket['status']),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ticket['time'],
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: AppTheme.onSurfaceVariant,
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return AppTheme.error;
      case 'medium':
        return AppTheme.secondary;
      case 'low':
        return AppTheme.tertiary;
      default:
        return AppTheme.primary;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return AppTheme.secondary;
      case 'resolved':
        return AppTheme.tertiary;
      default:
        return AppTheme.primary;
    }
  }
}