import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/router/app_router.dart';

class OwnerChatScreen extends StatelessWidget {
  const OwnerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        'id': 'chat-customer-ahmad',
        'name': 'Ahmad Pratama',
        'type': 'Customer',
        'message': 'Bisakah booking untuk 4 orang besok?',
        'time': '5 menit lalu',
        'unread': 1,
      },
      {
        'id': 'chat-admin-support',
        'name': 'Tim Support Tongkrongan',
        'type': 'Admin',
        'message': 'Ada customer yang komplain soal WiFi.',
        'time': '1 jam lalu',
        'unread': 0,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];
          final isAdmin = chat['type'] == 'Admin';
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isAdmin
                  ? AppTheme.tertiary.withValues(alpha: 0.2)
                  : AppTheme.primary.withValues(alpha: 0.2),
              child: Icon(
                isAdmin ? Icons.support_agent : Icons.person,
                color: isAdmin ? AppTheme.tertiary : AppTheme.primary,
              ),
            ),
            title: Row(
              children: [
                Text(
                  chat['name'],
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isAdmin
                        ? AppTheme.tertiary.withValues(alpha: 0.1)
                        : AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  child: Text(
                    chat['type'],
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isAdmin ? AppTheme.tertiary : AppTheme.primary,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Text(
              chat['message'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  chat['time'],
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
                if (chat['unread'] > 0)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat['unread'].toString(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRouter.ownerChatDetail,
                arguments: chat['id'],
              );
            },
          );
        },
      ),
    );
  }
}