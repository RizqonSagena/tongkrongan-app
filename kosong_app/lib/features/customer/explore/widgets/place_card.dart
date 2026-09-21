import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class PlaceCard extends StatefulWidget {
  final Map<String, dynamic> place;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;

  const PlaceCard({
    super.key,
    required this.place,
    this.onTap,
    this.onFavoriteToggle,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isFavoriteAnimating = false;

  @override
  void initState() {
    super.initState();
    // Setup pulsing animation for status indicator
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
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _isFavoriteAnimating ? 0.99 : 1.0,
        duration: const Duration(milliseconds: 200),
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
              // Image Section with overlay, status, favorite, and category
              _buildImageSection(context),

              // Content Section
              Padding(
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Location
                    _buildHeader(context),
                    const SizedBox(height: AppTheme.spaceSm),

                    // Vibe Tags
                    _buildTags(context),
                    const SizedBox(height: AppTheme.spaceMd),

                    // Action row with status and button
                    _buildActionRow(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
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
          // Image with error handling and loading state
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppTheme.radiusXl),
            ),
            child: Image.network(
              widget.place['image'],
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
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.primary,
                        ),
                      ),
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

          // Gradient overlay: black/40 to transparent to black/10
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

          // Status Pill (top-left) with pulsing dot
          Positioned(
            top: AppTheme.spaceSm,
            left: AppTheme.spaceSm,
            child: _buildStatusPill(context),
          ),

          // Favorite Button (top-right)
          Positioned(
            top: AppTheme.spaceSm,
            right: AppTheme.spaceSm,
            child: _buildFavoriteButton(context),
          ),

          // Category Badge (bottom-left)
          Positioned(
            bottom: AppTheme.spaceSm,
            left: AppTheme.spaceSm,
            child: _buildCategoryBadge(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.tertiaryFixed,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
        boxShadow: [AppTheme.shadowMd],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pulsing dot
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
          ),
          const SizedBox(width: 6),
          Text(
            widget.place['openUntil'] == '24 Jam'
                ? 'Buka 24 Jam'
                : 'Buka s/d ${widget.place['openUntil']}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onTertiaryFixed,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFavoriteAnimating = true;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            setState(() {
              _isFavoriteAnimating = false;
            });
          }
        });
        widget.onFavoriteToggle?.call();
      },
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
            child: Icon(
              widget.place['isFavorite']
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 18,
              color: widget.place['isFavorite']
                  ? AppTheme.primary
                  : AppTheme.outline,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.inverseSurface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: [AppTheme.shadowSm],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Text(
            widget.place['category'],
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.inverseOnSurface,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.place['name'],
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.place['location'],
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: AppTheme.spaceSm),
        // Rating Block
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                widget.place['rating'].toString(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.onSecondaryFixed,
                ),
              ),
              const SizedBox(width: 2),
              Text(
                '(${widget.place['reviewCount']})',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTags(BuildContext context) {
    final tags = widget.place['tags'] as List<String>;
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
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
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

  Widget _buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Status dot with "Buka Sekarang"
        Expanded(
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppTheme.tertiary,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Buka Sekarang',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.tertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Right: Action button
        ElevatedButton.icon(
          onPressed: widget.onTap,
          icon: const Icon(Icons.arrow_forward, size: 14),
          label: const Text('Lihat'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: AppTheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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