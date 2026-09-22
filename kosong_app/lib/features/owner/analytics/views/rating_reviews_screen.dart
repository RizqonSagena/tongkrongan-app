import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class RatingReviewsScreen extends StatelessWidget {
  const RatingReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rating & Ulasan'),
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Summary
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      '4.8',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: AppTheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '342 ulasan',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
                const SizedBox(width: AppTheme.spaceXl),
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar(context, 5, 0.8, '80%'),
                      _buildRatingBar(context, 4, 0.12, '12%'),
                      _buildRatingBar(context, 3, 0.05, '5%'),
                      _buildRatingBar(context, 2, 0.02, '2%'),
                      _buildRatingBar(context, 1, 0.01, '1%'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spaceXl),
            Divider(color: AppTheme.outlineVariant),
            const SizedBox(height: AppTheme.spaceMd),

            // Reviews List
            _buildReviewItem(
              context,
              'Ahmad Pratama',
              5,
              'Tempatnya nyaman dan kopinya enak. WiFi juga cepat.',
              '2 jam lalu',
            ),
            _buildReviewItem(
              context,
              'Siti Nurhaliza',
              4,
              'Tempat bagus, tetapi agak ramai saat malam.',
              '1 hari lalu',
            ),
            _buildReviewItem(
              context,
              'Bambang Irawan',
              5,
              'Pelayanannya cepat.',
              '2 hari lalu',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(BuildContext context, int star, double percent, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$star',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurfaceVariant,
                ),
          ),
          const Icon(Icons.star, color: Colors.amber, size: 12),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: AppTheme.surfaceContainerHighest,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                minHeight: 8,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(BuildContext context, String name, int stars, String comment, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spaceLg),
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(color: AppTheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurface,
                    ),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < stars ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"$comment"',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.onSurface,
                ),
          ),
          const SizedBox(height: AppTheme.spaceMd),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                // Implement reply logic
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: const Text('Balas'),
            ),
          ),
        ],
      ),
    );
  }
}
