import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class ContentManagementScreen extends StatelessWidget {
  const ContentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> contents = [
      {
        'title': 'Promo Weekend Special',
        'category': 'Promo',
        'status': 'active',
        'date': '15 Sep 2024',
      },
      {
        'title': 'Tips Nongkrong yang Aman',
        'category': 'Article',
        'status': 'active',
        'date': '14 Sep 2024',
      },
      {
        'title': 'Event Gathering Komunitas',
        'category': 'Event',
        'status': 'pending',
        'date': '13 Sep 2024',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Content Management'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppTheme.margin),
        itemCount: contents.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceMd),
        itemBuilder: (context, index) {
          final content = contents[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spaceMd),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          content['title'],
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: content['status'] == 'active' ? AppTheme.tertiary.withValues(alpha: 0.2) : AppTheme.secondary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          content['status'] == 'active' ? 'Active' : 'Pending',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: content['status'] == 'active' ? AppTheme.tertiary : AppTheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(content['category']),
                        backgroundColor: AppTheme.surfaceContainer,
                        labelStyle: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        content['date'],
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
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('Delete'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('View'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}