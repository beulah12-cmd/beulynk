import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'beulynk_logo.dart';
import '../screens/landing_page.dart';
import '../screens/about_page.dart';
import '../screens/how_it_works_page.dart';
import '../screens/contact_page.dart';

/// Modern, reusable footer widget for BEULYNK app
/// Designed to be consistent, minimal, and responsive across all screens
class CustomFooter extends StatelessWidget {
  const CustomFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F1E).withOpacity(0.95),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo and Brand Name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const BeulynkLogo.icon(size: 28, heartColor: Colors.white),
              SizedBox(width: 10.w),
              Text(
                'BEULYNK',
                style: GoogleFonts.manrope(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Tagline
          Text(
            'Unity through connection',
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              color: Colors.white60,
              height: 1.4,
            ),
          ),

          SizedBox(height: 20.h),

          // Quick Links
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16.w,
            runSpacing: 8.h,
            children: [
              _buildFooterLink(
                context,
                'Home',
                () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                ),
              ),
              _buildDivider(),
              _buildFooterLink(
                context,
                'About',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                ),
              ),
              _buildDivider(),
              _buildFooterLink(
                context,
                'How It Works',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HowItWorksPage()),
                ),
              ),
              _buildDivider(),
              _buildFooterLink(
                context,
                'Contact',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          // Social Media Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(FontAwesomeIcons.facebook, () {}),
              SizedBox(width: 16.w),
              _buildSocialIcon(FontAwesomeIcons.xTwitter, () {}),
              SizedBox(width: 16.w),
              _buildSocialIcon(FontAwesomeIcons.instagram, () {}),
              SizedBox(width: 16.w),
              _buildSocialIcon(FontAwesomeIcons.linkedin, () {}),
            ],
          ),

          SizedBox(height: 20.h),

          // Divider
          Container(
            width: 200.w,
            height: 1,
            color: Colors.white.withOpacity(0.1),
          ),

          SizedBox(height: 16.h),

          // Organization Name
          Text(
            'Beulah Humanity Reconciliation',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.5),
              letterSpacing: 0.3,
            ),
          ),

          SizedBox(height: 8.h),

          // Copyright
          Text(
            '© 2025 BEULYNK. All rights reserved.',
            style: GoogleFonts.inter(
              fontSize: 11.sp,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(BuildContext context, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 13.sp,
            color: Colors.white70,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 12.h,
      color: Colors.white.withOpacity(0.2),
    );
  }

  Widget _buildSocialIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: FaIcon(
          icon,
          size: 16.w,
          color: Colors.white60,
        ),
      ),
    );
  }
}

