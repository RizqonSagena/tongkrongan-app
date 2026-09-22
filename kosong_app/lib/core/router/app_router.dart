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
// Owner Routes
import '../../features/owner/notifications/views/owner_notifications_screen.dart';
import '../../features/owner/stock/views/stock_dashboard_screen.dart';
import '../../features/owner/stock/views/stock_input_screen.dart';
import '../../features/owner/stock/views/stock_history_screen.dart';
import '../../features/owner/analytics/views/rating_reviews_screen.dart';
import '../../features/owner/analytics/views/customer_interest_screen.dart';
import '../../features/owner/chat_management/views/owner_chat_detail_screen.dart';
import '../../features/owner/profile/views/hpp_menu_screen.dart';
import '../../features/owner/profile/views/hpp_calculator_screen.dart';
import '../../features/owner/orders/views/orders_screen.dart';

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
  
  // Owner Routes
  static const String ownerNotifications = '/owner/notifications';
  static const String ownerStockDashboard = '/owner/stock-dashboard';
  static const String ownerStockInput = '/owner/stock-input';
  static const String ownerStockHistory = '/owner/stock-history';
  static const String ownerRatingReviews = '/owner/rating-reviews';
  static const String ownerCustomerInterest = '/owner/customer-interest';
  static const String ownerChatDetail = '/owner/chat-detail';
  static const String ownerHppMenu = '/owner/hpp-menu';
  static const String ownerHppCalculator = '/owner/hpp-calculator';
  static const String ownerOrders = '/owner/orders';

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
      
      // Owner Route Builders
      case ownerNotifications:
        return MaterialPageRoute(
          builder: (_) => const OwnerNotificationsScreen(),
          settings: settings,
        );
      case ownerStockDashboard:
        return MaterialPageRoute(
          builder: (_) => const StockDashboardScreen(),
          settings: settings,
        );
      case ownerStockInput:
        return MaterialPageRoute(
          builder: (_) => const StockInputScreen(),
          settings: settings,
        );
      case ownerStockHistory:
        return MaterialPageRoute(
          builder: (_) => const StockHistoryScreen(),
          settings: settings,
        );
      case ownerRatingReviews:
        return MaterialPageRoute(
          builder: (_) => const RatingReviewsScreen(),
          settings: settings,
        );
      case ownerCustomerInterest:
        return MaterialPageRoute(
          builder: (_) => const CustomerInterestScreen(),
          settings: settings,
        );
      case ownerChatDetail:
        return MaterialPageRoute(
          builder: (_) => OwnerChatDetailScreen(
            chatId: settings.arguments as String,
          ),
          settings: settings,
        );
      case ownerHppMenu:
        return MaterialPageRoute(
          builder: (_) => const HppMenuScreen(),
          settings: settings,
        );
      case ownerHppCalculator:
        return MaterialPageRoute(
          builder: (_) => HppCalculatorScreen(
            menuId: settings.arguments as String?,
          ),
          settings: settings,
        );
      case ownerOrders:
        return MaterialPageRoute(
          builder: (_) => const OrdersScreen(),
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