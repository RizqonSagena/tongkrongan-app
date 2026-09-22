import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/router/app_router.dart';

class HppMenuScreen extends StatefulWidget {
  const HppMenuScreen({super.key});

  @override
  State<HppMenuScreen> createState() => _HppMenuScreenState();
}

class _HppMenuScreenState extends State<HppMenuScreen> {
  // Dummy data - siap dihubungkan ke backend
  // Model: MenuCost { id, menuId, ingredientCost, packagingCost, additionalCost, hpp, sellingPrice, profit, margin, updatedAt }
  final List<Map<String, dynamic>> _menuItems = [
    {
      'id': 'menu-001',
      'name': 'Es Kopi Selasar Aren',
      'sellingPrice': 20000,
      'ingredientCost': 8000,
      'packagingCost': 1000,
      'additionalCost': 500,
      'hpp': 9500,
      'profit': 10500,
      'margin': 52.5,
      'hasHpp': true,
    },
    {
      'id': 'menu-002',
      'name': 'Nasi Kulit Sambal Matah',
      'sellingPrice': 25000,
      'ingredientCost': 12000,
      'packagingCost': 1500,
      'additionalCost': 500,
      'hpp': 14000,
      'profit': 11000,
      'margin': 44.0,
      'hasHpp': true,
    },
    {
      'id': 'menu-003',
      'name': 'Teh Bunga Telang',
      'sellingPrice': 15000,
      'ingredientCost': 0,
      'packagingCost': 0,
      'additionalCost': 0,
      'hpp': 0,
      'profit': 0,
      'margin': 0.0,
      'hasHpp': false,
    },
    {
      'id': 'menu-004',
      'name': 'Roti Bakar Cokelat',
      'sellingPrice': 18000,
      'ingredientCost': 0,
      'packagingCost': 0,
      'additionalCost': 0,
      'hpp': 0,
      'profit': 0,
      'margin': 0.0,
      'hasHpp': false,
    },
  ];

  void _updateMenuHpp(String menuId, Map<String, dynamic> updatedData) {
    setState(() {
      final index = _menuItems.indexWhere((m) => m['id'] == menuId);
      if (index != -1) {
        _menuItems[index] = {..._menuItems[index], ...updatedData};
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HPP & Harga Menu'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppTheme.margin),
        itemCount: _menuItems.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceMd),
        itemBuilder: (context, index) {
          final item = _menuItems[index];
          return _buildMenuCard(context, item);
        },
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic> item) {
    final hasHpp = item['hasHpp'] as bool;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['name'],
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSurface,
                ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Harga jual',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
              ),
              Text(
                'Rp ${_formatNumber(item['sellingPrice'])}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.onSurface,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          if (hasHpp) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'HPP',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                ),
                Text(
                  'Rp ${_formatNumber(item['hpp'])}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Margin',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.tertiary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Text(
                    '${item['margin'].toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.tertiary,
                        ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Text(
                'HPP belum diisi',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
          const SizedBox(height: AppTheme.spaceMd),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  AppRouter.ownerHppCalculator,
                  arguments: item['id'],
                );
                if (result != null && result is Map<String, dynamic>) {
                  _updateMenuHpp(item['id'], result);
                }
              },
              child: Text(hasHpp ? 'Edit' : 'Isi HPP'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}k'.replaceAll('.0k', 'k');
    }
    return number.toString();
  }
}
