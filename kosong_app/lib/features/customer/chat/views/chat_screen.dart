import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';
import '../../../../core/models/chat_model.dart';
import '../../../../core/data/mock_chats.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String _selectedChat = '';
  final TextEditingController _messageController = TextEditingController();

  List<Message> get _currentMessages {
    return mockMessages
        .where((m) => m.conversationId == _selectedChat)
        .toList()
      ..sort((a, b) => b.sentAt.compareTo(a.sentAt));
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final conversation = mockConversations.firstWhere((c) => c.id == _selectedChat);

    setState(() {
      final newMessage = Message(
        id: DateTime.now().toString(),
        conversationId: _selectedChat,
        senderId: 'c1', // Hardcoded current user
        senderType: 'customer',
        content: _messageController.text,
        sentAt: DateTime.now(),
      );
      mockMessages.add(newMessage);

      conversation.lastMessage = newMessage.content;
      conversation.lastMessageAt = newMessage.sentAt;

      _messageController.clear();
    });
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  String _formatMessageTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
    // Refresh to sort by latest message
    mockConversations.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));

    return Column(
      children: [
        // Header
        _buildListHeader(),

        // Conversations
        Expanded(
          child: mockConversations.isEmpty 
              ? const Center(child: Text('Belum ada pesan.'))
              : ListView.separated(
                  itemCount: mockConversations.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    color: AppTheme.outlineVariant,
                  ),
                  itemBuilder: (context, index) {
                    final chat = mockConversations[index];
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
                    'Pesan owner usaha atau admin Tongkrongan',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversationTile(Conversation chat) {
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
          border: chat.unreadCount > 0
              ? Border.all(color: AppTheme.primary, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            chat.recipientAvatar,
            style: const TextStyle(fontSize: 28),
          ),
        ),
      ),
      title: Text(
        chat.recipientName,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppTheme.onSurface,
        ),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(
              chat.lastMessage,
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
            _formatTime(chat.lastMessageAt),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppTheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          if (chat.unreadCount > 0) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
              child: Text(
                chat.unreadCount.toString(),
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
        setState(() {
          _selectedChat = chat.id;
          chat.unreadCount = 0; // Mark as read
        });
      },
    );
  }

  Widget _buildChatDetail() {
    final currentChat =
        mockConversations.firstWhere((c) => c.id == _selectedChat);
    final messages = _currentMessages;

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
              final message = messages[index];
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

  Widget _buildChatHeader(Conversation chat) {
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
                    chat.recipientAvatar,
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
                      chat.recipientName,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.onSurface,
                      ),
                    ),
                    Text(
                      chat.recipientType == 'owner' ? 'Owner Usaha' : 'Customer Service',
                      style:
                          Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isSender = message.senderType == 'customer';

    if (message.type == 'embedded') {
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
                  message.content,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatMessageTime(message.sentAt),
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
          if (!isSender && message.senderType == 'bot')
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

  Widget _buildEmbeddedCard(Message message, bool isSender) {
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
                            message.cardTitle ?? 'Info',
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
                        if (message.cardDescription != null)
                          Text(
                            message.cardDescription!,
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
                                message.content,
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
          if (!isSender && message.senderType == 'bot')
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
                            onSubmitted: (value) => _sendMessage(),
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
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spaceSm),
                GestureDetector(
                  onTap: _sendMessage,
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