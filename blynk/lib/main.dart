import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844), // iPhone 12 Pro reference
      minTextAdapt: true,
      builder: (context, child) => const BlynkApp(),
    ),
  );
}

class BlynkApp extends StatelessWidget {
  const BlynkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BEULYNK - Unity through connection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE94560),
          brightness: Brightness.dark,
        ),
        // Enhanced HD Theme with Premium Colors
        scaffoldBackgroundColor: const Color(0xFF0F0F23),
        primaryColor: const Color(0xFFE94560),
        primaryColorDark: const Color(0xFFD63384),
        canvasColor: const Color(0xFF1A1A2E),
        cardColor: const Color(0xFF16213E).withOpacity(0.8),
        dividerColor: Colors.white.withOpacity(0.1),
        // Enhanced shadows and elevation
        shadowColor: Colors.black.withOpacity(0.3),
        splashColor: const Color(0xFFE94560).withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.05),
        // Enhanced button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE94560),
            foregroundColor: Colors.white,
            elevation: 8,
            shadowColor: const Color(0xFFE94560).withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        // Enhanced input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xFFE94560), width: 2),
          ),
          labelStyle: GoogleFonts.inter(color: Colors.white70, fontSize: 16),
          hintStyle: GoogleFonts.inter(color: Colors.white60, fontSize: 14),
        ),
        // Enhanced HD Typography with Premium Styling
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme)
            .copyWith(
              displayLarge: GoogleFonts.manrope(
                fontSize: 108,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1.5,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              displayMedium: GoogleFonts.manrope(
                fontSize: 72,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1.0,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              displaySmall: GoogleFonts.manrope(
                fontSize: 56,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.8,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              headlineLarge: GoogleFonts.manrope(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.8,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              headlineMedium: GoogleFonts.manrope(
                fontSize: 40,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.6,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              headlineSmall: GoogleFonts.manrope(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.5,
                height: 1.0,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              titleLarge: GoogleFonts.manrope(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.5,
                height: 1.2,
              ),
              titleMedium: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.3,
                height: 1.2,
              ),
              titleSmall: GoogleFonts.manrope(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.3,
                height: 1.2,
              ),
              bodyLarge: GoogleFonts.inter(
                fontSize: 18,
                color: Colors.white.withOpacity(0.9),
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
              bodyMedium: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
              bodySmall: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
              labelLarge: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.4,
                letterSpacing: 0.2,
              ),
              labelMedium: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.4,
                letterSpacing: 0.2,
              ),
              labelSmall: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.4,
                letterSpacing: 0.2,
              ),
            ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
