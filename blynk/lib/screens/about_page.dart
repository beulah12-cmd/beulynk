import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/beulynk_layout.dart';
import '../widgets/hero_section_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BeulynkLayout(
      title: 'About',
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                HeroSectionWidget(
                  title: 'About BEULYNK',
                  subtitle: 'Unity through connection',
                  icon: Icons.favorite,
                  minHeight: 280.h,
                ),
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),

                      // Mission Section
                      _buildSection(
                        context,
                        icon: Icons.favorite,
                        title: 'Our Mission',
                        description:
                            'BEULYNK is dedicated to fostering unity and connection among communities. Through innovative technology and compassionate outreach, we bridge gaps and create meaningful relationships that transform lives.',
                        delay: 200,
                      ),

                      SizedBox(height: 24.h),

                      // Organization Section
                      _buildSection(
                        context,
                        icon: Icons.people,
                        title: 'Beulah Humanity Reconciliation',
                        description:
                            'We are a non-profit organization committed to humanitarian work, community development, and social reconciliation. Our platform connects volunteers, donors, and communities to create lasting positive impact.',
                        delay: 400,
                      ),

                      SizedBox(height: 24.h),

                      // Values Section
                      _buildSection(
                        context,
                        icon: Icons.stars,
                        title: 'Our Values',
                        description:
                            'Compassion • Unity • Innovation • Transparency • Empowerment\n\nWe believe in the power of human connection to create a better world for all.',
                        delay: 600,
                      ),

                      SizedBox(height: 40.h),

                      // Stats Section
                      Wrap(
                        spacing: 16.w,
                        runSpacing: 16.h,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildStatCard('10K+', 'Members'),
                          _buildStatCard('500+', 'Projects'),
                          _buildStatCard('50+', 'Countries'),
                          _buildStatCard('1M+', 'Lives Impacted'),
                        ],
                      ).animate().fadeIn(delay: 800.ms).scale(),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required int delay,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: 800.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48.w, color: const Color(0xFFE94560)),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              color: Colors.white70,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: -0.1, end: 0);
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE94560).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFE94560).withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.manrope(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE94560),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
