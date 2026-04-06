import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isTablet = screenWidth >= 700;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: isTablet ? 32 : 24,
            right: isTablet ? 32 : 24,
            top: 16,
            bottom: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildSearchBar(),
              const SizedBox(height: 24),
              _buildFeaturedCard(context: context, isTablet: isTablet),
              const SizedBox(height: 24),
              _buildServicesGrid(screenWidth: screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();
    final email = user?.email ?? 'Player';
    final greetingName = (displayName != null && displayName.isNotEmpty)
        ? displayName
        : email.split('@').first;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.profile);
                },
                customBorder: const CircleBorder(),
                child: const Padding(
                  padding: EdgeInsets.all(2),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=11',
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey, $greetingName',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.location_on_outlined,
                size: 20,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 20,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Royal Grass UK',
          hintStyle: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
          ),
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondary),
          suffixIcon: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              size: 16,
              color: AppTheme.textSecondary,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCard({
    required BuildContext context,
    required bool isTablet,
  }) {
    return Container(
      width: double.infinity,
      height: isTablet ? 320 : 280,
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen,
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1518605368461-1ee71168f278?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
          ), // Grass texture base
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryGreen.withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Overlay green gradient to make it look exactly like the design
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryGreen.withValues(alpha: 0.8),
                  AppTheme.darkGreen.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // Placeholder for soccer ball
                Container(
                  width: isTablet ? 92 : 80,
                  height: isTablet ? 92 : 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/53/53283.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Find & Book Your\nPerfect Turf!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 26 : 22,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.createBooking);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Book Now ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Icon(Icons.arrow_outward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid({required double screenWidth}) {
    final List<Map<String, dynamic>> services = [
      {'icon': Icons.calendar_month_outlined, 'title': 'My Calender'},
      {'icon': Icons.edit_document, 'title': 'Create Activity'},
      {'icon': Icons.timer_outlined, 'title': 'Quick Book'},
      {'icon': Icons.favorite_border, 'title': 'Favourite\nVenues'},
      {'icon': Icons.leaderboard_outlined, 'title': 'Leaderboard'},
      {'icon': Icons.local_offer_outlined, 'title': 'Offers'},
    ];

    final int crossAxisCount = screenWidth >= 1100
        ? 4
        : screenWidth >= 700
        ? 3
        : 3;
    final double spacing = screenWidth >= 700 ? 16 : 12;
    final double horizontalPadding = screenWidth >= 700 ? 64 : 48;
    final double tileWidth =
        (screenWidth - horizontalPadding - (spacing * (crossAxisCount - 1))) /
        crossAxisCount;
    final double tileHeight = screenWidth >= 700 ? 148 : 126;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: tileWidth / tileHeight,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              if (index == 0) {
                Navigator.pushNamed(context, AppRoutes.calendar);
              } else if (index == 1 || index == 2) {
                Navigator.pushNamed(context, AppRoutes.createBooking);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    services[index]['icon'],
                    color: AppTheme.darkGreen,
                    size: screenWidth >= 700 ? 32 : 28,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    services[index]['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth >= 700 ? 13 : 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
