import 'package:flutter/material.dart';
import '../../features/customer/explore/views/explore_screen.dart';
import '../../features/customer/favorites/views/favorites_screen.dart';
import '../../features/customer/booking/views/booking_screen.dart';
import '../../features/customer/chat/views/chat_screen.dart';
import '../../features/customer/profile/views/profile_screen.dart';
import '../../features/owner/dashboard/views/owner_dashboard_screen.dart';
import '../../features/owner/analytics/views/analytics_screen.dart';
import '../../features/owner/orders/views/orders_screen.dart';
import '../../features/owner/chat_management/views/owner_chat_screen.dart';
import '../../features/owner/profile/views/owner_profile_screen.dart';
import '../../features/admin/dashboard/views/admin_dashboard_screen.dart';
import '../../features/admin/store_management/views/store_management_screen.dart';
import '../../features/admin/content_management/views/content_management_screen.dart';
import '../../features/admin/chat_management/views/admin_chat_screen.dart';
import '../../features/admin/profile/views/admin_profile_screen.dart';

enum UserType { customer, owner, admin }

class MainLayout extends StatefulWidget {
  final UserType userType;

  const MainLayout({
    super.key,
    required this.userType,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  List<Widget> get _customerScreens => [
    const ExploreScreen(),
    const FavoritesScreen(),
    const BookingScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  List<Widget> get _ownerScreens => [
    const OwnerDashboardScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
    const OwnerChatScreen(),
    const OwnerProfileScreen(),
  ];

  List<Widget> get _adminScreens => [
    const AdminDashboardScreen(),
    const StoreManagementScreen(),
    const ContentManagementScreen(),
    const AdminChatScreen(),
    const AdminProfileScreen(),
  ];

  List<BottomNavigationBarItem> get _customerNavItems => [
    const BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'Explore',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline),
      activeIcon: Icon(Icons.favorite),
      label: 'Favorit',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.event_note_outlined),
      activeIcon: Icon(Icons.event_note),
      label: 'Booking',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat_bubble_outline),
      activeIcon: Icon(Icons.chat_bubble),
      label: 'Chat',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  List<BottomNavigationBarItem> get _ownerNavItems => [
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: 'Dashboard',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.analytics_outlined),
      activeIcon: Icon(Icons.analytics),
      label: 'Analytics',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.receipt_long_outlined),
      activeIcon: Icon(Icons.receipt_long),
      label: 'Orders',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.chat_outlined),
      activeIcon: Icon(Icons.chat),
      label: 'Chat',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  List<BottomNavigationBarItem> get _adminNavItems => [
    const BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings_outlined),
      activeIcon: Icon(Icons.admin_panel_settings),
      label: 'Dashboard',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.store_outlined),
      activeIcon: Icon(Icons.store),
      label: 'Stores',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.content_paste_outlined),
      activeIcon: Icon(Icons.content_paste),
      label: 'Content',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.support_agent_outlined),
      activeIcon: Icon(Icons.support_agent),
      label: 'Support',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: 'Profil',
    ),
  ];

  List<Widget> get _screens {
    switch (widget.userType) {
      case UserType.customer:
        return _customerScreens;
      case UserType.owner:
        return _ownerScreens;
      case UserType.admin:
        return _adminScreens;
    }
  }

  List<BottomNavigationBarItem> get _navItems {
    switch (widget.userType) {
      case UserType.customer:
        return _customerNavItems;
      case UserType.owner:
        return _ownerNavItems;
      case UserType.admin:
        return _adminNavItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: _navItems,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}