import 'package:flutter/material.dart';
import '../../features/shared/auth/views/splash_screen.dart';
import '../../features/shared/auth/views/login_screen.dart';
import '../../features/customer/explore/views/explore_screen.dart';
import '../../features/customer/detail_place/views/detail_place_screen.dart';
import '../../features/customer/favorites/views/favorites_screen.dart';
import '../../features/customer/booking/views/booking_screen.dart';
import '../../features/customer/booking/views/booking_detail_screen.dart';
import '../../features/customer/booking/views/booking_change_request_screen.dart';
import '../../features/customer/chat/views/chat_screen.dart';
import '../../features/customer/profile/views/profile_screen.dart';
import '../widgets/main_layout.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String customerHome = '/customer';
  static const String ownerHome = '/owner';
  static const String adminHome = '/admin';
  static const String explore = '/explore';
  static const String detailPlace = '/detail-place';
  static const String favorites = '/favorites';
  static const String booking = '/booking';
  static const String bookingDetail = '/booking-detail';
  static const String bookingChangeRequest = '/booking-change-request';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );
      case customerHome:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(userType: UserType.customer),
          settings: settings,
        );
      case ownerHome:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(userType: UserType.owner),
          settings: settings,
        );
      case adminHome:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(userType: UserType.admin),
          settings: settings,
        );
      case explore:
        return MaterialPageRoute(
          builder: (_) => const ExploreScreen(),
          settings: settings,
        );
      case detailPlace:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => DetailPlaceScreen(
            placeId: args?['placeId'] ?? '',
          ),
          settings: settings,
        );
      case favorites:
        return MaterialPageRoute(
          builder: (_) => const FavoritesScreen(),
          settings: settings,
        );
      case booking:
        return MaterialPageRoute(
          builder: (_) => const BookingScreen(),
          settings: settings,
        );
      case bookingDetail:
        return MaterialPageRoute(
          builder: (_) => BookingDetailScreen(
            bookingId: settings.arguments as String,
          ),
          settings: settings,
        );
      case bookingChangeRequest:
        return MaterialPageRoute(
          builder: (_) => BookingChangeRequestScreen(
            bookingId: settings.arguments as String,
          ),
          settings: settings,
        );
      case chat:
        return MaterialPageRoute(
          builder: (_) => const ChatScreen(),
          settings: settings,
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}