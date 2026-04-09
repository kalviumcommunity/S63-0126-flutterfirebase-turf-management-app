import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';

// A mock backend class handling the scheduling logic in local memory
class BookingService {
  // Uses a Singleton design pattern. This means there is only ever ONE instance 
  // of BookingService in the entire application's memory.
  BookingService._privateConstructor();
  static final BookingService instance = BookingService._privateConstructor();

  // ValueNotifier is a reactive state holder. Any UI element can "listen" to this. 
  // Whenever we update this list, the calendar screen gets notified and redraws itself immediately.
  final ValueNotifier<List<Booking>> bookingsNotifier = ValueNotifier([]);

  // The primary logic method mapping form variables into a true Booking Data Object
  void addBooking({
    required String turfName,
    required String teamName,
    required String timeSlot,
    required DateTime date,
  }) {
    // We instantiate the model precisely requiring all inputs, forging a fake ID using the current millisecond time natively
    final newBooking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      turfName: turfName,
      teamName: teamName,
      timeSlot: timeSlot,
      date: date,
    );

    // Instead of using array.add() blindly, we completely copy the current list.
    // Overriding the notifier directly with a 'new' list is what triggers the flutter UI listener perfectly.
    final currentBookings = List<Booking>.from(bookingsNotifier.value);
    currentBookings.add(newBooking);
    
    // Pushing the duplicated array back dynamically updates the states
    bookingsNotifier.value = currentBookings;
  }
}
