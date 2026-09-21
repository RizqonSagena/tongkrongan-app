import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/models/place_model.dart';
import '../../../../core/data/mock_places.dart';

class DetailPlaceScreen extends StatefulWidget {
  final String placeId;

  const DetailPlaceScreen({
    super.key,
    required this.placeId,
  });

  @override
  State<DetailPlaceScreen> createState() => _DetailPlaceScreenState();
}

class _DetailPlaceScreenState extends State<DetailPlaceScreen> {
  late Place place;
  bool _isDescriptionExpanded = false;

  final TextEditingController _reviewController = TextEditingController();
  double _userRating = 0;

  @override
  void initState() {
    super.initState();
    place = mockPlaces.firstWhere((p) => p.id == widget.placeId,
        orElse: () => mockPlaces.first);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  Future<void> _launchMaps() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka peta')),
        );
      }
    }
  }

  void _submitReview() {
    if (_userRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan pilih rating terlebih dahulu')),
      );
      return;
    }
    if (_reviewController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Komentar tidak boleh kosong')),
      );
      return;
    }

    setState(() {
      place.reviews.insert(
        0,
        Review(
          id: DateTime.now().toString(),
          userName: 'You',
          userAvatar:
              'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=100&h=100&fit=crop',
          rating: _userRating,
          comment: _reviewController.text,
          createdAt: DateTime.now(),
        ),
      );
      _userRating = 0;
      _reviewController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ulasan berhasil dikirim!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(),
                    Padding(
                      padding: const EdgeInsets.all(AppTheme.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMainInfo(),
                          const SizedBox(height: AppTheme.spaceLg),
                          if (place.facilities.isNotEmpty) _buildFacilities(),
                          if (place.description != null) _buildDescription(),
                          _buildLocationAndMap(),
                          _buildMenus(),
                          _buildReviews(),
                          _buildGiveReviewForm(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomAction(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const Expanded(
            child: Text(
              'Detail Tempat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(
              place.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: place.isFavorite ? AppTheme.primary : AppTheme.outline,
            ),
            onPressed: () {
              setState(() {
                place.isFavorite = !place.isFavorite;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Image.network(
          place.image,
          width: double.infinity,
          height: 250,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: AppTheme.spaceSm,
          right: AppTheme.spaceSm,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: place.isOpen ? AppTheme.tertiaryFixed : AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
            child: Text(
              place.isOpen ? 'Buka Sekarang' : 'Tutup',
              style: TextStyle(
                color: place.isOpen
                    ? AppTheme.onTertiaryFixed
                    : AppTheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          place.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Row(
          children: [
            const Icon(Icons.star_rounded, color: AppTheme.secondary, size: 20),
            const SizedBox(width: 4),
            Text(
              '${place.rating} (${place.reviewCount} ulasan)',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Row(
          children: [
            const Icon(Icons.location_on, color: AppTheme.primary, size: 20),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                place.location,
                style: const TextStyle(color: AppTheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildInfoChip(place.category),
            _buildInfoChip(place.isOpen
                ? 'Buka s/d ${place.openUntil}'
                : 'Tutup Sekarang'),
            _buildInfoChip('${place.distance} dari lokasimu'),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: AppTheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFacilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fasilitas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: place.facilities.map((fac) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.outlineVariant),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_outline,
                      size: 16, color: AppTheme.primary),
                  const SizedBox(width: 4),
                  Text(
                    fac,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.onSurface,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppTheme.spaceLg),
      ],
    );
  }

  Widget _buildDescription() {
    final text = place.description!;
    final isLong = text.length > 100;
    final display = (isLong && !_isDescriptionExpanded)
        ? '${text.substring(0, 100)}...'
        : text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deskripsi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          display,
          style: const TextStyle(
            color: AppTheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
        if (isLong)
          GestureDetector(
            onTap: () {
              setState(() {
                _isDescriptionExpanded = !_isDescriptionExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                _isDescriptionExpanded
                    ? 'Tutup selengkapnya'
                    : 'Lihat selengkapnya',
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        const SizedBox(height: AppTheme.spaceLg),
      ],
    );
  }

  Widget _buildLocationAndMap() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lokasi & Peta',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Text(
          place.location,
          style: const TextStyle(color: AppTheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(AppTheme.radiusLg),
            border: Border.all(color: AppTheme.outlineVariant),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.map,
                  size: 64,
                  color: AppTheme.outline,
                ),
              ),
              const Center(
                child: Icon(
                  Icons.location_on,
                  size: 48,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        OutlinedButton.icon(
          onPressed: _launchMaps,
          icon: const Icon(Icons.map_outlined),
          label: const Text('Buka di Maps'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.primary,
            side: const BorderSide(color: AppTheme.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spaceLg),
      ],
    );
  }

  Widget _buildMenus() {
    if (place.menus.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Menu & Estimasi Harga',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              place.price ?? 'Cek menu',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceSm),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: place.menus.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceSm),
          itemBuilder: (context, index) {
            final menu = place.menus[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.outlineVariant),
              ),
              child: Row(
                children: [
                  if (menu.image != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        menu.image!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ] else ...[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.fastfood,
                          color: AppTheme.outlineVariant),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.onSurface,
                          ),
                        ),
                        if (menu.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            menu.description!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          'Rp${menu.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Center(
          child: TextButton(
            onPressed: () {},
            child: const Text('Lihat Semua Menu'),
          ),
        ),
        const SizedBox(height: AppTheme.spaceLg),
      ],
    );
  }

  Widget _buildReviews() {
    if (place.reviews.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Rating & Ulasan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Row(
          children: [
            Text(
              place.rating.toString(),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                      5,
                      (index) => const Icon(Icons.star_rounded,
                          color: AppTheme.secondary, size: 16)),
                ),
                Text(
                  '${place.reviewCount} ulasan',
                  style: const TextStyle(color: AppTheme.onSurfaceVariant),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spaceMd),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: place.reviews.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceSm),
          itemBuilder: (context, index) {
            final rev = place.reviews[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(rev.userAvatar),
                      radius: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        rev.userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      '${rev.createdAt.day}/${rev.createdAt.month}/${rev.createdAt.year}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                      5,
                      (i) => Icon(
                            Icons.star_rounded,
                            size: 14,
                            color: i < rev.rating
                                ? AppTheme.secondary
                                : AppTheme.outlineVariant,
                          )),
                ),
                const SizedBox(height: 4),
                Text(
                  rev.comment,
                  style: const TextStyle(
                    color: AppTheme.onSurfaceVariant,
                    height: 1.4,
                  ),
                ),
                const Divider(),
              ],
            );
          },
        ),
        const SizedBox(height: AppTheme.spaceLg),
      ],
    );
  }

  Widget _buildGiveReviewForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Berikan Ulasan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.onSurface,
          ),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                Icons.star_rounded,
                size: 36,
                color: index < _userRating
                    ? AppTheme.secondary
                    : AppTheme.outlineVariant,
              ),
              onPressed: () {
                setState(() {
                  _userRating = index + 1.0;
                });
              },
            );
          }),
        ),
        const SizedBox(height: AppTheme.spaceSm),
        TextField(
          controller: _reviewController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Tulis pengalaman kamu...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppTheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              borderSide: const BorderSide(color: AppTheme.primary),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spaceMd),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
            ),
            child: const Text('Kirim Ulasan'),
          ),
        ),
        const SizedBox(height: AppTheme.spaceXl),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.margin),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _launchMaps,
              icon: const Icon(Icons.directions),
              label: const Text('Rute'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed('/booking');
              },
              icon: const Icon(Icons.calendar_today, size: 18),
              label: const Text('Booking'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}