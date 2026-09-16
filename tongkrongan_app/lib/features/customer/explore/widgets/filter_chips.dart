import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class FilterChips extends StatelessWidget {
  final String selectedDistance;
  final String selectedCategory;
  final List<String> activeFilters;
  final ValueChanged<String> onDistanceChanged;
  final ValueChanged<String> onCategoryChanged;
  final ValueChanged<String> onFilterToggled;

  const FilterChips({
    super.key,
    required this.selectedDistance,
    required this.selectedCategory,
    required this.activeFilters,
    required this.onDistanceChanged,
    required this.onCategoryChanged,
    required this.onFilterToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Distance Filter (Horizontal Scroll)
        _buildHorizontalFilterSection(
          context,
          title: 'Jarak:',
          icon: Icons.straighten,
          options: ['Semua Jarak', '< 1 km', '1-3 km', '3-5 km', '> 5 km'],
          selectedOption: selectedDistance,
          onOptionSelected: onDistanceChanged,
          isDistanceFilter: true,
        ),
        const SizedBox(height: AppTheme.spaceSm),

        // Category Filter (Horizontal Scroll)
        _buildHorizontalFilterSection(
          context,
          options: [
            '☕ Coffee Shop',
            '🍜 Warkop & Angkringan',
            '🌇 Rooftop & Sunset',
            '🍛 Eatery & Resto UMKM',
            '🍧 Kedai Es & Dessert',
          ],
          selectedOption: selectedCategory,
          onOptionSelected: onCategoryChanged,
          isCategoryFilter: true,
        ),
        const SizedBox(height: AppTheme.spaceSm),

        // Status Filter Chips (Horizontal Scroll)
        _buildStatusFilterChips(context),
      ],
    );
  }

  Widget _buildHorizontalFilterSection(
    BuildContext context, {
    String? title,
    IconData? icon,
    required List<String> options,
    required String selectedOption,
    required ValueChanged<String> onOptionSelected,
    bool isDistanceFilter = false,
    bool isCategoryFilter = false,
  }) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: options.length + (title != null ? 1 : 0),
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          // First item: title label
          if (title != null && index == 0) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 15,
                      color: AppTheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          final optionIndex = title != null ? index - 1 : index;
          final option = options[optionIndex];
          final isSelected = option == selectedOption;

          // Distance filter chip styling
          if (isDistanceFilter) {
            return _buildDistanceFilterChip(
              context,
              option,
              isSelected,
              () => onOptionSelected(option),
            );
          }

          // Category filter chip styling (with emoji support)
          if (isCategoryFilter) {
            return _buildCategoryFilterChip(
              context,
              option,
              isSelected,
              () => onOptionSelected(option),
            );
          }

          return _buildFilterChip(
            context,
            option,
            isSelected,
            () => onOptionSelected(option),
          );
        },
      ),
    );
  }

  Widget _buildDistanceFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: isSelected
              ? [AppTheme.shadowSm]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppTheme.onPrimary
                    : AppTheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Icon(
                Icons.check,
                size: 14,
                color: AppTheme.onPrimary,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primaryFixed
              : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: isSelected
              ? [AppTheme.shadowSm]
              : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: isSelected
                ? AppTheme.onPrimaryFixed
                : AppTheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primary : AppTheme.surfaceContainer,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: isSelected
              ? [AppTheme.shadowSm]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? AppTheme.onPrimary
                    : AppTheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.check,
                size: 14,
                color: AppTheme.onPrimary,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilterChips(BuildContext context) {
    final filters = [
      {
        'label': 'Buka Sekarang',
        'icon': Icons.circle,
        'color': AppTheme.tertiary,
        'type': 'status'
      },
      {
        'label': 'Rating 4.5+',
        'icon': Icons.star_rounded,
        'color': AppTheme.secondary,
        'type': 'rating'
      },
      {
        'label': 'Ada Promo',
        'icon': Icons.local_offer,
        'color': AppTheme.primary,
        'type': 'promo'
      },
      {
        'label': 'WiFi Kencang',
        'icon': Icons.wifi,
        'color': AppTheme.tertiary,
        'type': 'amenity'
      },
      {
        'label': 'Smoking Area',
        'icon': Icons.smoking_rooms,
        'color': AppTheme.outline,
        'type': 'amenity'
      },
      {
        'label': 'Colokan Banyak',
        'icon': Icons.power,
        'color': AppTheme.secondary,
        'type': 'amenity'
      },
    ];

    return SizedBox(
      height: 32,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = activeFilters.contains(filter['label']);

          return _buildStatusChip(
            context,
            filter['label'] as String,
            filter['icon'] as IconData,
            filter['color'] as Color,
            filter['type'] as String,
            isActive,
            () => onFilterToggled(filter['label'] as String),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(
    BuildContext context,
    String label,
    IconData icon,
    Color iconColor,
    String type,
    bool isActive,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.tertiaryFixed : AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          boxShadow: [AppTheme.shadowSm],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // For "Buka Sekarang": show pulsing dot
            if (label == 'Buka Sekarang' && isActive)
              _buildStatusDot()
            else
              Icon(
                icon,
                size: 12,
                color: isActive ? AppTheme.tertiary : iconColor,
              ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isActive ? AppTheme.onTertiaryFixed : AppTheme.onSurface,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusDot() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.3),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeInOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
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
      onEnd: () {
        // Animation loops by resetting
      },
    );
  }
}