class Conversation {
  final String id;
  final String customerId;
  final String recipientId;
  final String recipientType; // 'owner' or 'admin'
  final String recipientName;
  final String recipientAvatar;
  final String? placeId; // Only if recipient is owner
  String lastMessage;
  DateTime lastMessageAt;
  int unreadCount;

  Conversation({
    required this.id,
    required this.customerId,
    required this.recipientId,
    required this.recipientType,
    required this.recipientName,
    required this.recipientAvatar,
    this.placeId,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
  });
}

class Message {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderType; // 'customer', 'owner', 'admin', or 'bot'
  final String content;
  final DateTime sentAt;

  // Optional fields for embedded cards
  final String? type; // 'text', 'embedded'
  final String? cardTitle;
  final String? cardDescription;

  Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderType,
    required this.content,
    required this.sentAt,
    this.type = 'text',
    this.cardTitle,
    this.cardDescription,
  });
}
