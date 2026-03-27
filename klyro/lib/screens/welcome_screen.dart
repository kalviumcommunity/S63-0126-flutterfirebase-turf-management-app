import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // State variable to track button interaction
  bool _isSearching = false;

  // Function to toggle the state
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Turf Hub'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Icon that changes color based on state
            Icon(
              Icons.sports_soccer,
              size: 120,
              color: _isSearching ? Colors.orange : Colors.green,
            ),
            const SizedBox(height: 30),

            // Text that changes based on state
            Text(
              _isSearching
                  ? 'Searching for available slots...'
                  : 'Let\'s prevent double-bookings!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Button triggering the state change
            ElevatedButton.icon(
              onPressed: _toggleSearch,
              icon: Icon(_isSearching ? Icons.cancel : Icons.search),
              label: Text(
                _isSearching ? 'Cancel Search' : 'Find Turf Availability',
              ),
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
