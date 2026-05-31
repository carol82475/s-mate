import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../core/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLogin = true;
  bool _obscurePassword = true;
  bool _isLoading = false;
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isLoading = true);
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isLogin ? 'Welcome back!' : 'Account created successfully!'),
        backgroundColor: AppTheme.success,
      ),
    );
    context.go('/home');
  }

  void _forgotPassword() {
    final emailCtrl = TextEditingController(text: _emailCtrl.text);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.cardBg,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 24, right: 24, top: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Reset Password', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Enter your email and we\'ll send you a reset link.', style: TextStyle(color: AppTheme.textMuted)),
            const SizedBox(height: 20),
            TextField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                hintText: 'you@example.com',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password reset link sent! Check your email.'),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Send Reset Link'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton.icon(
                  onPressed: () => context.go('/'),
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: const Text('Back'),
                  style: TextButton.styleFrom(foregroundColor: AppTheme.textMuted),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBg,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      )
                    ],
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isLogin ? 'Welcome Back' : 'Create Account',
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textPrimary),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _isLogin ? 'Sign in to continue your journey' : 'Sign up to start planning your next adventure',
                          style: const TextStyle(color: AppTheme.textMuted),
                        ),
                        const SizedBox(height: 32),

                        if (!_isLogin) ...[
                          // Full Name
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person_outline),
                              hintText: 'John Doe',
                            ),
                            validator: (v) => Validators.required(v, 'your name'),
                          ),
                          const SizedBox(height: 16),
                          // Location
                          TextFormField(
                            controller: _locationCtrl,
                            decoration: const InputDecoration(
                              labelText: 'Location',
                              prefixIcon: Icon(Icons.location_on_outlined),
                              hintText: 'San Francisco, USA',
                            ),
                            validator: (v) => Validators.required(v, 'your location'),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Email
                        TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'you@example.com',
                          ),
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 16),
                        // Password
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: '••••••••',
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          validator: Validators.password,
                        ),
                        if (_isLogin) ...[
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: _forgotPassword,
                              child: const Text('Forgot password?', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _isLoading ? null : _submit,
                            icon: _isLoading
                                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : Icon(_isLogin ? Icons.login : Icons.person_add_outlined),
                            label: Text(_isLogin ? 'Login' : 'Sign Up'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(children: [
                          const Expanded(child: Divider()),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('or', style: TextStyle(color: AppTheme.textMuted))),
                          const Expanded(child: Divider()),
                        ]),
                        const SizedBox(height: 24),
                        // Google button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: _isLoading ? null : () => context.go('/home'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(color: AppTheme.border),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://developers.google.com/identity/images/g-logo.png',
                                  height: 20,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'G',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text('Continue with Google', style: TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: TextButton(
                            onPressed: () => setState(() => _isLogin = !_isLogin),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(color: AppTheme.textMuted),
                                children: [
                                  TextSpan(text: _isLogin ? "Don't have an account? " : "Already have an account? "),
                                  TextSpan(
                                    text: _isLogin ? 'Sign up' : 'Login',
                                    style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
