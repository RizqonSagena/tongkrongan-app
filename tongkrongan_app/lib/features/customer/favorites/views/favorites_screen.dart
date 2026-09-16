import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with SingleTickerProviderStateMixin {
  String selectedFilter = 'all';
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<Map<String, dynamic>> favorites = [
    {
      'name': 'Selasar Kopi & Ruang Diskusi',
      'location': 'Jl. Tebet Timur Dalam No. 42, Jakarta Selatan',
      'distance': '1.1 km',
      'rating': 4.8,
      'status': 'open',
      'openUntil': '23.00',
      'isFavorite': true,
      'image':
          'https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?w=400&h=250&fit=crop',
      'category': 'Coffee Shop',
      'tags': ['Colokan Melimpah', 'WiFi Kencang', '\$\$'],
    },
    {
      'name': 'Warkop Warmindo 24/7 Mas Bowo',
      'location': 'Jl. Tebet Barat Dalam, Jakarta Selatan',
      'distance': '800 m',
      'rating': 4.6,
      'status': 'open',
      'openUntil': '24 Jam',
      'isFavorite': true,
      'image':
          'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=400&h=250&fit=crop',
      'category': 'Warkop Modern',
      'tags': ['Nasi Telur Kornet', 'Nongkrong Malam', '\$'],
    },
    {
      'name': 'Dapur Rooftop Senja',
      'location': 'Jl. Pancoran, Jakarta Selatan',
      'distance': '1.8 km',
      'rating': 4.7,
      'status': 'closed',
      'openUntil': '19.00 Besok',
      'isFavorite': true,
      'image':
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400&h=250&fit=crop',
      'category': 'Rooftop Lounge',
      'tags': ['Live Acoustic', 'Outdoor Sunset', 'Parkir'],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: false);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredFavorites = _filterFavorites();
    final isEmpty = filteredFavorites.isEmpty;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with backdrop blur
            _buildHeader(context),
            
            // Content
            Expanded(
              child: isEmpty
                  ? _buildEmptyState(context)
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Filter Chips
                          _buildFilterChips(context),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Results Header
                          _buildResultsHeader(context, filteredFavorites.length),
                          const SizedBox(height: AppTheme.spaceMd),

                          // Favorites List
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredFavorites.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: AppTheme.spaceMd),
                            itemBuilder: (context, index) {
                              final fav = filteredFavorites[index];
                              return _buildFavoriteCard(context, fav);
                            },
                          ),
                          const SizedBox(height: AppTheme.spaceMd),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Favorit Saya',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Tempat nongkrong andalan kamu',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filterFavorites() {
    switch (selectedFilter) {
      case 'open':
        return favorites.where((f) => f['status'] == 'open').toList();
      case 'closed':
        return favorites.where((f) => f['status'] == 'closed').toList();
      default:
        return favorites;
    }
  }

  Widget _buildFilterChips(BuildContext context) {
    final allCount = favorites.length;
    final openCount =
        favorites.where((f) => f['status'] == 'open').length;
    final closedCount =
        favorites.where((f) => f['status'] == 'closed').length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('all', 'Semua', allCount),
          const SizedBox(width: AppTheme.spaceSm),
          _buildFilterChip('open', 'Buka Sekarang', openCount),
          const SizedBox(width: AppTheme.spaceSm),
          _buildFilterChip('closed', 'Tutup / Terkendala', closedCount),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String value, String label, int count) {
    final isSelected = selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: isSelected ? [AppTheme.shadowSm] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? AppTheme.onPrimary : AppTheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.onPrimary.withValues(alpha: 0.2)
                    : AppTheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Text(
                count.toString(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? AppTheme.onPrimary
                      : AppTheme.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsHeader(BuildContext context, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Menampilkan $count tempat',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              size: 44,
              color: AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Text(
            'Belum Ada Favorit',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
          const SizedBox(height: AppTheme.spaceXs),
          Text(
            'Tambahkan tempat nongkrong favoritmu',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spaceLg),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/explore');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.onPrimary,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceMd,
                vertical: AppTheme.spaceXs,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
            ),
            child: const Text('Jelajahi Tempat'),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Map<String, dynamic> fav) {
    final isOpen = fav['status'] == 'open';
    return GestureDetector(
      onTap: () {
        // Navigate to detail
      },
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: AppTheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXl),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with overlay, status, favorite, and rating
            _buildImageSection(context, fav, isOpen),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Distance
                  _buildTitleSection(context, fav),
                  const SizedBox(height: AppTheme.spaceXs),

                  // Location
                  _buildLocationSection(context, fav),
                  const SizedBox(height: AppTheme.spaceSm),

                  // Tags
                  _buildTagsSection(context, fav),
                  const SizedBox(height: AppTheme.spaceSm),

                  // Action row
                  _buildActionRow(context, fav, isOpen),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, Map<String, dynamic> fav,
      bool isOpen) {
    return Container(
      height: 176,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusXl),
        ),
      ),
      child: Stack(
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppTheme.radiusXl),
            ),
            child: Image.network(
              fav['image'],
              width: double.infinity,
              height: 176,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: AppTheme.surfaceContainer,
                  child: const Center(
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.surfaceContainer,
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: AppTheme.outline,
                  ),
                );
              },
            ),
          ),

          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusXl),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.40),
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.10),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // Status Pill (top-left)
          Positioned(
            top: AppTheme.spaceSm,
            left: AppTheme.spaceSm,
            child: _buildStatusPill(context, fav, isOpen),
          ),

          // Favorite Button (top-right)
          Positioned(
            top: AppTheme.spaceSm,
            right: AppTheme.spaceSm,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest.withValues(alpha: 0.90),
                shape: BoxShape.circle,
                boxShadow: [AppTheme.shadowMd],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: const Icon(
                    Icons.favorite,
                    size: 18,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),
          ),

          // Rating (bottom-right)
          Positioned(
            bottom: AppTheme.spaceSm,
            right: AppTheme.spaceSm,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.secondaryFixed,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                boxShadow: [AppTheme.shadowSm],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: AppTheme.secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    fav['rating'].toString(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.onSecondaryFixed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(BuildContext context, Map<String, dynamic> fav,
      bool isOpen) {
    final backgroundColor =
        isOpen ? AppTheme.tertiaryFixed : AppTheme.surfaceContainer;
    final textColor = isOpen
        ? AppTheme.onTertiaryFixed
        : AppTheme.onSurfaceVariant;

    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        boxShadow: [AppTheme.shadowMd],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isOpen)
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.tertiary,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              },
            )
          else
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppTheme.outline,
                shape: BoxShape.circle,
              ),
            ),
          const SizedBox(width: 6),
          Text(
            isOpen ? 'Buka s/d ${fav['openUntil']}' : 'Tutup',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, Map<String, dynamic> fav) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            fav['name'],
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: AppTheme.spaceSm),
        Text(
          fav['distance'],
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: AppTheme.secondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context, Map<String, dynamic> fav) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 16,
          color: AppTheme.primary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            fav['location'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTagsSection(BuildContext context, Map<String, dynamic> fav) {
    final tags = fav['tags'] as List<String>;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          tags.length,
          (index) => Padding(
            padding: EdgeInsets.only(
              right: index < tags.length - 1 ? AppTheme.spaceXs : 0,
            ),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Text(
                tags[index],
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionRow(BuildContext context, Map<String, dynamic> fav,
      bool isOpen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isOpen ? AppTheme.tertiary : AppTheme.outline,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                isOpen ? 'Buka Sekarang' : 'Sedang Tutup',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: isOpen ? AppTheme.tertiary : AppTheme.outline,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Navigate to detail
          },
          icon: const Icon(Icons.arrow_forward, size: 14),
          label: const Text('Lihat'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.onPrimary,
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
          ),
        ),
      ],
    );
  }
}