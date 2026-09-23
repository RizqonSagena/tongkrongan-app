import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AdminNotificationsScreen extends StatelessWidget {
  const AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'icon': Icons.restaurant_menu,
        'title': 'Permintaan Menu Baru',
        'subtitle': 'Morning Bakery meminta penambahan menu',
        'time': '5 mnt lalu',
        'color': AppTheme.secondary,
        'read': false,
      },
      {
        'icon': Icons.star_rate,
        'title': 'Ulasan Baru',
        'subtitle': 'Customer memberikan ulasan pada Selasar Kopi',
        'time': '20 mnt lalu',
        'color': AppTheme.tertiary,
        'read': false,
      },
      {
        'icon': Icons.feedback_outlined,
        'title': 'Kritik Customer',
        'subtitle': 'Customer mengirimkan kritik untuk sebuah toko',
        'time': '1 jam lalu',
        'color': AppTheme.error,
        'read': true,
      },
      {
        'icon': Icons.storefront,
        'title': 'Kedai Baru',
        'subtitle': 'Ada kedai baru yang menunggu verifikasi',
        'time': '2 jam lalu',
        'color': AppTheme.primary,
        'read': true,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppTheme.margin),
                itemCount: notifications.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppTheme.spaceSm),
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return _buildNotificationItem(context, notif);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: AppTheme.spaceMd,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: AppTheme.onSurface),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Text(
            'Notifikasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Semua notifikasi telah ditandai dibaca')),
              );
            },
            child: Text(
              'Tandai Semua Dibaca',
              style: TextStyle(
                color: AppTheme.secondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    Map<String, dynamic> notif,
  ) {
    final bool isUnread = !(notif['read'] as bool);

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${notif['title']}: ${notif['subtitle']}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isUnread
              ? AppTheme.secondary.withValues(alpha: 0.05)
              : AppTheme.surfaceContainerLowest,
          border: Border.all(
            color: isUnread
                ? AppTheme.secondary.withValues(alpha: 0.3)
                : AppTheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: (notif['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(
                notif['icon'] as IconData,
                color: notif['color'] as Color,
                size: 20,
              ),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notif['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isUnread ? FontWeight.w700 : FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notif['subtitle'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notif['time'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isUnread)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
