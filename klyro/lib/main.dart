import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/create_booking_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/venue_details_screen.dart';
import 'screens/venue_listing_screen.dart';
import 'theme/app_theme.dart';
import 'utils/app_logger.dart';

/// Named route constants for type-safe navigation
class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String venueDetails = '/venue-details';
  static const String venueListing = '/venue-listing';
  static const String createBooking = '/create-booking';
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppLogger.debug('🚀 TurfBookingApp initialized — Firebase ready');
  runApp(const TurfBookingApp());
}

class TurfBookingApp extends StatelessWidget {
  const TurfBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turf Scheduler',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,

      // Auth-based initial screen
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            AppLogger.debug('⏳ Checking auth state...');
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data == null) {
            AppLogger.debug('🔒 User not logged in — showing LoginScreen');
            return const LoginScreen();
          }
          AppLogger.debug('✅ User logged in: ${snapshot.data!.email}');
          return const MainNavigationScreen();
        },
      ),

      // Named routes for multi-screen navigation
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.venueListing: (context) => const VenueListingScreen(),
        AppRoutes.createBooking: (context) => const CreateBookingScreen(),
      },

      // onGenerateRoute handles routes that need arguments
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.venueDetails) {
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            builder: (context) => VenueDetailsScreen(venueData: args),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
