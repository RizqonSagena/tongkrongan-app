import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';
import 'content_form_screen.dart';

class ContentManagementScreen extends StatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  State<ContentManagementScreen> createState() =>
      _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {
  String _selectedFilter = 'Semua';

  final List<String> _filters = ['Semua', 'Promo', 'Article', 'Event'];

  final List<Map<String, dynamic>> _contents = [
    {
      'title': 'Promo Weekend Special',
      'category': 'Promo',
      'status': 'active',
      'date': '15 Sep 2024',
      'description':
          'Dapatkan diskon spesial setiap akhir pekan di kedai mitra pilihan.',
      'image':
          'https://images.unsplash.com/photo-1495521821757-a1efb6729352?w=300&h=150&fit=crop',
    },
    {
      'title': 'Tips Nongkrong yang Aman',
      'category': 'Article',
      'status': 'active',
      'date': '14 Sep 2024',
      'description':
          'Panduan lengkap untuk menikmati waktu santai di tongkrongan favorit.',
      'image':
          'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=300&h=150&fit=crop',
    },
    {
      'title': 'Event Gathering Komunitas',
      'category': 'Event',
      'status': 'pending',
      'date': '13 Sep 2024',
      'description':
          'Bergabunglah bersama komunitas tongkrongan di acara gathering bulan ini.',
      'image':
          'https://images.unsplash.com/photo-1511632765486-a01980e01a18?w=300&h=150&fit=crop',
    },
  ];

  List<Map<String, dynamic>> get _filteredContents {
    if (_selectedFilter == 'Semua') return _contents;
    return _contents
        .where((c) => c['category'] == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: _filteredContents.isEmpty
                  ? _buildEmptyState(context)
                  : ListView(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      children: [
                        _buildFilterTabs(context),
                        const SizedBox(height: AppTheme.spaceMd),
                        ..._filteredContents.asMap().entries.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppTheme.spaceMd,
                                ),
                                child: _buildContentCard(
                                  context,
                                  entry.value,
                                  _contents.indexOf(entry.value),
                                ),
                              ),
                            ),
                      ],
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
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Icon(
                  Icons.content_paste,
                  color: AppTheme.onSecondary,
                  size: 20,
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
                      'Content',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ContentFormScreen(content: null),
                    ),
                  ).then((_) => setState(() {}));
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.asMap().entries.map((entry) {
          final filter = entry.value;
          final isSelected = _selectedFilter == filter;

          return Padding(
            padding: EdgeInsets.only(
              right: entry.key < _filters.length - 1 ? 8 : 0,
            ),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.secondary
                      : AppTheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
                child: Text(
                  filter,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSelected
                        ? AppTheme.onSecondary
                        : AppTheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContentCard(
    BuildContext context,
    Map<String, dynamic> content,
    int index,
  ) {
    final bool isActive = content['status'] == 'active';

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border.all(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image placeholder
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusLg),
              topRight: Radius.circular(AppTheme.radiusLg),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 120,
              child: Image.network(
                content['image'] as String,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppTheme.surfaceContainer,
                  child: Icon(
                    Icons.image_outlined,
                    size: 40,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppTheme.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        content['title'] as String,
                        style:
                            Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.tertiary.withValues(alpha: 0.2)
                            : AppTheme.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isActive ? 'Active' : 'Pending',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: isActive
                              ? AppTheme.tertiary
                              : AppTheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                if ((content['description'] as String?)?.isNotEmpty == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      content['description'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(content['category'] as String),
                      backgroundColor: AppTheme.surfaceContainer,
                      labelStyle: Theme.of(context).textTheme.labelSmall,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                    Text(
                      content['date'] as String,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spaceSm),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ContentFormScreen(content: content),
                            ),
                          ).then((_) => setState(() {}));
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _confirmDelete(context, index),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.error,
                          side: BorderSide(
                            color: AppTheme.error.withValues(alpha: 0.5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 6),
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ContentFormScreen(content: content),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondary,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                        ),
                        child: const Text(
                          'View',
                          style: TextStyle(fontSize: 12),
                        ),
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

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // filter tabs at top
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
            child: _buildFilterTabs(context),
          ),
          const SizedBox(height: AppTheme.spaceLg),
          Icon(
            Icons.content_paste_off,
            size: 48,
            color: AppTheme.onSurfaceVariant,
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Tidak ada konten $_selectedFilter',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Konten'),
        content: Text(
          'Yakin ingin menghapus "${_contents[index]['title']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _contents.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Konten berhasil dihapus')),
              );
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
