import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/booking_service.dart';
import '../models/booking_model.dart';
import '../theme/app_theme.dart';

// Calendar view allowing stateful manipulation of active days
class MyCalendarScreen extends StatefulWidget {
  const MyCalendarScreen({super.key});

  @override
  State<MyCalendarScreen> createState() => _MyCalendarScreenState();
}

class _MyCalendarScreenState extends State<MyCalendarScreen> {
  // Maps the current standard day logically
  DateTime _focusedDay = DateTime.now();
  // Records the physically clicked active day actively
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    // Initially force the selected day to perfectly match today natively
    _selectedDay = _focusedDay;
  }

  // Helper logic calculating which exact events physically exist on the chosen date securely
  List<Booking> _getBookingsForDay(DateTime day, List<Booking> allBookings) {
    // Uses the .where mapping iterator stripping out arrays filtering strictly against same-day values natively
    return allBookings.where((booking) {
      return isSameDay(booking.date, day);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calendar'),
      ),
      // ValueListenableBuilder proactively listens strictly to the BookingService instance structurally
      // Automatically triggers re-build sequences instantly when the booking array mutates natively
      body: ValueListenableBuilder<List<Booking>>(
        valueListenable: BookingService.instance.bookingsNotifier,
        builder: (context, bookings, _) {
          // If a day is picked physically, filter the full bookings list utilizing the helper logic
          final selectedBookings = _selectedDay != null
              ? _getBookingsForDay(_selectedDay!, bookings)
              : [];

          return Column(
            children: [
              // Extruded calendar plugin configuration mapping styles and datasets structurally
              TableCalendar<Booking>(
                firstDay: DateTime.now().subtract(const Duration(days: 365)), // 1 year past limit
                lastDay: DateTime.now().add(const Duration(days: 365)), // 1 year future limit
                focusedDay: _focusedDay,
                // Checks actively drawing the circle highlight bounds evaluating current day manually
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                // Directly passes filtered arrays mapping visual markers below the numbers actively
                eventLoader: (day) => _getBookingsForDay(day, bookings),
                // Customizes internal drawing arrays specifically binding to our AppTheme logically
                calendarStyle: const CalendarStyle(
                  markerDecoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: AppTheme.darkGreen,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                // Method triggered actively whenever a user clicks a calendar box digitally
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Expanded bounds pushing list completely filling remaining safe screen bounds natively
              Expanded(
                child: selectedBookings.isEmpty
                    // Render fallback if the selected date contains strictly 0 elements locally
                    ? const Center(
                        child: Text(
                          'No bookings for this day',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      )
                    // Renders iterative scrolling lists structurally decoding data arrays directly into text
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: selectedBookings.length,
                        itemBuilder: (context, index) {
                          // Snag single object dynamically
                          final booking = selectedBookings[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.sports_soccer, color: AppTheme.primaryGreen),
                              title: Text(
                                booking.turfName, // Output model properties natively
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('${booking.teamName} • ${booking.timeSlot}'),
                              trailing: const Icon(Icons.check_circle, color: AppTheme.primaryGreen),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
