import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(context),

              // Hero Card with Profile Info
              _buildHeroCard(context),

              // Stats Grid
              _buildStatsGrid(context),

              const SizedBox(height: AppTheme.spaceLg),

              // Menu Sections
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.margin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Account Section
                    _buildSectionHeader(context, 'Akun'),
                    const SizedBox(height: AppTheme.spaceSm),
                    _buildMenuCard(
                      context,
                      [
                        _buildMenuItem(
                          context,
                          Icons.person,
                          'Edit Profil',
                          () {},
                        ),
                        Divider(
                          height: 1,
                          color: AppTheme.outlineVariant,
                        ),
                        _buildMenuItem(
                          context,
                          Icons.verified_user,
                          'Verifikasi Akun',
                          () {},
                        ),
                        Divider(
                          height: 1,
                          color: AppTheme.outlineVariant,
                        ),
                        _buildMenuItem(
                          context,
                          Icons.security,
                          'Keamanan & Privasi',
                          () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Preferences Section
                    _buildSectionHeader(context, 'Preferensi'),
                    const SizedBox(height: AppTheme.spaceSm),
                    _buildMenuCard(
                      context,
                      [
                        _buildToggleMenuItem(
                          context,
                          Icons.notifications_active,
                          'Notifikasi Push',
                          _notificationsEnabled,
                          (value) {
                            setState(() => _notificationsEnabled = value);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: AppTheme.outlineVariant,
                        ),
                        _buildToggleMenuItem(
                          context,
                          Icons.dark_mode,
                          'Mode Gelap',
                          _darkModeEnabled,
                          (value) {
                            setState(() => _darkModeEnabled = value);
                          },
                        ),
                        Divider(
                          height: 1,
                          color: AppTheme.outlineVariant,
                        ),
                        _buildMenuItem(
                          context,
                          Icons.language,
                          'Bahasa',
                          () {},
                          showBadge: 'Indonesia',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Support Section
                    _buildSectionHeader(context, 'Bantuan & Dukungan'),
                    const SizedBox(height: AppTheme.spaceSm),
                    _buildMenuCard(
                      context,
                      [
                        _buildMenuItem(
                          context,
                          Icons.help_outline,
                          'Pusat Bantuan',
                          () {},
                        ),
                        Divider(
                          height: 1,
                          color: AppTheme.outlineVariant,
                        ),
                        _buildMenuItem(
                          context,
                          Icons.bug_report,
                          'Laporkan Bug',
                          () {},
                        ),
                        Divider(
                          height: 1,
                          color: AppTheme.outlineVariant,
                        ),
                        _buildMenuItem(
                          context,
                          Icons.info_outline,
                          'Tentang Aplikasi',
                          () {},
                          showBadge: 'v1.0.0',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spaceLg),

                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showLogoutModal(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.error,
                          foregroundColor: AppTheme.onError,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.spaceMd,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusFull),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.logout),
                            const SizedBox(width: 8),
                            const Text('Keluar Akun'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spaceLg),
                  ],
                ),
              ),
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
        color: AppTheme.surface.withValues(alpha: 0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profil Saya',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Kelola profil dan pengaturan kamu',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryFixed,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  color: AppTheme.onPrimaryFixed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppTheme.margin),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary,
            AppTheme.primary.withValues(alpha: 0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [AppTheme.shadowLg],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.onPrimary.withValues(alpha: 0.3),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200&h=200&fit=crop&crop=face',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.onPrimary.withValues(alpha: 0.2),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: AppTheme.onPrimary,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Ahmad Pratama',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                        color: AppTheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@ahmadpratama',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.onPrimary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      ),
                      child: Text(
                        'Jakarta Selatan • 28 Tahun',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceMd,
              vertical: AppTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              color: AppTheme.onPrimary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            ),
            child: Text(
              'Pengunjung setia tempat nongkrong dengan rating sempurna ⭐',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatCard(context, '24', 'Dikunjungi'),
          _buildStatCard(context, '12', 'Disimpan'),
          _buildStatCard(context, '45', 'Rating'),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceSm,
          vertical: AppTheme.spaceMd,
        ),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Column(
          children: [
            Text(
              number,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w700,
        color: AppTheme.onSurface,
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: AppTheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap, {
    String? showBadge,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spaceMd,
            vertical: AppTheme.spaceSm,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? AppTheme.primary,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppTheme.onSurface,
                  ),
                ),
              ),
              if (showBadge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                  ),
                  child: Text(
                    showBadge,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: AppTheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleMenuItem(
    BuildContext context,
    IconData icon,
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
        vertical: AppTheme.spaceSm,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppTheme.primary,
            size: 24,
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.onSurface,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primary,
            activeTrackColor: AppTheme.primary.withValues(alpha: 0.3),
            inactiveThumbColor: AppTheme.outline,
            inactiveTrackColor:
                AppTheme.outline.withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  void _showLogoutModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        ),
        title: Text(
          'Keluar Akun?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Apakah kamu yakin ingin keluar dari akun ini? Kamu bisa login kembali kapan saja.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Batal',
              style: TextStyle(color: AppTheme.onSurfaceVariant),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Perform logout
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Berhasil keluar dari akun'),
                  backgroundColor: AppTheme.tertiary,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
              foregroundColor: AppTheme.onError,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }
}