import 'package:flutter/material.dart';
import '../services/booking_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/section_header.dart';

class CreateBookingScreen extends StatefulWidget {
  const CreateBookingScreen({super.key});

  @override
  State<CreateBookingScreen> createState() => _CreateBookingScreenState();
}

class _CreateBookingScreenState extends State<CreateBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _teamNameController = TextEditingController();

  String? _selectedTime;

  final List<String> _availableTimeSlots = [
    '7:00 AM - 8:00 AM',
    '8:00 AM - 9:00 AM',
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 1:00 PM',
    '1:00 PM - 2:00 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
    '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM',
    '7:00 PM - 8:00 PM',
    '8:00 PM - 9:00 PM',
    '9:00 PM - 10:00 PM',
    '10:00 PM - 11:00 PM',
  ];

  final List<String> _availableTurfs = [
    'Green Arena Turf',
    'Striker Dome',
    'Champions Ground',
    'Urban Kick Arena',
  ];

  String? _selectedTurf;
  bool _isSubmitting = false;
  String? _dropdownError;
  String? _timeError;
  DateTime? _selectedDate;
  String? _dateError;
  String? _successMessage;

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }

  Future<void> _submitBooking() async {
    final bool isFormValid = _formKey.currentState?.validate() ?? false;
    final bool isTurfValid = _selectedTurf != null;
    final bool isTimeValid = _selectedTime != null;
    final bool isDateValid = _selectedDate != null;

    setState(() {
      _dropdownError = isTurfValid ? null : 'Please select a turf.';
      _timeError = isTimeValid ? null : 'Please select a time slot.';
      _dateError = isDateValid ? null : 'Please select a date.';
      _successMessage = null;
    });

    if (!isFormValid || !isTurfValid || !isTimeValid || !isDateValid) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (!mounted) return;

    BookingService.instance.addBooking(
      turfName: _selectedTurf!,
      teamName: _teamNameController.text.trim(),
      timeSlot: _selectedTime!,
      date: _selectedDate!,
    );

    final String confirmation =
        'Booking created for ${_teamNameController.text.trim()} at $_selectedTurf ($_selectedTime on ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year})';

    setState(() {
      _isSubmitting = false;
      _successMessage = confirmation;
      _teamNameController.clear();
      _selectedTurf = null;
      _selectedTime = null;
      _selectedDate = null;
      _dropdownError = null;
      _timeError = null;
      _dateError = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(confirmation)));
  }

  List<String> _getBookedSlots(String turf, DateTime date) {
    return BookingService.instance.bookingsNotifier.value
        .where((b) => b.turfName == turf && b.date.year == date.year && b.date.month == date.month && b.date.day == date.day)
        .map((b) => b.timeSlot)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTurfAndDateSelected = _selectedTurf != null && _selectedDate != null;
    final List<String> bookedSlots = isTurfAndDateSelected ? _getBookedSlots(_selectedTurf!, _selectedDate!) : [];

    return Scaffold(
      appBar: AppBar(title: const Text('Create Booking')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Schedule Your Match',
                  subtitle: 'Lock in turf, time, and team details in seconds.',
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  controller: _teamNameController,
                  hintText: 'Team Name',
                  icon: Icons.groups_2_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Team name is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedTurf,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  decoration: InputDecoration(
                    hintText: 'Select Turf',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.stadium_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _availableTurfs
                      .map(
                        (turf) =>
                            DropdownMenuItem(value: turf, child: Text(turf)),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTurf = value;
                      _dropdownError = null;
                      _successMessage = null;
                      if (_selectedTime != null && _selectedDate != null && value != null) {
                        if (_getBookedSlots(value, _selectedDate!).contains(_selectedTime)) {
                           _selectedTime = null;
                        }
                      }
                    });
                  },
                ),
                if (_dropdownError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _dropdownError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                InkWell(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                        _dateError = null;
                        if (_selectedTime != null && _selectedTurf != null) {
                          if (_getBookedSlots(_selectedTurf!, picked).contains(_selectedTime)) {
                             _selectedTime = null;
                          }
                        }
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'Select Date',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: TextStyle(
                        color: _selectedDate == null ? AppTheme.textSecondary : AppTheme.textDark,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (_dateError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _dateError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedTime,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  decoration: InputDecoration(
                    hintText: 'Select Time Slot',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.schedule_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: _availableTimeSlots.map((time) {
                    final bool isBooked = isTurfAndDateSelected && bookedSlots.contains(time);
                    return DropdownMenuItem<String>(
                      value: time,
                      enabled: !isBooked,
                      child: Text(
                        isBooked ? '$time (Booked)' : time,
                        style: TextStyle(
                          color: isBooked ? AppTheme.textSecondary : AppTheme.textDark,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedTime = value;
                      _timeError = null;
                      _successMessage = null;
                    });
                  },
                ),
                if (_timeError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _timeError!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Submit Booking',
                  loading: _isSubmitting,
                  onPressed: _submitBooking,
                ),
                if (_successMessage != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      _successMessage!,
                      style: const TextStyle(
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
