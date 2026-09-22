import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class StockHistoryScreen extends StatelessWidget {
  const StockHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      appBar: AppBar(
        title: const Text('Riwayat Stok'),
        backgroundColor: AppTheme.surfaceContainerLowest,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.margin),
        children: [
          _buildDateHeader(context, 'Hari Ini, 22 Sep 2026'),
          const SizedBox(height: AppTheme.spaceMd),
          _buildHistoryItem(
            context,
            name: 'Biji Kopi Arabika',
            action: 'Pembelian',
            amount: '+5 kg',
            price: 'Rp 750.000',
            isPositive: true,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          _buildHistoryItem(
            context,
            name: 'Biji Kopi Arabika',
            action: 'Produksi / Penjualan',
            amount: '-500 gram',
            price: '-',
            isPositive: false,
          ),
          const SizedBox(height: AppTheme.spaceLg),
          
          _buildDateHeader(context, 'Kemarin, 21 Sep 2026'),
          const SizedBox(height: AppTheme.spaceMd),
          _buildHistoryItem(
            context,
            name: 'Susu Fresh Milk',
            action: 'Pembelian',
            amount: '+10 liter',
            price: 'Rp 350.000',
            isPositive: true,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          _buildHistoryItem(
            context,
            name: 'Gula Aren',
            action: 'Penyesuaian (Terbuang)',
            amount: '-100 ml',
            price: '-',
            isPositive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(BuildContext context, String date) {
    return Text(
      date,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        color: AppTheme.onSurfaceVariant,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildHistoryItem(
    BuildContext context, {
    required String name,
    required String action,
    required String amount,
    required String price,
    required bool isPositive,
  }) {
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
              color: isPositive
                  ? AppTheme.primary.withValues(alpha: 0.1)
                  : AppTheme.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive ? Icons.add : Icons.remove,
              color: isPositive ? AppTheme.primary : AppTheme.error,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  action,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: isPositive ? AppTheme.primary : AppTheme.error,
                ),
              ),
              if (price != '-') ...[
                const SizedBox(height: 4),
                Text(
                  price,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
