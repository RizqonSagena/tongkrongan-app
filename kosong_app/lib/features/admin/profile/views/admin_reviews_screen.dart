import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AdminReviewsScreen extends StatefulWidget {
  const AdminReviewsScreen({super.key});

  @override
  State<AdminReviewsScreen> createState() => _AdminReviewsScreenState();
}

class _AdminReviewsScreenState extends State<AdminReviewsScreen> {
  final List<Map<String, dynamic>> _reviews = [
    {
      'customer': 'Andi',
      'store': 'Morning Bakery',
      'rating': 4.0,
      'review': 'Rotinya enak, tetapi pelayanan cukup lama.',
      'date': '14 Sep 2024',
      'status': 'Perlu Ditinjau',
      'interest': 'Berpotensi kembali',
    },
    {
      'customer': 'Siti',
      'store': 'Selasar Kopi',
      'rating': 3.5,
      'review': 'Tempatnya nyaman tapi WiFi sering putus.',
      'date': '13 Sep 2024',
      'status': 'Sudah Ditinjau',
      'interest': 'Loyal',
    },
    {
      'customer': 'Budi',
      'store': 'Kala Kopi',
      'rating': 5.0,
      'review': 'Recommended banget, kopi enak dan suasana bagus!',
      'date': '12 Sep 2024',
      'status': 'Selesai',
      'interest': 'Sangat Loyal',
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
                itemCount: _reviews.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppTheme.spaceMd),
                itemBuilder: (context, index) {
                  return _buildReviewCard(context, _reviews[index], index);
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
            'Respon & Ulasan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    BuildContext context,
    Map<String, dynamic> review,
    int index,
  ) {
    final String status = review['status'] as String;
    Color statusColor;
    switch (status) {
      case 'Perlu Ditinjau':
        statusColor = AppTheme.secondary;
        break;
      case 'Sudah Ditinjau':
        statusColor = AppTheme.primary;
        break;
      default:
        statusColor = AppTheme.tertiary;
    }

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
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: AppTheme.primary.withValues(alpha: 0.15),
                    child: Text(
                      (review['customer'] as String).substring(0, 1),
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceSm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review['customer'] as String,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      Text(
                        review['store'] as String,
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
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

          // Rating stars
          Row(
            children: [
              ...List.generate(5, (i) {
                final double rating = review['rating'] as double;
                if (i < rating.floor()) {
                  return Icon(Icons.star, size: 16, color: AppTheme.secondary);
                } else if (i < rating) {
                  return Icon(Icons.star_half, size: 16, color: AppTheme.secondary);
                } else {
                  return Icon(Icons.star_border, size: 16, color: AppTheme.secondary);
                }
              }),
              const SizedBox(width: 4),
              Text(
                '${review['rating']}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.secondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceSm),

          // Review text
          Text(
            '"${review['review']}"',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: AppTheme.spaceSm),

          // Date + Interest
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review['date'] as String,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.tertiary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Text(
                  '🎯 ${review['interest']}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spaceMd),
          const Divider(height: 1),
          const SizedBox(height: AppTheme.spaceSm),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Meninjau ulasan dari ${review['customer']}',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: const Text('Tinjau', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Memberi tanggapan untuk ${review['customer']}',
                        ),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: const Text('Tanggapi', style: TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: AppTheme.spaceSm),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _reviews[index]['status'] = 'Selesai';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Ulasan ${review['customer']} ditandai selesai',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.tertiary,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: const Text('Selesai', style: TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
