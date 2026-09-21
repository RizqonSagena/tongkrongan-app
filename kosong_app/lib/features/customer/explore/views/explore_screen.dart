import 'package:flutter/material.dart';

import 'dart:ui';

import '../../../../core/themes/app_theme.dart';
import '../widgets/place_card.dart';
import '../widgets/filter_chips.dart';
import '../widgets/search_bar_widget.dart';
import '../../../../core/data/mock_places.dart';
import '../../../../core/models/place_model.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDistance = '< 1 km';
  String _selectedCategory = '☕ Coffee Shop';
  List<String> _activeFilters = ['Buka Sekarang'];

  List<Place> _places = [];

  @override
  void initState() {
    super.initState();
    _places = mockPlaces;
    _searchController.text = 'kopi dan roti';
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with backdrop blur (alpha 0.85)
            _buildHeader(context),

            // Content with scrolling
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.margin),
                child: Column(
                  children: [
                    // Location Bar (sticky effect with card)
                    _buildLocationBar(context),
                    const SizedBox(height: AppTheme.spaceSm),

                    // Search Input
                    SearchBarWidget(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      onClear: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Distance Filter Chips (Horizontal Scroll)
                    // Category Chips (Horizontal Scroll)
                    // Status Filter Chips (Horizontal Scroll)
                    FilterChips(
                      selectedDistance: _selectedDistance,
                      selectedCategory: _selectedCategory,
                      activeFilters: _activeFilters,
                      onDistanceChanged: (distance) {
                        setState(() {
                          _selectedDistance = distance;
                        });
                      },
                      onCategoryChanged: (category) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      onFilterToggled: (filter) {
                        setState(() {
                          if (_activeFilters.contains(filter)) {
                            _activeFilters.remove(filter);
                          } else {
                            _activeFilters.add(filter);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Results Header with count
                    _buildResultsHeader(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Place Cards with proper spacing
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _places.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: AppTheme.spaceMd),
                      itemBuilder: (context, index) {
                        final place = _places[index];
                        return PlaceCard(
                          place: place,
                          onTap: () {
                            // Navigate to place detail
                            Navigator.of(context).pushNamed(
                              '/detail-place',
                              arguments: {'placeId': place.id},
                            );
                          },
                          onFavoriteToggle: () {
                            setState(() {
                              place.isFavorite = !place.isFavorite;
                            });
                          },
                        );
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
              // Logo and App Name
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                      ),
                      child: const Icon(
                        Icons.location_on,
                        color: AppTheme.onPrimary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spaceSm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tongkrongan',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          'Tempat Seru Buat Nongkrong',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppTheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Profile Avatar
              GestureDetector(
                onTap: () {
                  // Navigate to profile
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primary.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop&crop=face',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.surfaceContainer,
                          child: const Icon(
                            Icons.person,
                            color: AppTheme.onSurfaceVariant,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
        vertical: AppTheme.spaceXs,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(Icons.near_me, size: 16, color: AppTheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.labelSmall
                          ?.copyWith(color: AppTheme.onSurfaceVariant),
                      children: [
                        const TextSpan(text: 'Di sekitarmu: '),
                        TextSpan(
                          text: 'Tanjung pinang,kepulauan riau',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: AppTheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Handle change location
            },
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Ubah',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                'Menampilkan ${_places.length} tempat seru',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(width: AppTheme.spaceXs),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.4),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppTheme.spaceXs),
              Text(
                'dekatmu',
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: AppTheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: () {
            // Handle sort
          },
          icon: const Icon(Icons.tune, size: 16),
          label: const Text('Urutkan'),
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.onSurfaceVariant,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
