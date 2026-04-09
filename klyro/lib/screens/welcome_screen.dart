import 'package:flutter/material.dart';

// The Welcome Screen widget which actively tracks dynamic states natively
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

// Private state class mapping physical updates directly onto the Welcome Screen
class _WelcomeScreenState extends State<WelcomeScreen> {
  // Local boolean state variable tracking specifically if a user clicked search
  bool _isSearching = false;

  // Function securely toggling the underlying _isSearching boolean
  void _toggleSearch() {
    // setState actively tells Flutter's mapping engine to physically redraw the layout matching updated values
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold constructs the fundamental material layout bounds securely
    return Scaffold(
      // AppBar structures the standard topmost header natively
      appBar: AppBar(
        title: const Text('Community Turf Hub'),
        // Dynamically rips the inversePrimary color string actively out from AppTheme configurations
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Centers the immediate child boundaries vertically and horizontally safely
      body: Center(
        // Renders arrays vertically flowing straight down structurally
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Interactive physical icon constantly evaluating boolean presence to swap colored paths dynamically
            Icon(
              Icons.sports_soccer,
              size: 120,
              // Ternary conditional logic switching between custom colors safely
              color: _isSearching ? Colors.orange : Colors.green,
            ),
            // Physical spacing block mapping distances structurally
            const SizedBox(height: 30),

            // Dynamic text parameter translating state flags into human-readable strings
            Text(
              _isSearching
                  ? 'Searching for available slots...'
                  : 'Let\'s prevent double-bookings!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Button actively mapped executing the state toggle physically
            ElevatedButton.icon(
              onPressed: _toggleSearch,
              // Inline checks completely replacing the internal Icon strings
              icon: Icon(_isSearching ? Icons.cancel : Icons.search),
              label: Text(
                _isSearching ? 'Cancel Search' : 'Find Turf Availability',
              ),
              // Layout parameters extending the button widths actively
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
