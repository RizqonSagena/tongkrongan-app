import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/router/app_router.dart';

class StockDashboardScreen extends StatelessWidget {
  const StockDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('HPP & Stok'),
        backgroundColor: AppTheme.surfaceContainerLowest,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/owner/stock-history');
            },
            icon: const Icon(Icons.history),
            tooltip: 'Riwayat Stok',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummary(context),
            const SizedBox(height: AppTheme.spaceLg),
            
            _buildActionButtons(context),
            const SizedBox(height: AppTheme.spaceLg),

            Text(
              'Status Stok',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            _buildStockStatus(context),
            const SizedBox(height: AppTheme.spaceLg),

            Text(
              'Produk Terlaris (HPP Aktif)',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: AppTheme.spaceMd),
            _buildTopProducts(context),
            const SizedBox(height: AppTheme.spaceLg),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/owner/stock-input');
        },
        backgroundColor: AppTheme.primary,
        icon: const Icon(Icons.add, color: AppTheme.onPrimary),
        label: const Text(
          'Tambah Stok',
          style: TextStyle(color: AppTheme.onPrimary, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceLg),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  context,
                  'Nilai Stok',
                  'Rp 4.250.000',
                  AppTheme.onPrimary,
                ),
              ),
              Container(width: 1, height: 40, color: AppTheme.onPrimary.withValues(alpha: 0.2)),
              Expanded(
                child: _buildSummaryItem(
                  context,
                  'HPP Rata-rata',
                  'Rp 8.000',
                  AppTheme.onPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceLg),
          Container(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            decoration: BoxDecoration(
              color: AppTheme.onPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Penjualan',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp 5.580.000',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios, color: AppTheme.onPrimary, size: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Est. Keuntungan',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onPrimary.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp 3.100.000',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value, Color textColor) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: textColor.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context,
            icon: Icons.calculate_outlined,
            label: 'Hitung HPP Produk',
            color: AppTheme.tertiary,
            onTap: () {
              Navigator.pushNamed(context, AppRouter.ownerHppMenu);
            },
          ),
        ),
        const SizedBox(width: AppTheme.spaceMd),
        Expanded(
          child: _buildActionButton(
            context,
            icon: Icons.receipt_long_outlined,
            label: 'Riwayat Stok',
            color: AppTheme.secondary,
            onTap: () {
              Navigator.pushNamed(context, '/owner/stock-history');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockStatus(BuildContext context) {
    return Column(
      children: [
        _buildStockItem(
          context,
          name: 'Biji Kopi Arabika',
          stock: '5 kg',
          status: 'Aman',
          statusColor: AppTheme.primary,
        ),
        const SizedBox(height: AppTheme.spaceSm),
        _buildStockItem(
          context,
          name: 'Susu',
          stock: '3 liter',
          status: 'Menipis',
          statusColor: AppTheme.tertiary,
        ),
        const SizedBox(height: AppTheme.spaceSm),
        _buildStockItem(
          context,
          name: 'Gula Aren',
          stock: '0 ml',
          status: 'Habis',
          statusColor: AppTheme.error,
        ),
      ],
    );
  }

  Widget _buildStockItem(BuildContext context, {required String name, required String stock, required String status, required Color statusColor}) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Stok: $stock',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Text(
              'Status: $status',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopProducts(BuildContext context) {
    return Column(
      children: [
        _buildTopProductItem(context, 'Es Kopi Selasar Aren', '310 cup terjual'),
        const SizedBox(height: AppTheme.spaceSm),
        _buildTopProductItem(context, 'Nasi Kulit Sambal Matah', '112 porsi terjual'),
      ],
    );
  }

  Widget _buildTopProductItem(BuildContext context, String name, String sold) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star, color: AppTheme.secondary, size: 20),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sold,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
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
