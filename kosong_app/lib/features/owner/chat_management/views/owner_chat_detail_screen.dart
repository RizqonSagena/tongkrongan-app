import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class OwnerChatDetailScreen extends StatefulWidget {
  final String chatId;
  const OwnerChatDetailScreen({super.key, required this.chatId});

  @override
  State<OwnerChatDetailScreen> createState() => _OwnerChatDetailScreenState();
}

class _OwnerChatDetailScreenState extends State<OwnerChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Dummy data - siap dihubungkan ke backend
  late List<Map<String, dynamic>> _messages;
  late String _contactName;
  late String _contactType;

  @override
  void initState() {
    super.initState();
    _loadChatData();
  }

  void _loadChatData() {
    if (widget.chatId == 'chat-customer-ahmad') {
      _contactName = 'Ahmad Pratama';
      _contactType = 'Customer';
      _messages = [
        {'sender': 'customer', 'text': 'Bisakah booking untuk 4 orang besok?', 'time': '20:30'},
        {'sender': 'owner', 'text': 'Bisa, untuk jam berapa?', 'time': '20:31'},
        {'sender': 'customer', 'text': 'Jam 19.00.', 'time': '20:32'},
        {'sender': 'owner', 'text': 'Baik, kami cek ketersediaannya.', 'time': '20:33'},
      ];
    } else {
      _contactName = 'Tim Support Tongkrongan';
      _contactType = 'Admin';
      _messages = [
        {'sender': 'admin', 'text': 'Ada customer yang komplain soal WiFi.', 'time': '19:00'},
        {'sender': 'owner', 'text': 'Saya mengalami masalah dengan data pesanan.', 'time': '19:05'},
        {'sender': 'admin', 'text': 'Baik, kami bantu cek.', 'time': '19:06'},
      ];
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'owner',
        'text': text,
        'time': TimeOfDay.now().format(context),
      });
    });
    _messageController.clear();

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = _contactType == 'Admin';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.surface,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _contactName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Text(
              _contactType,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isAdmin ? AppTheme.tertiary : AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: isAdmin
                ? AppTheme.tertiary.withValues(alpha: 0.2)
                : AppTheme.primary.withValues(alpha: 0.2),
            child: Icon(
              isAdmin ? Icons.support_agent : Icons.person,
              color: isAdmin ? AppTheme.tertiary : AppTheme.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: AppTheme.spaceMd),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(AppTheme.margin),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isOwner = msg['sender'] == 'owner';
                return _buildMessageBubble(context, msg, isOwner);
              },
            ),
          ),

          // Input bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spaceMd,
              vertical: AppTheme.spaceSm,
            ),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Tulis pesan...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: AppTheme.surfaceContainerLow,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spaceSm),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: AppTheme.onPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, Map<String, dynamic> msg, bool isOwner) {
    return Align(
      alignment: isOwner ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spaceSm),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isOwner ? AppTheme.primary : AppTheme.surfaceContainerLow,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isOwner ? 16 : 4),
            bottomRight: Radius.circular(isOwner ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: isOwner ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              msg['text'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isOwner ? AppTheme.onPrimary : AppTheme.onSurface,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              msg['time'],
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: isOwner
                        ? AppTheme.onPrimary.withValues(alpha: 0.7)
                        : AppTheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
