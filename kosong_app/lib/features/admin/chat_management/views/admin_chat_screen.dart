import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../../core/themes/app_theme.dart';
import 'admin_chat_detail_screen.dart';

class AdminChatScreen extends StatefulWidget {
  const AdminChatScreen({super.key});

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _customerConversations = [
    {
      'name': 'Ahmad Pratama',
      'role': 'Customer',
      'lastMessage': 'Halo Admin, saya ingin memberikan kritik...',
      'time': '5 mnt',
      'unread': 2,
      'online': true,
      'ticketStatus': 'open',
      'initial': 'A',
    },
    {
      'name': 'Siti Nurhaliza',
      'role': 'Customer',
      'lastMessage': 'Pertanyaan tentang promo member...',
      'time': '1 jam',
      'unread': 0,
      'online': false,
      'ticketStatus': 'open',
      'initial': 'S',
    },
  ];

  final List<Map<String, dynamic>> _ownerConversations = [
    {
      'name': 'Morning Bakery',
      'role': 'Owner · Dimas Prasetyo',
      'lastMessage': 'Baik Admin, nanti saya cek.',
      'time': '15 mnt',
      'unread': 1,
      'online': true,
      'ticketStatus': 'in_progress',
      'initial': 'M',
    },
    {
      'name': 'Selasar Kopi',
      'role': 'Owner · Sarah Amalia',
      'lastMessage': 'Kapan promo saya bisa tayang?',
      'time': '2 jam',
      'unread': 0,
      'online': false,
      'ticketStatus': 'resolved',
      'initial': 'S',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            _buildTabBar(context),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildConversationList(
                    context,
                    _customerConversations,
                  ),
                  _buildConversationList(
                    context,
                    _ownerConversations,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.secondary,
                  borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                ),
                child: Icon(
                  Icons.support_agent,
                  color: AppTheme.onSecondary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppTheme.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OPERATOR PORTAL',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Support Chat',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppTheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // Total unread badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.error,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                ),
                child: Text(
                  '${_customerConversations.fold<int>(0, (sum, c) => sum + (c['unread'] as int)) + _ownerConversations.fold<int>(0, (sum, c) => sum + (c['unread'] as int))} Baru',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        border: Border(
          bottom: BorderSide(color: AppTheme.outlineVariant),
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: AppTheme.secondary,
        unselectedLabelColor: AppTheme.onSurfaceVariant,
        indicatorColor: AppTheme.secondary,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Customer'),
                const SizedBox(width: 6),
                _buildTabBadge(
                  _customerConversations.fold<int>(
                    0,
                    (sum, c) => sum + (c['unread'] as int),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Owner'),
                const SizedBox(width: 6),
                _buildTabBadge(
                  _ownerConversations.fold<int>(
                    0,
                    (sum, c) => sum + (c['unread'] as int),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBadge(int count) {
    if (count == 0) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: AppTheme.error,
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildConversationList(
    BuildContext context,
    List<Map<String, dynamic>> conversations,
  ) {
    if (conversations.isEmpty) {
      return Center(
        child: Text(
          'Belum ada percakapan',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(AppTheme.spaceMd),
      itemCount: conversations.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spaceSm),
      itemBuilder: (context, index) {
        return _buildConversationItem(context, conversations[index]);
      },
    );
  }

  Widget _buildConversationItem(
    BuildContext context,
    Map<String, dynamic> conv,
  ) {
    final int unread = conv['unread'] as int;
    final bool isOnline = conv['online'] as bool;
    final String ticketStatus = conv['ticketStatus'] as String;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AdminChatDetailScreen(conversation: conv),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spaceMd),
        decoration: BoxDecoration(
          color: unread > 0
              ? AppTheme.secondary.withValues(alpha: 0.04)
              : AppTheme.surfaceContainerLowest,
          border: Border.all(
            color: unread > 0
                ? AppTheme.secondary.withValues(alpha: 0.3)
                : AppTheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppTheme.secondary.withValues(alpha: 0.2),
                  child: Text(
                    conv['initial'] as String,
                    style: TextStyle(
                      color: AppTheme.secondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppTheme.tertiary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppTheme.surfaceContainerLowest,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: AppTheme.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        conv['name'] as String,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      Text(
                        conv['time'] as String,
                        style:
                            Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  // Role badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Text(
                      conv['role'] as String,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conv['lastMessage'] as String,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: unread > 0
                                ? AppTheme.onSurface
                                : AppTheme.onSurfaceVariant,
                            fontWeight: unread > 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spaceSm),
                      if (unread > 0)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '$unread',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildTicketStatusChip(context, ticketStatus),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketStatusChip(BuildContext context, String status) {
    Color color;
    String label;
    switch (status) {
      case 'open':
        color = AppTheme.secondary;
        label = 'Open';
        break;
      case 'in_progress':
        color = AppTheme.primary;
        label = 'In Progress';
        break;
      default:
        color = AppTheme.tertiary;
        label = 'Resolved';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
