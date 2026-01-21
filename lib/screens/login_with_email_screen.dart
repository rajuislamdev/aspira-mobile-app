import 'package:aspira/core/errors/failure.dart';
import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/core/utils/ui_support.dart';
import 'package:aspira/view_models/auth/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWithEmailScreen extends StatefulWidget {
  const LoginWithEmailScreen({super.key});

  @override
  State<LoginWithEmailScreen> createState() => _LoginWithEmailScreenState();
}

class _LoginWithEmailScreenState extends State<LoginWithEmailScreen> {
  final _emailController = TextEditingController(text: 'raju@gmail.com');
  final _passwordController = TextEditingController(text: '12345678');
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                /// ================= HERO =================
                Expanded(
                  flex: 4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0x661E3B8A), Color(0xFF111214)],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock_outline_rounded,
                            size: 56,
                            color: Colors.white70,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Welcome Back',
                            style: GoogleFonts.manrope(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Log in to continue learning',
                            style: GoogleFonts.manrope(
                              fontSize: 14,
                              color: const Color(0xFFB8B9BD),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// ================= FORM =================
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _InputField(
                            controller: _emailController,
                            label: 'Email Address',
                            hint: 'you@example.com',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 16),

                          _InputField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: '••••••••',
                            obscureText: _obscurePassword,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white54,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot password?',
                              style: GoogleFonts.manrope(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF14B8A6),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          /// Login button
                          Consumer(
                            builder: (context, ref, child) {
                              ref.listen(loginViewModelProvider, (_, next) {
                                next.whenOrNull(
                                  data: (data) {
                                    if (data != null) {
                                      context.go('/${RouteLocationName.feed}');
                                    }
                                  },
                                  error: (error, s) {
                                    final message = error is Failure
                                        ? error.message
                                        : error.toString();
                                    Ui.showErrorSnackBar(
                                      context,
                                      message: message,
                                    );
                                  },
                                );
                              });

                              final notifier = ref.read(
                                loginViewModelProvider.notifier,
                              );
                              final viewModel = ref.watch(
                                loginViewModelProvider,
                              );
                              return viewModel.isLoading
                                  ? const CircularProgressIndicator()
                                  : _PrimaryButton(
                                      label: 'Log In',
                                      background: const Color(0xFF14B8A6),
                                      textColor: const Color(0xFF111214),
                                      onTap: () {
                                        final payload = {
                                          'email': _emailController.text,
                                          'password': _passwordController.text,
                                        };
                                        notifier.login(payload: payload);
                                      },
                                    );
                            },
                          ),

                          const SizedBox(height: 24),

                          /// Divider
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(color: Colors.white12),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  'OR',
                                  style: GoogleFonts.manrope(
                                    fontSize: 12,
                                    color: Colors.white38,
                                  ),
                                ),
                              ),
                              const Expanded(
                                child: Divider(color: Colors.white12),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          /// Social login
                          _SocialButton(
                            label: 'Continue with Google',
                            icon: Icons.g_mobiledata_rounded,
                            onTap: () {},
                          ),

                          const SizedBox(height: 12),

                          _SocialButton(
                            label: 'Continue with Apple',
                            icon: Icons.apple,
                            onTap: () {},
                          ),

                          const SizedBox(height: 28),

                          /// Footer
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account?',
                                style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  color: const Color(0xFFB8B9BD),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Sign Up',
                                style: GoogleFonts.manrope(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF14B8A6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// iOS home indicator
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    width: 120,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
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

/// ================= COMPONENTS =================

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFB8B9BD),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: GoogleFonts.manrope(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.manrope(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF171A29),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final Color background;
  final Color textColor;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.background,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: Icon(icon, size: 22, color: Colors.white),
        label: Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFF171A29),
          side: const BorderSide(color: Colors.white10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }
}
