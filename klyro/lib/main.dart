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
import 'screens/my_calendar_screen.dart';
import 'theme/app_theme.dart';
import 'utils/app_logger.dart';

/// Named route constants for type-safe navigation.
/// Utilizing variables explicitly prevents spelling errors breaking Navigator paths.
class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';
  static const String venueDetails = '/venue-details';
  static const String venueListing = '/venue-listing';
  static const String createBooking = '/create-booking';
  static const String calendar = '/calendar';
}

// Global execution point evaluating async operations prior to flutter mapping widgets
Future<void> main() async {
  // Required execution binding confirming physical engine dependencies initialize fully prior to Google execution commands
  WidgetsFlutterBinding.ensureInitialized();
  
  // Fires connections directly into your hosted Firebase backend, pulling correct OS configurations actively 
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  // Safe execution tracer 
  AppLogger.debug('🚀 TurfBookingApp initialized — Firebase ready');
  
  // Mount the root widget onto screen parameters physically
  runApp(const TurfBookingApp());
}

class TurfBookingApp extends StatelessWidget {
  const TurfBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Generates the global Material layout array determining total app functionality wrappers natively
    return MaterialApp(
      title: 'Turf Scheduler',
      // Applies the global aesthetic constraints identically (Colors/Typographies/Styles) universally across app
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false, // Disables visual visual debug overlay

      // Auth-based initial screen logic checking session presence
      home: StreamBuilder<User?>(
        // Stream tracking user auth updates silently from backend loops natively
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Evaluating internal calculations block - Returns a spinning indicator explicitly while loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            AppLogger.debug('⏳ Checking auth state...');
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          // If no token exists, lock to registration/login natively
          if (snapshot.data == null) {
            AppLogger.debug('🔒 User not logged in — showing LoginScreen');
            return const LoginScreen();
          }
          // Safely passed - boot User payload successfully into base architecture
          AppLogger.debug('✅ User logged in: ${snapshot.data!.email}');
          return const MainNavigationScreen();
        },
      ),

      // Physical route maps matching custom routing class declarations cleanly over directly toward respective screen widgets
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.venueListing: (context) => const VenueListingScreen(),
        AppRoutes.createBooking: (context) => const CreateBookingScreen(),
        AppRoutes.calendar: (context) => const MyCalendarScreen(),
      },

      // Dynamic path handling mechanism specifically processing parameter mappings dynamically (Venue details need payloads)
      onGenerateRoute: (settings) {
        // If system calls out specifically looking for the detail view page natively 
        if (settings.name == AppRoutes.venueDetails) {
          // Captures payload dynamically checking and unpacking object structure safely
          final args = settings.arguments as Map<String, dynamic>?;
          return MaterialPageRoute(
            // Transports data straight into the custom widget constructor successfully 
            builder: (context) => VenueDetailsScreen(venueData: args),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
