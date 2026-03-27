import 'package:flutter/material.dart';
import '../main.dart';
import '../theme/app_theme.dart';

class VenueListingScreen extends StatefulWidget {
  const VenueListingScreen({super.key});

  @override
  State<VenueListingScreen> createState() => _VenueListingScreenState();
}

class _VenueListingScreenState extends State<VenueListingScreen> {
  int _selectedCategoryIndex = 2; // Default to Cricket

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.sports_tennis, 'name': 'Badminton'}, // Approximation
    {'icon': Icons.sports_soccer, 'name': 'Football'},
    {'icon': Icons.sports_cricket, 'name': 'Cricket'},
    {'icon': Icons.sports_tennis, 'name': 'Tennis'},
    {'icon': Icons.sports_basketball, 'name': 'Basketball'},
  ];

  final List<Map<String, dynamic>> _venues = [
    {
      'name': 'Trophy Fighters',
      'location': 'Aberdeen City (-2.9)',
      'rating': 4.5,
      'image':
          'https://images.unsplash.com/photo-1574629810360-7efbb1925536?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    },
    {
      'name': 'Rush Arena UK',
      'location': 'Northumberland (-3.9)',
      'rating': 4.0,
      'image':
          'https://images.unsplash.com/photo-1508344928928-7165b67de128?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    },
    {
      'name': '7 Star Lords Turf',
      'location': 'South Humberside (-7.3)',
      'rating': 5.0,
      'image':
          'https://plus.unsplash.com/premium_photo-1661962386183-b684cb7b1129?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    },
    {
      'name': 'Colosseum Yorkshir',
      'location': 'South Yorkshire (-3.9)',
      'rating': 4.5,
      'image':
          'https://images.unsplash.com/photo-1518605368461-1ee71168f278?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    },
    {
      'name': 'Square Out Arena',
      'location': 'West Berkshire (-10.5)',
      'rating': 4.0,
      'image':
          'https://images.unsplash.com/photo-1529900895318-7b9c9f2b1d31?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    },
    {
      'name': 'The Elite Sports',
      'location': 'Hertfordshire County',
      'rating': 4.5,
      'image':
          'https://images.unsplash.com/photo-1459865264687-595d652de67e?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final bool isTablet = screenWidth >= 700;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(isTablet: isTablet),
            const SizedBox(height: 20),
            _buildCategoryList(isTablet: isTablet),
            const SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isTablet ? 32 : 24),
              child: Text(
                'For ${_categories[_selectedCategoryIndex]['name']} Ground',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: _buildVenueGrid(screenWidth: screenWidth)),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar({required bool isTablet}) {
    return Padding(
      padding: EdgeInsets.only(left: isTablet ? 24 : 16, right: 24, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.textDark),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
              const SizedBox(width: 8),
              const Text(
                'Book Your Venues',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
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
                  Icons.filter_alt_outlined,
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
                  Icons.search,
                  size: 20,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList({required bool isTablet}) {
    return SizedBox(
      height: isTablet ? 104 : 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Container(
                      width: isTablet ? 68 : 60,
                      height: isTablet ? 68 : 60,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryGreen
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _categories[index]['icon'],
                        color: isSelected ? Colors.black : AppTheme.textDark,
                        size: isTablet ? 30 : 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _categories[index]['name'],
                      style: TextStyle(
                        fontSize: isTablet ? 13 : 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? AppTheme.textDark
                            : AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVenueGrid({required double screenWidth}) {
    final double horizontalPadding = screenWidth >= 700 ? 32 : 24;
    final int crossAxisCount = screenWidth >= 1200
        ? 4
        : screenWidth >= 900
        ? 3
        : screenWidth >= 700
        ? 2
        : 1;
    final double gridSpacing = screenWidth >= 700 ? 20 : 16;
    final double usableWidth = screenWidth - (horizontalPadding * 2);
    final double cardWidth =
        (usableWidth - (gridSpacing * (crossAxisCount - 1))) / crossAxisCount;
    final double imageHeight = screenWidth >= 900 ? 160 : 140;
    final double cardHeight = imageHeight + (screenWidth >= 700 ? 142 : 132);

    return GridView.builder(
      padding: EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: 24,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: cardWidth / cardHeight,
        crossAxisSpacing: gridSpacing,
        mainAxisSpacing: gridSpacing,
      ),
      itemCount: _venues.length,
      itemBuilder: (context, index) {
        final venue = _venues[index];
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.venueDetails,
                arguments: venue,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      venue['image'],
                      height: imageHeight,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: imageHeight,
                          color: AppTheme.backgroundLight,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                            color: AppTheme.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth >= 700 ? 16 : 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue['name'],
                          style: TextStyle(
                            fontSize: screenWidth >= 700 ? 16 : 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 12,
                              color: AppTheme.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                venue['location'],
                                style: TextStyle(
                                  fontSize: screenWidth >= 700 ? 11 : 10,
                                  color: AppTheme.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: _buildRatingIcons(
                            venue['rating'] as double,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: [
                            _buildMiniIcon(Icons.sports_cricket_outlined),
                            _buildMiniIcon(Icons.sports_soccer_outlined),
                            _buildMiniIcon(Icons.sports_tennis_outlined),
                          ],
                        ),
                      ],
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

  List<Widget> _buildRatingIcons(double rating) {
    return List.generate(5, (starIndex) {
      final bool isFullStar = starIndex < rating.floor();
      final bool isHalfStar =
          !isFullStar && starIndex < rating && rating - rating.floor() >= 0.5;
      return Icon(
        isFullStar
            ? Icons.star
            : isHalfStar
            ? Icons.star_half
            : Icons.star_border,
        size: 12,
        color: Colors.amber,
      );
    });
  }

  Widget _buildMiniIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 12, color: AppTheme.textSecondary),
    );
  }
}
