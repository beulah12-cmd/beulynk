import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/beulynk_logo.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to landing page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LandingPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A2347), // Dark navy blue background from image
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 48.w, vertical: 80.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                
                // Responsive white heart icon - perfectly centered
                SizedBox(
                  height: 180.h,
                  width: 180.w,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: BeulynkLogo(heartColor: Colors.white),
                  ),
                ),

                SizedBox(height: 32.h),

                // BEULYNK Text - perfectly centered
                Text(
                  'BEULYNK',
                  style: GoogleFonts.manrope(
                    fontSize: 42.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
