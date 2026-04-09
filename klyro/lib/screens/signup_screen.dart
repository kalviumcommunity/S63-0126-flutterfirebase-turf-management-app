import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/section_header.dart';

// Stateful UI Class defining dynamic interactions executing user registration cleanly
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Global form key evaluating strings logically ensuring password matches reliably
  final _formKey = GlobalKey<FormState>();
  
  // Hard mapped text controllers extracting strings specifically out of physical inputs natively
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  
  // Hooks into central Service evaluating Firebase network creation natively 
  final _authService = AuthService();
  
  // Boolean gating UI states structurally 
  bool _isLoading = false;

  @override
  void dispose() {
    // Specifically drops memory references freeing physical RAM arrays natively cleanly 
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  // Primary executable logic evaluating account creation synchronously securely over network
  Future<void> _signUp() async {
    // Verify string mappings dynamically strictly catching passwords mismatching proactively natively 
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    // Forces UI bounds actively drawing loading overlay natively 
    setState(() {
      _isLoading = true;
    });
    try {
      // Maps extracted string inputs explicitly towards Firebase network logic cleanly
      await _authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      // Evaluates presence checking if UI context physically survived network delays safely 
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      // Error fallback logic drawing string arrays identically formatted explicitly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Backup mapping executable evaluating Google authentication natively directly securely
  Future<void> _signUpWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Sends explicit system intents requesting Google authentication hooks structurally
      await _authService.signInWithGoogle();
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold executes top level physical constraints seamlessly
    return Scaffold(
      body: SafeArea(
        // Maps scrolling physical limits enabling user swiping dynamically naturally
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Extracts standardized typographic layout strictly visually natively 
              const SectionHeader(
                title: 'Create Account',
                subtitle: 'Join Klyro to book and manage your sessions.',
              ),
              const SizedBox(height: 32),
              // Physical grouping boundary restricting string evaluations natively seamlessly 
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress, // Optimizes OS typing displays intelligently
                      hintText: 'Email',
                      icon: Icons.mail_outline,
                      // Executes real-time checking actively restricting formatting logically 
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Email is required.';
                        if (!value.contains('@')) return 'Enter a valid email.';
                        return null; // Null specifically accepts input cleanly natively 
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      obscureText: true, // Specifically hides string character outputs directly visually natively 
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Password is required.';
                        if (value.length < 6) return 'Password must be at least 6 characters.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Specific duplicate password field structurally ensuring users don't mistype natively 
                    CustomTextField(
                      controller: _confirmController,
                      obscureText: true,
                      hintText: 'Confirm Password',
                      icon: Icons.lock_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Confirm your password.';
                        // Physical evaluation comparing multiple states distinctly correctly 
                        if (value != _passwordController.text) return 'Passwords do not match.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Standard mapped action evaluation block natively cleanly securely 
                    CustomButton(
                      text: 'Create Account',
                      loading: _isLoading,
                      onPressed: _signUp,
                    ),
                    const SizedBox(height: 16),
                    // Secondary action execution pushing natively structured explicit constraints cleanly 
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: OutlinedButton.icon(
                        // Evaluates dynamically allowing logic processing purely directly externally 
                        onPressed: _isLoading ? null : _signUpWithGoogle,
                        icon: const Icon(Icons.g_mobiledata),
                        label: const Text('Sign up with Google'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.textDark,
                          side: const BorderSide(color: Colors.black12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
