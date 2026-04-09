class Booking {
  // Unique identifier for the booking (e.g. timestamp string)
  final String id;
  // The display name of the turf facility being booked
  final String turfName;
  // The user's team name
  final String teamName;
  // The specific time range selected (e.g. "10:00 AM - 11:00 AM")
  final String timeSlot;
  // The exact calendar date the booking occurs on
  final DateTime date;

  // Named constructor requiring all variables to be provided
  // Ensures nobody can create an incomplete booking instance.
  Booking({
    required this.id,
    required this.turfName,
    required this.teamName,
    required this.timeSlot,
    required this.date,
  });
}
