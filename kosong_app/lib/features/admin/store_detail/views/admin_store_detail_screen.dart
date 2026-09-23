import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/data/admin_store_data.dart';
import 'admin_store_edit_screen.dart';

class AdminStoreDetailScreen extends StatefulWidget {
  final String storeId;

  const AdminStoreDetailScreen({super.key, required this.storeId});

  @override
  State<AdminStoreDetailScreen> createState() => _AdminStoreDetailScreenState();
}

class _AdminStoreDetailScreenState extends State<AdminStoreDetailScreen> {
  Map<String, dynamic> get _store {
    return AdminStoreData.stores.firstWhere(
      (s) => s['id'] == widget.storeId,
      orElse: () => {},
    );
  }

  final List<Map<String, dynamic>> _menuItems = [
    {'name': 'Kopi Hitam', 'price': 'Rp12.000', 'category': 'Minuman'},
    {'name': 'Es Kopi Susu', 'price': 'Rp18.000', 'category': 'Minuman'},
    {'name': 'Croissant Cokelat', 'price': 'Rp22.000', 'category': 'Pastry'},
    {'name': 'Teh Tarik', 'price': 'Rp10.000', 'category': 'Minuman'},
  ];

  final List<Map<String, dynamic>> _activityHistory = [
    {
      'action': 'Verifikasi Awal',
      'by': 'Admin Budi',
      'time': '3 hari lalu',
      'status': 'selesai',
    },
    {
      'action': 'Update Foto & Lokasi',
      'by': 'Owner',
      'time': '2 hari lalu',
      'status': 'selesai',
    },
    {
      'action': 'Cek Legalitas',
      'by': 'Admin Ahmad',
      'time': '1 hari lalu',
      'status': 'proses',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final store = _store;
    if (store.isEmpty) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              const Expanded(
                child: Center(child: Text('Kedai tidak ditemukan')),
              ),
            ],
          ),
        ),
      );
    }

    final bool isVerified = store['verified'] == true;
    final String status = store['status'] ?? 'review';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Store photo
                    _buildStorePhoto(store),
                    Padding(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Store info
                          _buildStoreInfo(context, store, isVerified),
                          const SizedBox(height: AppTheme.spaceLg),

                          // Description
                          if (store['description'] != null &&
                              (store['description'] as String).isNotEmpty) ...[
                            _buildSection(
                              context,
                              'Deskripsi',
                              _buildDescription(context, store['description']),
                            ),
                            const SizedBox(height: AppTheme.spaceLg),
                          ],

                          // Contact info
                          _buildSection(
                            context,
                            'Info Kontak',
                            _buildContactInfo(context, store),
                          ),
                          const SizedBox(height: AppTheme.spaceLg),

                          // Operational status
                          _buildSection(
                            context,
                            'Status Operasional',
                            _buildOperationalStatus(context, store),
                          ),
                          const SizedBox(height: AppTheme.spaceLg),

                          // Menu list
                          _buildSection(
                            context,
                            'Daftar Menu',
                            _buildMenuList(context),
                          ),
                          const SizedBox(height: AppTheme.spaceLg),

                          // Curator notes
                          if (store['note'] != null) ...[
                            _buildSection(
                              context,
                              'Catatan Kurator',
                              _buildCuratorNote(context, store['note']),
                            ),
                            const SizedBox(height: AppTheme.spaceLg),
                          ],

                          // Rejection reason
                          if (store['rejectionReason'] != null &&
                              (store['rejectionReason'] as String).isNotEmpty) ...[
                            _buildSection(
                              context,
                              'Alasan Penolakan',
                              _buildRejectionNote(
                                  context, store['rejectionReason']),
                            ),
                            const SizedBox(height: AppTheme.spaceLg),
                          ],

                          // Activity history
                          _buildSection(
                            context,
                            'Riwayat Aktivitas',
                            _buildActivityHistory(context),
                          ),
                          const SizedBox(height: AppTheme.spaceLg),

                          // Action buttons
                          _buildActionButtons(context, status, isVerified),
                          const SizedBox(height: AppTheme.spaceLg),
                        ],
                      ),
                    ),
                  ],
                ),
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
          Expanded(
            child: Text(
              'Detail Kedai',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.onSurface,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Menu opsi akan segera hadir')),
              );
            },
            icon: Icon(Icons.more_vert, color: AppTheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildStorePhoto(Map<String, dynamic> store) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Image.network(
        store['image'] ?? '',
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            width: double.infinity,
            height: 200,
            color: AppTheme.surfaceContainer,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppTheme.secondary,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppTheme.surfaceContainer,
          child: Icon(
            Icons.storefront,
            size: 64,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildStoreInfo(
    BuildContext context,
    Map<String, dynamic> store,
    bool isVerified,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  store['name'] ?? '-',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildStatusBadge(context, store['status'] ?? 'review'),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),
          _buildInfoRow(context, Icons.category, store['type'] ?? '-'),
          const SizedBox(height: 4),
          _buildInfoRow(
              context, Icons.location_on, store['location'] ?? '-'),
          const SizedBox(height: 4),
          _buildInfoRow(context, Icons.person, store['owner'] ?? '-'),
          if (store['rating'] != null && (store['rating'] as num) > 0) ...[
            const SizedBox(height: 4),
            _buildInfoRow(
              context,
              Icons.star,
              '${store['rating']} / 5.0',
              iconColor: AppTheme.secondary,
            ),
          ],
          const SizedBox(height: AppTheme.spaceMd),
          if (isVerified)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.tertiary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, size: 14, color: AppTheme.tertiary),
                  const SizedBox(width: 4),
                  Text(
                    'Terverifikasi',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.tertiary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    String label;
    switch (status) {
      case 'aktif':
        color = AppTheme.tertiary;
        label = 'Aktif';
        break;
      case 'review':
        color = AppTheme.secondary;
        label = 'Menunggu Review';
        break;
      default:
        color = AppTheme.onSurfaceVariant;
        label = 'Nonaktif';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String text, {
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: iconColor ?? AppTheme.onSurfaceVariant,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        content,
      ],
    );
  }

  Widget _buildDescription(BuildContext context, String description) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Text(
        description,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppTheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildContactInfo(
      BuildContext context, Map<String, dynamic> store) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        children: [
          _buildContactRow(
              context, Icons.phone, 'Telepon', store['phone'] ?? '-'),
          const Divider(height: AppTheme.spaceMd),
          _buildContactRow(
              context, Icons.email, 'Email', store['email'] ?? '-'),
          const Divider(height: AppTheme.spaceMd),
          _buildContactRow(
              context, Icons.language, 'Instagram', store['instagram'] ?? '-'),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppTheme.secondary),
        const SizedBox(width: AppTheme.spaceSm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOperationalStatus(
    BuildContext context,
    Map<String, dynamic> store,
  ) {
    final openTime = store['openTime'] ?? '-';
    final closeTime = store['closeTime'] ?? '-';
    final hours = (openTime == '-' && closeTime == '-')
        ? '-'
        : '$openTime - $closeTime WIB';

    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        children: [
          _buildOpRow(context, 'Jam Operasional', hours),
          const Divider(height: AppTheme.spaceMd),
          _buildOpRow(
              context, 'Hari Buka', store['openDays'] ?? '-'),
          const Divider(height: AppTheme.spaceMd),
          _buildOpRow(context, 'Kapasitas', store['capacity'] ?? '-'),
          const Divider(height: AppTheme.spaceMd),
          _buildOpRow(
              context, 'Fasilitas', store['facilities'] ?? '-'),
        ],
      ),
    );
  }

  Widget _buildOpRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurface,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        children: List.generate(_menuItems.length, (index) {
          final item = _menuItems[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spaceMd,
                  vertical: AppTheme.spaceSm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] as String,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        Text(
                          item['category'] as String,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      item['price'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (index < _menuItems.length - 1)
                Divider(
                  height: 1,
                  color: AppTheme.outlineVariant,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildCuratorNote(BuildContext context, String note) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.secondary.withValues(alpha: 0.08),
        border: Border.all(color: AppTheme.secondary.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Text(
        '📝 $note',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppTheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildRejectionNote(BuildContext context, String reason) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.error.withValues(alpha: 0.08),
        border: Border.all(color: AppTheme.error.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Text(
        '❌ $reason',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppTheme.error,
        ),
      ),
    );
  }

  Widget _buildActivityHistory(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        children: List.generate(_activityHistory.length, (index) {
          final item = _activityHistory[index];
          final bool isDone = item['status'] == 'selesai';
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                child: Row(
                  children: [
                    Icon(
                      isDone ? Icons.check_circle : Icons.pending,
                      size: 18,
                      color:
                          isDone ? AppTheme.tertiary : AppTheme.secondary,
                    ),
                    const SizedBox(width: AppTheme.spaceSm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['action'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          Text(
                            'oleh ${item['by']} · ${item['time']}',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    color: AppTheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (index < _activityHistory.length - 1)
                Divider(height: 1, color: AppTheme.outlineVariant),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    String status,
    bool isVerified,
  ) {
    if (status == 'aktif') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminStoreEditScreen(
                      store: Map<String, dynamic>.from(_store),
                    ),
                  ),
                );
                if (result == true) setState(() {});
              },
              child: const Text('Edit Info'),
            ),
          ),
          const SizedBox(width: AppTheme.spaceSm),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.tertiary,
              ),
              child: const Text('Terverifikasi'),
            ),
          ),
        ],
      );
    } else if (status == 'review') {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Verifikasi Kedai?'),
                    content: const Text(
                        'Kedai akan diaktifkan dan dapat tampil kepada pengguna.'),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Batal')),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.tertiary),
                        onPressed: () {
                          final idx = AdminStoreData.stores
                              .indexWhere((s) => s['id'] == widget.storeId);
                          if (idx != -1) {
                            AdminStoreData.stores[idx]['status'] = 'aktif';
                            AdminStoreData.stores[idx]['verified'] = true;
                          }
                          Navigator.pop(ctx);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'Kedai berhasil diverifikasi dan diaktifkan!'),
                              backgroundColor: AppTheme.tertiary,
                            ),
                          );
                        },
                        child: const Text('Verifikasi'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.tertiary,
                padding:
                    const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
              ),
              child: const Text('Verifikasi & Aktifkan'),
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final reasonController = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Alasan Penolakan'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Masukkan alasan penolakan:'),
                            const SizedBox(height: 8),
                            TextField(
                              controller: reasonController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText:
                                    'Contoh: Dokumen legalitas belum lengkap.',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMd)),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Batal')),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.error),
                            onPressed: () {
                              final idx = AdminStoreData.stores.indexWhere(
                                  (s) => s['id'] == widget.storeId);
                              if (idx != -1) {
                                AdminStoreData.stores[idx]['status'] =
                                    'nonaktif';
                                AdminStoreData.stores[idx]
                                    ['rejectionReason'] = reasonController.text;
                              }
                              Navigator.pop(ctx);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Pendaftaran kedai ditolak'),
                                  backgroundColor: AppTheme.error,
                                ),
                              );
                            },
                            child: const Text('Tolak Kedai'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Tolak',
                    style: TextStyle(color: AppTheme.error),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    final revisionController = TextEditingController();
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Permintaan Revisi'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Catatan revisi untuk owner:'),
                            const SizedBox(height: 8),
                            TextField(
                              controller: revisionController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText:
                                    'Contoh: Foto toko kurang jelas. Silakan upload foto bagian depan toko.',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppTheme.radiusMd)),
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text('Batal')),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.secondary),
                            onPressed: () {
                              final idx = AdminStoreData.stores.indexWhere(
                                  (s) => s['id'] == widget.storeId);
                              if (idx != -1) {
                                AdminStoreData.stores[idx]['revisionNote'] =
                                    revisionController.text;
                                AdminStoreData.stores[idx]['note'] =
                                    revisionController.text;
                              }
                              Navigator.pop(ctx);
                              setState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'Permintaan revisi terkirim ke owner'),
                                  backgroundColor: AppTheme.secondary,
                                ),
                              );
                            },
                            child: const Text('Kirim Permintaan Revisi'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Minta Revisi'),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Aktifkan Kedai'),
                content: const Text(
                    'Yakin ingin mengaktifkan kembali kedai ini?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Batal')),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondary),
                    onPressed: () {
                      final idx = AdminStoreData.stores
                          .indexWhere((s) => s['id'] == widget.storeId);
                      if (idx != -1) {
                        AdminStoreData.stores[idx]['status'] = 'aktif';
                      }
                      Navigator.pop(ctx);
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Kedai berhasil diaktifkan')),
                      );
                    },
                    child: const Text('Ya, Aktifkan'),
                  ),
                ],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.secondary,
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
          ),
          child: const Text('Aktifkan Kedai'),
        ),
      );
    }
  }
}
