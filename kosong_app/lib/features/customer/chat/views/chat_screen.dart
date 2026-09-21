import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _selectedChat = '';
  final TextEditingController _messageController = TextEditingController();
  bool _showConversationList = true;

  final List<Map<String, dynamic>> conversations = [
    {
      'id': '1',
      'name': 'Komunitas Kopi Tebet',
      'lastMessage': 'Siapa aja yang ikut meetup minggu depan?',
      'time': '15 menit lalu',
      'unread': 3,
      'avatar': '☕',
      'isGroup': true,
    },
    {
      'id': '2',
      'name': 'Budi Santoso',
      'lastMessage': 'Oke, sampai jumpa di Selasar Kopi',
      'time': '1 jam lalu',
      'unread': 0,
      'avatar': '👤',
      'isGroup': false,
    },
    {
      'id': '3',
      'name': 'Kelompok Nongkrong Lembang',
      'lastMessage': 'Foto-foto kemarin udah upload belom?',
      'time': '3 jam lalu',
      'unread': 0,
      'avatar': '📷',
      'isGroup': true,
    },
  ];

  final List<Map<String, dynamic>> messages = [
    {
      'type': 'bot',
      'content': 'Halo! 👋 Selamat datang di Tongkrongan Support.',
      'time': '10:30',
      'isSender': false,
    },
    {
      'type': 'bot',
      'content':
          'Kami siap membantu kamu menemukan tempat nongkrong terbaik dan mengelola jadwal hangout.',
      'time': '10:31',
      'isSender': false,
    },
    {
      'type': 'user',
      'content': 'Halo! Ada pertanyaan tentang booking tempat nih',
      'time': '10:32',
      'isSender': true,
    },
    {
      'type': 'bot',
      'content': 'Tentu! Silakan tanyakan. Apa yang bisa kami bantu? 😊',
      'time': '10:33',
      'isSender': false,
    },
    {
      'type': 'embedded',
      'content': 'Bagaimana cara membuat janji di Tongkrongan?',
      'cardTitle': 'Tutorial Booking',
      'cardDescription': 'Pelajari cara membuat dan mengelola janji nongkrong',
      'time': '10:34',
      'isSender': false,
    },
    {
      'type': 'user',
      'content': 'Oke terima kasih! Sangat membantu 👍',
      'time': '10:35',
      'isSender': true,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isConversationSelected = _selectedChat.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: isConversationSelected
            ? _buildChatDetail()
            : _buildConversationList(),
      ),
    );
  }

  Widget _buildConversationList() {
    return Column(
      children: [
        // Header
        _buildListHeader(),

        // Conversations
        Expanded(
          child: ListView.separated(
            itemCount: conversations.length,
            separatorBuilder: (_, __) => Divider(
              height: 1,
              color: AppTheme.outlineVariant,
            ),
            itemBuilder: (context, index) {
              final chat = conversations[index];
              return _buildConversationTile(chat);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildListHeader() {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppTheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Pesan teman dan komunitas',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline),
                color: AppTheme.primary,
                iconSize: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversationTile(Map<String, dynamic> chat) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: AppTheme.spaceXs,
      ),
      leading: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.primaryFixed.withValues(alpha: 0.3),
          border: chat['unread'] > 0
              ? Border.all(color: AppTheme.primary, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            chat['avatar'],
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
      title: Text(
        chat['name'],
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppTheme.onSurface,
        ),
      ),
      subtitle: Row(
        children: [
          if (chat['isGroup'])
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                Icons.groups,
                size: 14,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          Expanded(
            child: Text(
              chat['lastMessage'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chat['time'],
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          if (chat['unread'] > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(
                chat['unread'].toString(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ],
      ),
      onTap: () {
        setState(() => _selectedChat = chat['id']);
      },
    );
  }

  Widget _buildChatDetail() {
    final currentChat =
        conversations.firstWhere((c) => c['id'] == _selectedChat);

    return Column(
      children: [
        // Chat Header
        _buildChatHeader(currentChat),

        // Messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(AppTheme.margin),
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[messages.length - 1 - index];
              return Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spaceMd),
                child: _buildMessageBubble(message),
              );
            },
          ),
        ),

        // Fixed Input Area with Backdrop Blur
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildChatHeader(Map<String, dynamic> chat) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: AppTheme.spaceMd,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: AppTheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedChat = ''),
                child: Icon(
                  Icons.arrow_back,
                  color: AppTheme.onSurface,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryFixed.withValues(alpha: 0.3),
                ),
                child: Center(
                  child: Text(
                    chat['avatar'],
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat['name'],
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    if (chat['isGroup'])
                      Text(
                        'Grup Komunitas',
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call),
                color: AppTheme.primary,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.info_outline),
                color: AppTheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isSender = message['isSender'] as bool;

    if (message['type'] == 'embedded') {
      return _buildEmbeddedCard(message, isSender);
    }

    final backgroundColor = isSender
        ? AppTheme.primary
        : AppTheme.surfaceContainerLowest;
    final textColor =
        isSender ? AppTheme.onPrimary : AppTheme.onSurface;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceMd,
              vertical: AppTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusLg),
              boxShadow: isSender ? [AppTheme.shadowSm] : null,
            ),
            child: Column(
              crossAxisAlignment: isSender
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message['content'] as String,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message['time'] as String,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isSender
                        ? AppTheme.onPrimary.withValues(alpha: 0.7)
                        : AppTheme.onSurfaceVariant,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (!isSender && message['type'] == 'bot')
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryFixed,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  'Bot Support',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onTertiaryFixed,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmbeddedCard(Map<String, dynamic> message, bool isSender) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to tutorial or content
            },
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                border: Border.all(
                  color: AppTheme.outlineVariant,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Header
                  Container(
                    padding: const EdgeInsets.all(AppTheme.spaceSm),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryFixed,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppTheme.radiusLg),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info,
                          size: 18,
                          color: AppTheme.onPrimaryFixed,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            message['cardTitle'] as String,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                              color: AppTheme.onPrimaryFixed,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Card Content
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spaceSm),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['cardDescription'] as String,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                message['content'] as String,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                  color: AppTheme.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: AppTheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isSender)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.tertiaryFixed,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Text(
                  'Bot Support',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.onTertiaryFixed,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.85),
        border: Border(
          top: BorderSide(
            color: AppTheme.outlineVariant,
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: EdgeInsets.only(
              left: AppTheme.margin,
              right: AppTheme.margin,
              top: AppTheme.spaceSm,
              bottom: AppTheme.spaceSm +
                  MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainer,
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusXl),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            maxLines: null,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (value) {
                              // Send message
                              _messageController.clear();
                            },
                            decoration: InputDecoration(
                              hintText: 'Tulis pesan...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: AppTheme.outline,
                              ),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(
                                horizontal: AppTheme.spaceMd,
                                vertical: AppTheme.spaceSm,
                              ),
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 8),
                          child: IconButton(
                            onPressed: () {
                              // Attach file
                            },
                            icon: const Icon(Icons.attach_file),
                            color: AppTheme.secondary,
                            iconSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                GestureDetector(
                  onTap: () {
                    // Send message
                    _messageController.clear();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}