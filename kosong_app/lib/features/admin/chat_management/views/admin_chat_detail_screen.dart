import 'package:flutter/material.dart';
import '../../../../core/themes/app_theme.dart';

class AdminChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> conversation;

  const AdminChatDetailScreen({super.key, required this.conversation});

  @override
  State<AdminChatDetailScreen> createState() => _AdminChatDetailScreenState();
}

class _AdminChatDetailScreenState extends State<AdminChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = [
      {
        'sender': 'admin',
        'message':
            'Halo Kak, kami ingin mengonfirmasi update informasi toko Morning Bakery.',
        'time': '10:05',
      },
      {
        'sender': 'owner',
        'message': 'Halo Admin, iya. Ada yang perlu saya lengkapi?',
        'time': '10:07',
      },
      {
        'sender': 'admin',
        'message':
            'Ada permintaan update menu dari toko Kakak. Silakan cek bagian Menu Request.',
        'time': '10:09',
      },
      {
        'sender': 'owner',
        'message': 'Baik Admin, nanti saya cek.',
        'time': '10:11',
      },
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'sender': 'admin',
        'message': text,
        'time': _getCurrentTime(),
      });
    });
    _messageController.clear();

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

  String _getCurrentTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final conv = widget.conversation;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, conv),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppTheme.spaceMd),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildChatBubble(context, _messages[index]);
                },
              ),
            ),
            _buildInputArea(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> conv) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
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
          CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.secondary.withValues(alpha: 0.2),
            child: Text(
              (conv['name'] as String? ?? 'U').substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: AppTheme.secondary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spaceSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conv['name'] ?? 'Chat',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.onSurface,
                  ),
                ),
                Text(
                  conv['role'] ?? 'User',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppTheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: AppTheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble(
    BuildContext context,
    Map<String, dynamic> message,
  ) {
    final bool isAdmin = message['sender'] == 'admin';

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spaceSm),
      child: Row(
        mainAxisAlignment:
            isAdmin ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isAdmin) ...[
            CircleAvatar(
              radius: 14,
              backgroundColor: AppTheme.primary.withValues(alpha: 0.2),
              child: Text(
                'O',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spaceSm),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spaceMd,
                vertical: AppTheme.spaceSm,
              ),
              decoration: BoxDecoration(
                color: isAdmin
                    ? AppTheme.secondary
                    : AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isAdmin
                      ? const Radius.circular(16)
                      : const Radius.circular(4),
                  bottomRight: isAdmin
                      ? const Radius.circular(4)
                      : const Radius.circular(16),
                ),
                border: isAdmin
                    ? null
                    : Border.all(color: AppTheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message['message'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      color: isAdmin ? AppTheme.onSecondary : AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message['time'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      color: isAdmin
                          ? AppTheme.onSecondary.withValues(alpha: 0.7)
                          : AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isAdmin) const SizedBox(width: AppTheme.spaceSm),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
        vertical: AppTheme.spaceSm,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border(
          top: BorderSide(color: AppTheme.outlineVariant),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                border: Border.all(color: AppTheme.outlineVariant),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Tulis pesan...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                style: const TextStyle(fontSize: 14),
                maxLines: null,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spaceSm),
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.secondary,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send, color: AppTheme.onSecondary, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
