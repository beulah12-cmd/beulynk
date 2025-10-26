import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Reusable Hero Section Widget for consistent page headers
class HeroSectionWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final double? minHeight;
  final Widget? child;
  final List<Color>? gradientColors;

  const HeroSectionWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.minHeight,
    this.child,
    this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: minHeight ?? 280.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors ??
              [
                const Color(0xFF1A1A2E),
                const Color(0xFF16213E),
                const Color(0xFF0F3460).withOpacity(0.9),
              ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(
                      color: const Color(0xFFE94560).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 48.w,
                    color: const Color(0xFFE94560),
                  ),
                ).animate().fadeIn(duration: 600.ms).scale(),
                SizedBox(height: 24.h),
              ],
              Text(
                title,
                style: GoogleFonts.manrope(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2, end: 0),
              if (subtitle != null) ...[
                SizedBox(height: 16.h),
                Container(
                  constraints: BoxConstraints(maxWidth: 600.w),
                  child: Text(
                    subtitle!,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      color: Colors.white.withOpacity(0.8),
                      height: 1.6,
                      letterSpacing: 0.2,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: 300.ms, duration: 600.ms),
                ),
              ],
              if (child != null) ...[
                SizedBox(height: 24.h),
                child!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

