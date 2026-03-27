import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
  const ResponsiveLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final Orientation orientation = MediaQuery.orientationOf(context);
    final bool isTablet = screenSize.width >= 700;
    final bool isDesktopLike = screenSize.width >= 1100;
    final bool useWideLayout =
        isTablet ||
        (orientation == Orientation.landscape && screenSize.width >= 560);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: AppBar(title: const Text('Responsive Layout'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            useWideLayout ? 24 : 16,
            useWideLayout ? 24 : 16,
            useWideLayout ? 24 : 16,
            24,
          ),
          child: useWideLayout
              ? _buildWideLayout(
                  context,
                  screenSize,
                  isDesktopLike: isDesktopLike,
                )
              : _buildCompactLayout(context, screenSize),
        ),
      ),
    );
  }

  Widget _buildCompactLayout(BuildContext context, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeroCard(screenSize, isWide: false),
        const SizedBox(height: 16),
        _buildSectionTitle('Quick Stats'),
        const SizedBox(height: 12),
        Column(
          children: const [
            _StatCard(
              title: 'Active Bookings',
              value: '18',
              subtitle: '4 starting soon',
              icon: Icons.calendar_month_outlined,
            ),
            SizedBox(height: 12),
            _StatCard(
              title: 'Open Turfs',
              value: '06',
              subtitle: '2 under maintenance',
              icon: Icons.grass_outlined,
            ),
            SizedBox(height: 12),
            _StatCard(
              title: 'Team Requests',
              value: '12',
              subtitle: '3 waiting approval',
              icon: Icons.groups_2_outlined,
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildSchedulePanel(isWide: false),
        const SizedBox(height: 16),
        _buildFacilityPanel(isWide: false),
        const SizedBox(height: 16),
        _buildActionBar(isWide: false),
      ],
    );
  }

  Widget _buildWideLayout(
    BuildContext context,
    Size screenSize, {
    required bool isDesktopLike,
  }) {
    if (isDesktopLike) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeroCard(screenSize, isWide: true),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(
                child: _StatCard(
                  title: 'Active Bookings',
                  value: '18',
                  subtitle: '4 starting soon',
                  icon: Icons.calendar_month_outlined,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'Open Turfs',
                  value: '06',
                  subtitle: '2 under maintenance',
                  icon: Icons.grass_outlined,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'Team Requests',
                  value: '12',
                  subtitle: '3 waiting approval',
                  icon: Icons.groups_2_outlined,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _buildSchedulePanel(isWide: true)),
              const SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildFacilityPanel(isWide: true),
                    const SizedBox(height: 24),
                    _buildActionBar(isWide: true),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeroCard(screenSize, isWide: true),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) =>
              _buildStatsWrap(cardWidth: (constraints.maxWidth - 16) / 2),
        ),
        const SizedBox(height: 24),
        _buildSchedulePanel(isWide: true),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildFacilityPanel(isWide: true)),
            const SizedBox(width: 20),
            Expanded(child: _buildActionBar(isWide: true)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsWrap({required double cardWidth}) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        SizedBox(
          width: cardWidth,
          child: const _StatCard(
            title: 'Active Bookings',
            value: '18',
            subtitle: '4 starting soon',
            icon: Icons.calendar_month_outlined,
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const _StatCard(
            title: 'Open Turfs',
            value: '06',
            subtitle: '2 under maintenance',
            icon: Icons.grass_outlined,
          ),
        ),
        SizedBox(
          width: cardWidth,
          child: const _StatCard(
            title: 'Team Requests',
            value: '12',
            subtitle: '3 waiting approval',
            icon: Icons.groups_2_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroCard(Size screenSize, {required bool isWide}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 28 : 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.darkGreen, AppTheme.primaryGreen],
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkGreen.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Turf Control Center',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isWide ? 30 : 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'This screen uses Containers for cards, Columns for vertical stacking, and Rows for side-by-side panels that expand on larger displays.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: isWide ? 16 : 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: isWide ? 88 : 72,
                height: isWide ? 88 : 72,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(
                  Icons.stadium_outlined,
                  color: Colors.white,
                  size: isWide ? 40 : 34,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.devices_outlined,
                  color: Colors.white,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Current width: ${screenSize.width.toStringAsFixed(0)} px',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSchedulePanel({required bool isWide}) {
    return Container(
      padding: EdgeInsets.all(isWide ? 24 : 18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Today\'s Schedule'),
          const SizedBox(height: 14),
          const _ScheduleItem(
            time: '06:00 PM',
            title: 'Evening Football Match',
            detail: 'Pitch A · 14 players confirmed',
          ),
          const SizedBox(height: 12),
          const _ScheduleItem(
            time: '07:30 PM',
            title: 'Coaching Session',
            detail: 'Pitch B · 2 coaches assigned',
          ),
          const SizedBox(height: 12),
          const _ScheduleItem(
            time: '09:00 PM',
            title: 'Corporate Booking',
            detail: 'Clubhouse access enabled',
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityPanel({required bool isWide}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isWide ? 24 : 18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Facility Overview'),
          const SizedBox(height: 14),
          _buildInfoRow(Icons.place_outlined, 'North Arena', '4.8 rating'),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.wb_sunny_outlined,
            'Weather Ready',
            'Covered sidelines',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.local_parking_outlined,
            'Parking',
            '42 slots available',
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Why this layout works',
                  style: TextStyle(
                    color: AppTheme.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Phone screens stack sections vertically, while larger screens split content into columns to preserve breathing room and reduce scrolling.',
                  style: TextStyle(color: AppTheme.textSecondary, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar({required bool isWide}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _panelDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Ready for the next review?',
            style: TextStyle(
              fontSize: isWide ? 18 : 16,
              fontWeight: FontWeight.w700,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This call-to-action stays full width on phones and fits neatly beside the detail panel on tablets.',
            style: TextStyle(color: AppTheme.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Review Layout Responsiveness'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppTheme.darkGreen),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppTheme.textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(color: AppTheme.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppTheme.textDark,
      ),
    );
  }

  BoxDecoration _panelDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool compact = constraints.maxWidth < 250;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: compact
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, color: AppTheme.darkGreen),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(icon, color: AppTheme.darkGreen),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            value,
                            style: const TextStyle(
                              color: AppTheme.textDark,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({
    required this.time,
    required this.title,
    required this.detail,
  });

  final String time;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              time,
              style: const TextStyle(
                color: AppTheme.darkGreen,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppTheme.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  detail,
                  style: const TextStyle(color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
