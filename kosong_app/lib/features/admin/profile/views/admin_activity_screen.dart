import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AdminActivityScreen extends StatelessWidget {
  const AdminActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> activities = [
      {
        'icon': Icons.verified_user,
        'action': 'Admin memverifikasi Kedai Kopi Titik Temu',
        'detail': 'Verifikasi dokumen dan foto berhasil disetujui',
        'time': '10 mnt lalu',
        'color': AppTheme.tertiary,
        'category': 'Verifikasi',
      },
      {
        'icon': Icons.restaurant_menu,
        'action': 'Admin menambahkan menu Croissant Cokelat ke Morning Bakery',
        'detail': 'Menu baru ditambahkan ke katalog dengan harga Rp18.000',
        'time': '25 mnt lalu',
        'color': AppTheme.secondary,
        'category': 'Menu',
      },
      {
        'icon': Icons.reply,
        'action': 'Admin membalas kritik customer',
        'detail': 'Merespons kritik dari pelanggan terkait layanan WiFi',
        'time': '1 jam lalu',
        'color': AppTheme.primary,
        'category': 'Support',
      },
      {
        'icon': Icons.campaign,
        'action': 'Admin mempublikasikan Promo Weekend Special',
        'detail': 'Konten promo diterbitkan ke platform Instagram dan Facebook',
        'time': '2 jam lalu',
        'color': AppTheme.secondary,
        'category': 'Konten',
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
                itemCount: activities.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppTheme.spaceSm),
                itemBuilder: (context, index) {
                  return _buildActivityItem(context, activities[index]);
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
            'Aktivitas Admin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    Map<String, dynamic> activity,
  ) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(activity['detail'] as String)),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          border: Border.all(color: AppTheme.outlineVariant),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: (activity['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(
                activity['icon'] as IconData,
                size: 20,
                color: activity['color'] as Color,
              ),
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['action'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    activity['detail'] as String,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: (activity['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Text(
                    activity['category'] as String,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: activity['color'] as Color,
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  activity['time'] as String,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
