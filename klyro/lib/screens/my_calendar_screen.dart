import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../services/booking_service.dart';
import '../models/booking_model.dart';
import '../theme/app_theme.dart';

class MyCalendarScreen extends StatefulWidget {
  const MyCalendarScreen({super.key});

  @override
  State<MyCalendarScreen> createState() => _MyCalendarScreenState();
}

class _MyCalendarScreenState extends State<MyCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  // Get bookings for a specific day
  List<Booking> _getBookingsForDay(DateTime day, List<Booking> allBookings) {
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
      body: ValueListenableBuilder<List<Booking>>(
        valueListenable: BookingService.instance.bookingsNotifier,
        builder: (context, bookings, _) {
          final selectedBookings = _selectedDay != null
              ? _getBookingsForDay(_selectedDay!, bookings)
              : [];

          return Column(
            children: [
              TableCalendar<Booking>(
                firstDay: DateTime.now().subtract(const Duration(days: 365)),
                lastDay: DateTime.now().add(const Duration(days: 365)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                eventLoader: (day) => _getBookingsForDay(day, bookings),
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
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: selectedBookings.isEmpty
                    ? const Center(
                        child: Text(
                          'No bookings for this day',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: selectedBookings.length,
                        itemBuilder: (context, index) {
                          final booking = selectedBookings[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.sports_soccer, color: AppTheme.primaryGreen),
                              title: Text(
                                booking.turfName,
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
