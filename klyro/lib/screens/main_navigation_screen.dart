import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/app_logger.dart';
import 'dashboard_screen.dart';
import 'venue_listing_screen.dart';
import 'responsive_layout.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 1; // Default to Home (center)

  final List<String> _tabNames = ['Book', 'Home', 'More'];

  final List<Widget> _screens = [
    const VenueListingScreen(), // Book (Left)
    const DashboardScreen(), // Home (Center)
    const ResponsiveLayoutScreen(), // More (Right)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 12, 24, 20),
        child: _buildFloatingNavBar(),
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppTheme.navBarDark,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(0, Icons.book_online_outlined, "Book"),
          _buildNavItem(1, Icons.home_rounded, ""),
          _buildNavItem(2, Icons.more_horiz, "More"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData iconData, String label) {
    final isSelected = _currentIndex == index;
    final bool isCenterHome = index == 1;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
            AppLogger.debug(
              '📱 Navigated to tab: ${_tabNames[index]} (index: $index)',
            );
          });
        },
        borderRadius: BorderRadius.circular(35),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: isCenterHome
              ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.primaryGreen
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryGreen, width: 2),
                  ),
                  child: Icon(
                    iconData,
                    color: isSelected ? Colors.black : Colors.white70,
                  ),
                )
              : Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        iconData,
                        color: isSelected ? Colors.white : Colors.white54,
                      ),
                    ),
                    if (label.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Text(
                        label,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.white54,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
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
