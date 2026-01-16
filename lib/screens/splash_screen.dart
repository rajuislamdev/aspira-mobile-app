import 'package:aspira/core/router/route_location_name.dart';
import 'package:aspira/services/local_store_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auto navigate to SignUpScreen after 2 seconds
    Future.delayed(const Duration(seconds: 2), () async {
      final String? token = await LocalStorageService().getToken();
      final bool? isOnBoardingCompleted = await LocalStorageService().getIsOnboardingComplete();
      if (token != null && isOnBoardingCompleted != null && isOnBoardingCompleted) {
        context.pushNamed(RouteLocationName.core);
        return;
      }
      if (token != null) {
        context.pushNamed(RouteLocationName.onboarding);
      } else {
        context.pushNamed(RouteLocationName.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111214),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Gradient background
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0x661E3B8A), Color(0xFF111214)],
                    ),
                  ),
                ),
                // Circular hero illustration
                SizedBox(
                  width: 250,
                  height: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _CircleBorder(size: 240, color: const Color(0xFF14B8A6).withOpacity(0.3)),
                      _CircleBorder(size: 200, color: const Color(0xFF1E3B8A).withOpacity(0.2)),
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF1E3B8A).withOpacity(0.1),
                        ),
                        child: const Icon(
                          Icons.auto_graph_rounded,
                          size: 64,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                // App Name below icon
                Positioned(
                  bottom: 80,
                  child: Text(
                    'Aspira',
                    style: GoogleFonts.manrope(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                // Loading indicator
                Positioned(
                  bottom: 40,
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: const Color(0xFF14B8A6),
                      strokeWidth: 3.5,
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

/// Reuse the same circle border widget from SignUpScreen
class _CircleBorder extends StatelessWidget {
  final double size;
  final Color color;

  const _CircleBorder({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color),
      ),
    );
  }
}
