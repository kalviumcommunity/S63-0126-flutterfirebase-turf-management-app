import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ResponsiveHomeScreen extends StatelessWidget {
  const ResponsiveHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Implement Responsiveness with MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(
        title: const Text('Responsive Layout Demo'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        // 3. Apply Flexible and Adaptive Widgets using LayoutBuilder
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (isTablet) {
              // Tablet Layout: Two-column grid / row
              return _buildTabletLayout(context, constraints);
            } else {
              // Phone Layout: Single-column scroll
              return _buildMobileLayout(context, constraints);
            }
          },
        ),
      ),
      // Footer/Action section
      bottomNavigationBar: _buildFooterSection(isTablet),
    );
  }

  // Vertical scrolling single column for phones
  Widget _buildMobileLayout(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeroHeader(isTablet: false),
          const SizedBox(height: 24),
          const Text(
            'Recent Activities',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 16),
          // Using Wrap for responsive positioning of small elements
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              4,
              (index) => _buildActivityCard(width: constraints.maxWidth),
            ),
          ),
        ],
      ),
    );
  }

  // Two column layout for wider screens
  Widget _buildTabletLayout(BuildContext context, BoxConstraints constraints) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column holds the Hero header
          Expanded(
            flex: 2,
            child: Column(children: [_buildHeroHeader(isTablet: true)]),
          ),
          const SizedBox(width: 32),
          // Right Column holds the grid of activities
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Recent Activities',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  // GridView makes the UI scalable
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.2,
                        ),
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        _buildActivityCard(width: double.infinity),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader({required bool isTablet}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      decoration: BoxDecoration(
        color: AppTheme.darkGreen,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back, Team!',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 32 : 24, // Adjust text size conditionally
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'This box automatically scales and adjusts its internal padding based on whether you are using a mobile or tablet size device.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: isTablet ? 18 : 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({required double width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.sports_soccer,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(width: 16),
          // Expanded ensures text doesn't overflow
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Keep column from expanding infinitely
              children: [
                Text(
                  'Evening Match',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'Today, 6:00 PM',
                  style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? 48 : 24,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -5),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'View All Bookings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
