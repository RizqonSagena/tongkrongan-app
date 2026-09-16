import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class StoreManagementScreen extends StatefulWidget {
  const StoreManagementScreen({super.key});

  @override
  State<StoreManagementScreen> createState() => _StoreManagementScreenState();
}

class _StoreManagementScreenState extends State<StoreManagementScreen> {
  String _selectedStatus = 'semua';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _stores = [
    {
      'image': 'https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=200&h=200&fit=crop',
      'name': 'Selasar Kopi & Ruang Diskusi',
      'type': 'Coffee Shop & Coworking',
      'location': 'Tebet, Jaks.',
      'rating': 4.8,
      'status': 'aktif',
      'verified': true,
      'updateTime': '14:20',
      'owner': 'Dimas Prasetyo (Owner)',
      'followers': 28,
      'checkins': 6,
      'comments': 1,
    },
    {
      'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=200&h=200&fit=crop',
      'name': 'Kala Kopi & Ruang Cerita',
      'type': 'Specialty Coffee',
      'location': 'Tebet Barat',
      'rating': 4.7,
      'status': 'aktif',
      'verified': true,
      'updateTime': '19:40',
      'owner': 'Sarah Amalia (Owner)',
      'followers': 19,
      'checkins': 8,
      'comments': 0,
    },
    {
      'image': 'https://images.unsplash.com/photo-1521017973422-fbb20404019c?w=200&h=200&fit=crop',
      'name': 'Kopi Titik Temu Senja',
      'type': 'Rooftop Coffee & Eatery',
      'location': 'Pancoran',
      'rating': 4.5,
      'status': 'review',
      'verified': false,
      'updateTime': '2 jam lalu',
      'owner': 'Reza Fahmi',
      'followers': 0,
      'checkins': 0,
      'comments': 0,
      'note': 'Catatan Tim Kurator: Foto operai dan menu lengkap sudah diupiah, butuh cek legalitas kemittraan dan surat domisili usaha.',
    },
    {
      'image': 'https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=200&h=200&fit=crop',
      'name': 'Warkop Barokah 24 Jam',
      'type': 'Warkop Modern',
      'location': 'Manggrai',
      'rating': 0,
      'status': 'nonaktif',
      'verified': false,
      'updateTime': 'Libur Renovasi',
      'owner': 'Unknown',
      'followers': 0,
      'checkins': 0,
      'comments': 0,
      'note': 'Kunjungan publik di-pause sementara',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredStores = _filterStores();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title & Subtitle
                          Text(
                            'Manajemen Listing Kedai',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kelola kurasi, info operasional, dan status publikasi kedai mitra',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Add Store Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.secondary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppTheme.spaceSm,
                                ),
                              ),
                              icon: const Icon(Icons.add),
                              label: const Text('+ Tambah Kedai Baru'),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Search Bar
                          _buildSearchBar(context),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Status Tabs
                          _buildStatusTabs(context),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Verification Status
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spaceSm,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.tertiary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.verified,
                                  size: 14,
                                  color: AppTheme.tertiary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Terverifikasi kurator: 94% spot',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    color: AppTheme.tertiary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    'Panduan Kurasi >',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                      color: AppTheme.error,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Stores List
                          if (filteredStores.isEmpty)
                            _buildEmptyState(context)
                          else
                            Column(
                              children: List.generate(
                                filteredStores.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppTheme.spaceMd,
                                  ),
                                  child: _buildStoreCard(
                                    context,
                                    filteredStores[index],
                                  ),
                                ),
                              ),
                            ),
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
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OPERATOR PORTAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Kedai',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Cari nama kedai, area, atau nama owner...',
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.onSurfaceVariant,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.tune),
            color: AppTheme.onSurfaceVariant,
            onPressed: () {},
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: AppTheme.spaceSm),
        ),
      ),
    );
  }

  Widget _buildStatusTabs(BuildContext context) {
    final statuses = [
      {'label': 'Semua', 'value': 'semua', 'count': '142'},
      {'label': 'Aktif', 'value': 'aktif', 'count': '128'},
      {'label': 'Menunggu Review', 'value': 'review', 'count': '8'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          statuses.length,
          (index) {
            final status = statuses[index];
            final isSelected = _selectedStatus == status['value'];

            return Padding(
              padding: EdgeInsets.only(right: index < statuses.length - 1 ? 8 : 0),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _selectedStatus = status['value'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.secondary
                        : AppTheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    boxShadow: isSelected ? [AppTheme.shadowSm] : null,
                  ),
                  child: Row(
                    children: [
                      Text(
                        status['label'] as String,
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isSelected
                              ? AppTheme.onSecondary
                              : AppTheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.onSecondary.withValues(alpha: 0.2)
                              : AppTheme.outlineVariant,
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        ),
                        child: Text(
                          status['count'] as String,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: isSelected
                                ? AppTheme.onSecondary
                                : AppTheme.onSurface,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spaceLg),
        child: Column(
          children: [
            Icon(Icons.store_outlined, size: 48, color: AppTheme.onSurfaceVariant),
            const SizedBox(height: AppTheme.spaceMd),
            Text('Tidak ada kedai', style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreCard(BuildContext context, Map<String, dynamic> store) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store Header with Image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                child: Image.network(
                  store['image'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: AppTheme.surfaceContainer,
                    child: Icon(Icons.image, color: AppTheme.onSurfaceVariant),
                  ),
                ),
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
                            store['name'],
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (store['verified'])
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.tertiary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 12,
                                  color: AppTheme.tertiary,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  'Aktif / Terverifikasi',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    color: AppTheme.tertiary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      store['type'],
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 12, color: AppTheme.onSurfaceVariant),
                        const SizedBox(width: 2),
                        Text(
                          store['location'],
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (store['rating'] > 0)
                      Row(
                        children: [
                          Icon(Icons.star, size: 14, color: AppTheme.secondary),
                          const SizedBox(width: 2),
                          Text(
                            '${store['rating']}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.onSurface,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Update ${store['updateTime']}',
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
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),

          // Owner & Stats
          Row(
            children: [
              Icon(Icons.person, size: 14, color: AppTheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                store['owner'],
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Icon(Icons.close, size: 14, color: AppTheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                '${store['followers']}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.check_circle, size: 14, color: AppTheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                '${store['checkins']}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.comment, size: 14, color: AppTheme.onSurfaceVariant),
              const SizedBox(width: 2),
              Text(
                '${store['comments']}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          if (store['note'] != null) ...[
            const SizedBox(height: AppTheme.spaceMd),
            Container(
              padding: const EdgeInsets.all(AppTheme.spaceSm),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                border: Border.all(
                  color: AppTheme.secondary.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Text(
                '📝 Catatan Tim Kurator:\n${store['note']}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ],

          const SizedBox(height: AppTheme.spaceMd),

          // Action Buttons
          if (store['status'] == 'aktif')
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Detail'),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondary,
                    ),
                    child: const Text('Edit Info'),
                  ),
                ),
              ],
            )
          else if (store['status'] == 'review')
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Tolak / Revisi'),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondary,
                    ),
                    child: const Text('Periksa & Verifikasi'),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Lihat Detail',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.tertiary,
                  ),
                  child: const Text('Aktifkan'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filterStores() {
    var filtered = _stores;

    // Filter by status
    if (_selectedStatus == 'aktif') {
      filtered = filtered.where((s) => s['status'] == 'aktif').toList();
    } else if (_selectedStatus == 'review') {
      filtered = filtered.where((s) => s['status'] == 'review').toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((s) =>
              s['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s['owner'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s['location'].toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }
}