import 'package:flutter/material.dart';

import '../../../../core/themes/app_theme.dart';

class LocationHeader extends StatelessWidget {
  const LocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              const Icon(Icons.near_me, size: 16, color: AppTheme.primary),
              const SizedBox(width: 6),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: AppTheme.onSurfaceVariant),
                    children: [
                      const TextSpan(text: 'Di sekitarmu: '),
                      TextSpan(
                        text: 'Tanjung pinang, Kepulauan Riau',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
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
        TextButton.icon(
          onPressed: () {
            // Handle change location
          },
          icon: const Icon(Icons.expand_more, size: 14),
          label: const Text('Ubah'),
          style: TextButton.styleFrom(
            foregroundColor: AppTheme.primary,
            textStyle: Theme.of(context).textTheme.labelSmall
                ?.copyWith(fontWeight: FontWeight.w600),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
