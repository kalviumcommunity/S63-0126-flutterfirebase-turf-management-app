import 'package:flutter/material.dart';
import '../main.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../utils/app_logger.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/section_header.dart';

// Stateful UI Class defining dynamic interactions for standard user authentication internally
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Global form key specifically utilized evaluating strings mapped inside all child fields fully natively
  final _formKey = GlobalKey<FormState>();
  
  // Hard mapped text controllers extracting strings exactly from physical text input logic
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Hooks into the central Service singleton structure performing Firebase network executions
  final _authService = AuthService();
  
  // Dynamic boolean evaluating physical system loading structures allowing UI rendering spinners securely
  bool _isLoading = false;

  @override
  void dispose() {
    // Specifically dumps memory cache loops freeing physical RAM blocks when views naturally destory natively
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Primary executable mapping logic called asynchronously when clicking standard execution buttons natively
  Future<void> _login() async {
    // Form verification natively firing `validator` functions inside strings natively catching bad emails proactively 
    if (!(_formKey.currentState?.validate() ?? false)) {
      return; 
    }

    // Toggles boolean and strictly forces Flutter engine to physically draw loading spinner 
    setState(() {
      _isLoading = true;
    });

    try {
      AppLogger.debug('🔑 Login attempt for: ${_emailController.text.trim()}');
      
      // Forces execution logically mapping extracted string inputs towards backend network natively
      await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      AppLogger.debug('✅ Login successful');

      // Mounted physically checking if user hasn't magically closed App during backend network calculations cleanly 
      if (mounted) {
        // Drops absolutely all previous UI routes cleanly flushing memory returning strictly securely back
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (error) {
      AppLogger.debug('Login failed: $error');
      if (!mounted) return;

      // Physically outputs dynamic red/green string maps directly onto bottom visual displays correctly seamlessly
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      // Regardless if executed dynamically successfully or failed natively cleanly drops execution states 
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Backup executable mapping alternative Google authentication directly
  Future<void> _loginWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      AppLogger.debug('🔑 Google Sign-In attempt');
      // Throws physical network calculations externally towards explicit endpoints
      await _authService.signInWithGoogle();
      AppLogger.debug('✅ Google Sign-In successful');

      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (error) {
      AppLogger.debug('❌ Google Sign-In failed: $error');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString().replaceFirst('Exception: ', ''))),
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
    // Core physical bounds constraint rendering explicit UI safely
    return Scaffold(
      body: SafeArea(
        // Maps physical lists allowing clean dynamic swipe scrolling if keys overlay bottom inputs seamlessly
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Extracts repeating text layouts specifically structurally cleanly 
              const SectionHeader(
                title: 'Welcome Back',
                subtitle: 'Sign in to continue scheduling your games.',
              ),
              const SizedBox(height: 32),
              // Physical grouping object checking validity logic structurally 
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Extracted UI wrapper handling exact email string calculations 
                    CustomTextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress, // Optimizes keyboard dynamically seamlessly
                      hintText: 'Email',
                      icon: Icons.mail_outline,
                      // String checks rendering dynamic layouts proactively
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return 'Email is required.';
                        if (!value.contains('@')) return 'Enter a valid email.';
                        return null; // Null specifies absolutely completely valid parameters
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _passwordController,
                      obscureText: true, // Specifically hides string character outputs directly visually 
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Password is required.';
                        if (value.length < 6) return 'Password must be at least 6 characters.';
                        return null; 
                      },
                    ),
                    const SizedBox(height: 24),
                    // Maps core button structurally checking loading variable natively cleanly
                    CustomButton(
                      text: 'Log In',
                      loading: _isLoading,
                      onPressed: _login,
                    ),
                    const SizedBox(height: 16),
                    // Dynamically executes exact constraints pushing horizontal boundaries locally strictly natively
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      // Maps alternative transparent Google button internally natively cleanly
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : _loginWithGoogle,
                        icon: const Icon(Icons.g_mobiledata),
                        label: const Text('Continue with Google'),
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
              const SizedBox(height: 16),
              // Evaluates alignment mapping strings dynamically specifically correctly natively 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: AppTheme.textSecondary)),
                  TextButton(
                    onPressed: () {
                      // Routing method jumping explicitly between screens actively 
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
