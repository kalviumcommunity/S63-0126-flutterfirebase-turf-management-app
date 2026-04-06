import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';

class BookingService {
  // Singleton pattern for simple global in-memory state
  BookingService._privateConstructor();
  static final BookingService instance = BookingService._privateConstructor();

  final ValueNotifier<List<Booking>> bookingsNotifier = ValueNotifier([]);

  void addBooking({
    required String turfName,
    required String teamName,
    required String timeSlot,
    required DateTime date,
  }) {
    final newBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      turfName: turfName,
      teamName: teamName,
      timeSlot: timeSlot,
      date: date,
    );

    // Create a new list and update the notifier to trigger listeners
    final currentBookings = List<Booking>.from(bookingsNotifier.value);
    currentBookings.add(newBooking);
    bookingsNotifier.value = currentBookings;
  }
}
