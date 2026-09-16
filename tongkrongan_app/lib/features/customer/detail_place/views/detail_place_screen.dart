import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class DetailPlaceScreen extends StatelessWidget {
  final String placeId;

  const DetailPlaceScreen({
    super.key,
    required this.placeId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tempat'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.place_outlined,
              size: 64,
              color: AppTheme.primary,
            ),
            const SizedBox(height: AppTheme.spaceMd),
            const Text(
              'Detail Tempat Tongkrongan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.onSurface,
              ),
            ),
            const SizedBox(height: AppTheme.spaceSm),
            Text(
              'Place ID: $placeId',
              style: const TextStyle(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}