import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/router/app_router.dart';

class OwnerProfileScreen extends StatelessWidget {
  const OwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Bisnis'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Business Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppTheme.primary.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.store, color: AppTheme.primary, size: 32),
                        ),
                        const SizedBox(width: AppTheme.spaceMd),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selasar Kopi',
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Coffee Shop & Eatery',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppTheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spaceMd),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: AppTheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Jl. Tebet Timur Dalam, Jakarta Selatan',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 16, color: AppTheme.onSurfaceVariant),
                        const SizedBox(width: 4),
                        Text(
                          '+62 812-3456-7890',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spaceLg),
            
            // Business Info
            Text(
              'Informasi Bisnis',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            _buildInfoRow(context, 'Status', 'Aktif ✓', AppTheme.tertiary),
            _buildInfoRow(context, 'Terdaftar Sejak', '15 Januari 2023', AppTheme.primary),
            _buildInfoRow(context, 'Rating Keseluruhan', '4.8 (245 rating)', AppTheme.secondary),
            const SizedBox(height: AppTheme.spaceLg),
            const Divider(),
            const SizedBox(height: AppTheme.spaceMd),
            
            // Menu
            _buildMenuItem(context, Icons.settings, 'Pengaturan Bisnis', () {}),
            _buildMenuItem(context, Icons.credit_card, 'Metode Pembayaran', () {}),
            _buildMenuItem(context, Icons.receipt, 'Riwayat Transaksi', () {}),
            _buildMenuItem(context, Icons.calculate, 'HPP & Harga Menu', () {
              Navigator.pushNamed(context, AppRouter.ownerHppMenu);
            }),
            _buildMenuItem(context, Icons.help, 'Bantuan', () {}),
            _buildMenuItem(context, Icons.logout, 'Keluar', () {}, color: AppTheme.error),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, VoidCallback onTap, {Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppTheme.primary),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant),
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
    );
  }
}