import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/app_logger.dart';
import 'dashboard_screen.dart';
import 'venue_listing_screen.dart';
import 'responsive_layout.dart';

// The root wrapper mapping tab-based page viewing securely
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Default index mapping the user exactly onto the center "Home" tab on load
  int _currentIndex = 1; 

  // String arrays dynamically logging exact active page bindings
  final List<String> _tabNames = ['Book', 'Home', 'More'];

  // Widget arrays binding to the physical index natively resolving screens structurally
  // NOTE: This prevents full re-loads of the screens as we switch between them
  final List<Widget> _screens = [
    const VenueListingScreen(), // Book (Left mapped index 0)
    const DashboardScreen(), // Home (Center mapped index 1)
    const ResponsiveLayoutScreen(), // More (Right mapped index 2)
  ];

  @override
  Widget build(BuildContext context) {
    // Top-level scaffold preventing underlying elements from bleeding incorrectly
    return Scaffold(
      extendBody: false,
      // IndexedStack specifically preserves form data without reloading entire screens when swapping natively
      body: IndexedStack(index: _currentIndex, children: _screens),
      // SafeArea physically checks iPhone/Android notch spaces buffering the shadow boundaries natively
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        child: _buildFloatingNavBar(),
      ),
    );
  }

  // Extracted custom builder separating UI padding completely from the upper Scaffold map locally
  Widget _buildFloatingNavBar() {
    return Container(
      height: 70, // Fixed height structural boundaries
      decoration: BoxDecoration(
        color: AppTheme.navBarDark, // Applies correct dark theme styling directly
        borderRadius: BorderRadius.circular(35), // Heavy styling curve mathematically
        boxShadow: [
          // Elevates the physical box off the background rendering an actual drop-shadow effect natively
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        // Spaces all inner navigation items uniformly stretching horizontally over width
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Execute parameterized inline builders generating dynamically mapped interactive buttons
          _buildNavItem(0, Icons.book_online_outlined, "Book"),
          _buildNavItem(1, Icons.home_rounded, ""), // Center gets completely blank custom layout logic inside builder
          _buildNavItem(2, Icons.more_horiz, "More"),
        ],
      ),
    );
  }

  // Builder method mapping dynamically structured logic handling selected tab highlights properly
  Widget _buildNavItem(int index, IconData iconData, String label) {
    // Evaluates physically if this specific button holds current index matching securely natively
    final isSelected = _currentIndex == index;
    final bool isCenterHome = index == 1; // Explicit evaluator checking specifically for the center button index

    return Material(
      color: Colors.transparent, // Prevents default white box container bleeding effects natively
      child: InkWell(
        // Registers physical button clicks across hardware structurally
        onTap: () {
          // Mutates state explicitly triggering the IndexedStack visual switch logic natively
          setState(() {
            _currentIndex = index;
            AppLogger.debug('📱 Navigated to tab: ${_tabNames[index]} (index: $index)');
          });
        },
        // Physical bounds clamping the splash animation when clicked ensuring it matches styling precisely
        borderRadius: BorderRadius.circular(35),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          // Deep ternary conditional evaluation entirely rendering a unique UI for center mappings alone
          child: isCenterHome
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    // Highlights center dynamically entirely based on selection map cleanly
                    color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryGreen, width: 2), // Ring structure
                  ),
                  child: Icon(
                    iconData,
                    color: isSelected ? Colors.black : Colors.white70,
                  ),
                )
              : Row( // Renders Standard Left/Right parameters linearly
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      // Generates subtle white alpha highlighting structurally beneath the active icons natively
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withValues(alpha: 0.1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(12), // Distinct rounded square layout differently mapped
                      ),
                      child: Icon(iconData, color: isSelected ? Colors.white : Colors.white54),
                    ),
                    // Specific Dart array spread syntax injecting text widget ONLY if there is actual length evaluated natively
                    if (label.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
