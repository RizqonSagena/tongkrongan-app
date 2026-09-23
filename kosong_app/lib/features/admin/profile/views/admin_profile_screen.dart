import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import 'admin_reviews_screen.dart';
import 'admin_activity_screen.dart';
import '../../../admin/product_management/views/menu_request_screen.dart';
import '../../../admin/notifications/views/admin_notifications_screen.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildProfileCard(context),
              const SizedBox(height: AppTheme.spaceMd),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.margin,
                ),
                child: Divider(color: AppTheme.outlineVariant),
              ),
              const SizedBox(height: AppTheme.spaceSm),
              _buildMenuItems(context),
              const SizedBox(height: AppTheme.spaceLg),
            ],
          ),
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
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Profil Admin',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pengaturan segera hadir'),
                ),
              );
            },
            icon: Icon(Icons.settings_outlined, color: AppTheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.margin),
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary.withValues(alpha: 0.1),
            AppTheme.secondary.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
      ),
      child: Column(
        children: [
          // Avatar
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: AppTheme.primary,
                child: Icon(
                  Icons.admin_panel_settings,
                  size: 44,
                  color: AppTheme.onPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.surfaceContainerLowest,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  size: 12,
                  color: AppTheme.onTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),

          // Name & role
          Text(
            'Ahmad Fauzi',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Administrator',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),

          // Active badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.tertiary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              border: Border.all(
                color: AppTheme.tertiary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Aktif',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),

          // Contact info
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Column(
              children: [
                _buildContactRow(
                  context,
                  Icons.email_outlined,
                  'admin@tongkrongan.id',
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Divider(height: 1, color: AppTheme.outlineVariant),
                const SizedBox(height: AppTheme.spaceSm),
                _buildContactRow(
                  context,
                  Icons.phone_outlined,
                  '+62 812 3456 7890',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context,
    IconData icon,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.secondary),
        const SizedBox(width: AppTheme.spaceSm),
        Text(
          value,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItems(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.rate_review_outlined,
        'title': 'Respon & Ulasan',
        'subtitle': 'Kelola ulasan dan respons customer',
        'color': AppTheme.primary,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminReviewsScreen(),
              ),
            ),
      },
      {
        'icon': Icons.restaurant_menu_outlined,
        'title': 'Permintaan Menu',
        'subtitle': 'Tinjau dan setujui permintaan menu owner',
        'color': AppTheme.secondary,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const MenuRequestScreen(),
              ),
            ),
      },
      {
        'icon': Icons.history,
        'title': 'Aktivitas Admin',
        'subtitle': 'Riwayat tindakan yang telah dilakukan',
        'color': AppTheme.tertiary,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminActivityScreen(),
              ),
            ),
      },
      {
        'icon': Icons.notifications_outlined,
        'title': 'Notifikasi',
        'subtitle': 'Lihat semua notifikasi sistem',
        'color': AppTheme.primary,
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AdminNotificationsScreen(),
              ),
            ),
      },
      {
        'icon': Icons.manage_accounts_outlined,
        'title': 'Pengaturan Akun',
        'subtitle': 'Ubah kata sandi dan preferensi',
        'color': AppTheme.secondary,
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Pengaturan Akun segera hadir')),
            ),
      },
      {
        'icon': Icons.help_outline,
        'title': 'Bantuan',
        'subtitle': 'Panduan dan FAQ untuk admin',
        'color': AppTheme.tertiary,
        'onTap': () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Bantuan segera hadir')),
            ),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
      child: Column(
        children: menuItems.asMap().entries.map((entry) {
          final item = entry.value;
          return Column(
            children: [
              _buildMenuItem(
                context,
                icon: item['icon'] as IconData,
                title: item['title'] as String,
                subtitle: item['subtitle'] as String,
                color: item['color'] as Color,
                onTap: item['onTap'] as VoidCallback,
              ),
              if (entry.key < menuItems.length - 1)
                Divider(
                  height: 1,
                  color: AppTheme.outlineVariant.withValues(alpha: 0.5),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 0,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Icon(icon, size: 20, color: color),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.onSurface,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppTheme.onSurfaceVariant,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: AppTheme.onSurfaceVariant,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
