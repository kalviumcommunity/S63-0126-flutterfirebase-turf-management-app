import 'package:flutter/material.dart';
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
  final _timeController = TextEditingController();

  final List<String> _availableTurfs = [
    'Green Arena Turf',
    'Striker Dome',
    'Champions Ground',
    'Urban Kick Arena',
  ];

  String? _selectedTurf;
  bool _isSubmitting = false;
  String? _dropdownError;
  String? _successMessage;

  @override
  void dispose() {
    _teamNameController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _submitBooking() async {
    final bool isFormValid = _formKey.currentState?.validate() ?? false;
    final bool isTurfValid = _selectedTurf != null;

    setState(() {
      _dropdownError = isTurfValid ? null : 'Please select a turf.';
      _successMessage = null;
    });

    if (!isFormValid || !isTurfValid) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    final String confirmation =
        'Booking created for ${_teamNameController.text.trim()} at $_selectedTurf (${_timeController.text.trim()})';

    setState(() {
      _isSubmitting = false;
      _successMessage = confirmation;
      _teamNameController.clear();
      _timeController.clear();
      _selectedTurf = null;
      _dropdownError = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(confirmation)));
  }

  @override
  Widget build(BuildContext context) {
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
                CustomTextField(
                  controller: _timeController,
                  hintText: 'Preferred Time (e.g. 7:00 PM)',
                  icon: Icons.schedule_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Time is required.';
                    }
                    return null;
                  },
                ),
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
