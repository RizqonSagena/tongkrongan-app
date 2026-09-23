import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class MenuRequestScreen extends StatefulWidget {
  const MenuRequestScreen({super.key});

  @override
  State<MenuRequestScreen> createState() => _MenuRequestScreenState();
}

class _MenuRequestScreenState extends State<MenuRequestScreen> {
  final List<Map<String, dynamic>> _requests = [
    {
      'store': 'Morning Bakery',
      'menuName': 'Croissant Cokelat',
      'price': 'Rp18.000',
      'category': 'Pastry',
      'status': 'Menunggu Admin',
      'owner': 'Dimas Prasetyo',
      'submittedAt': '2 jam lalu',
    },
    {
      'store': 'Selasar Kopi',
      'menuName': 'Es Kopi Susu Premium',
      'price': 'Rp25.000',
      'category': 'Minuman',
      'status': 'Menunggu Admin',
      'owner': 'Sarah Amalia',
      'submittedAt': '4 jam lalu',
    },
    {
      'store': 'Kala Kopi',
      'menuName': 'Matcha Latte',
      'price': 'Rp22.000',
      'category': 'Minuman',
      'status': 'Disetujui',
      'owner': 'Budi Santoso',
      'submittedAt': '1 hari lalu',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(AppTheme.margin),
                itemCount: _requests.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppTheme.spaceMd),
                itemBuilder: (context, index) {
                  return _buildRequestCard(context, _requests[index], index);
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
            'Permintaan Menu',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            child: Text(
              '${_requests.where((r) => r['status'] == 'Menunggu Admin').length} Pending',
              style: TextStyle(
                fontSize: 11,
                color: AppTheme.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(
    BuildContext context,
    Map<String, dynamic> request,
    int index,
  ) {
    final String status = request['status'] as String;
    final bool isPending = status == 'Menunggu Admin';
    final Color statusColor =
        isPending ? AppTheme.secondary : AppTheme.tertiary;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(
          color: isPending
              ? AppTheme.secondary.withValues(alpha: 0.3)
              : AppTheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['menuName'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${request['store']} · oleh ${request['owner']}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Text(
                  status,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),

          // Details
          Row(
            children: [
              _buildTag(context, request['category'] as String, AppTheme.primary),
              const SizedBox(width: AppTheme.spaceSm),
              _buildTag(context, request['price'] as String, AppTheme.secondary),
              const Spacer(),
              Text(
                request['submittedAt'] as String,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          const Divider(height: 1),
          const SizedBox(height: AppTheme.spaceSm),

          // Actions
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Detail menu: ${request['menuName']}',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: const Text('Detail', style: TextStyle(fontSize: 12)),
                ),
              ),
              if (isPending) ...[
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _showConfirmDialog(
                      context,
                      'Tolak Permintaan',
                      'Yakin menolak permintaan menu "${request['menuName']}"?',
                      () => setState(() {
                        _requests[index]['status'] = 'Ditolak';
                      }),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.error,
                      side: BorderSide(color: AppTheme.error),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: const Text('Tolak', style: TextStyle(fontSize: 12)),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showConfirmDialog(
                      context,
                      'Setujui Menu',
                      'Tambahkan "${request['menuName']}" ke katalog?',
                      () => setState(() {
                        _requests[index]['status'] = 'Disetujui';
                      }),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.tertiary,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: const Text(
                      'Setujui',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ] else ...[
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${request['menuName']} ditambahkan ke katalog',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                    ),
                    child: const Text(
                      'Tambah Katalog',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showConfirmDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }
}
