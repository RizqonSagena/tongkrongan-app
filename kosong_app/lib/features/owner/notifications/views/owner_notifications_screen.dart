import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class OwnerNotificationsScreen extends StatelessWidget {
  const OwnerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Notifikasi'),
        backgroundColor: AppTheme.surfaceContainerLowest,
        scrolledUnderElevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Tandai Dibaca'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.margin),
        children: [
          _buildNotificationCard(
            context,
            icon: Icons.shopping_bag,
            color: AppTheme.secondary,
            title: 'Pesanan Baru Masuk!',
            subtitle: 'Ada pesanan baru dari Ahmad Pratama (#ORD-042).',
            time: 'Baru saja',
            isUnread: true,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          _buildNotificationCard(
            context,
            icon: Icons.check_circle,
            color: AppTheme.primary,
            title: 'Pesanan Selesai',
            subtitle: 'Pesanan #ORD-041 telah diambil oleh pelanggan.',
            time: '15 mnt lalu',
            isUnread: true,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          _buildNotificationCard(
            context,
            icon: Icons.star,
            color: AppTheme.primaryContainer,
            title: 'Rating Bintang 5',
            subtitle: 'Customer memberikan rating 5 bintang untuk Es Kopi Aren.',
            time: '1 jam lalu',
            isUnread: false,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          _buildNotificationCard(
            context,
            icon: Icons.edit_document,
            color: AppTheme.tertiary,
            title: 'Permintaan Perubahan',
            subtitle: 'Budi mengajukan perubahan jadwal booking.',
            time: '3 jam lalu',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: isUnread ? color.withValues(alpha: 0.05) : AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: isUnread ? color.withValues(alpha: 0.3) : AppTheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: isUnread ? FontWeight.w700 : FontWeight.w600,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant.withValues(alpha: 0.8),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
