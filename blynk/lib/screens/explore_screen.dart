import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/api_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40.h),
            Text(
              'Explore Beulynk',
              style: GoogleFonts.manrope(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 32.h),
            _buildActionCard(
              icon: Icons.handshake,
              title: 'Become a Volunteer',
              subtitle: 'Share your skills and help communities',
              color: const Color(0xFFE94560),
            ),
            SizedBox(height: 16.h),
            _buildActionCard(
              icon: Icons.favorite,
              title: 'Support as Donor',
              subtitle: 'Make a difference with your contribution',
              color: const Color(0xFFE94560),
            ),
            SizedBox(height: 16.h),
            _buildActionCard(
              icon: Icons.support_agent,
              title: 'Request Help',
              subtitle: 'Get the assistance you need',
              color: const Color(0xFFE94560),
            ),
            SizedBox(height: 32.h),
            _buildStatsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 30.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.manrope(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color, size: 20.sp),
        ],
      ),
    ).animate().fadeIn().slideX(duration: 300.ms);
  }

  Widget _buildStatsSection() {
    return FutureBuilder(
      future: ApiService.getNGOInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final ngoInfo = snapshot.data!;

        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: const Color(0xFF16213E).withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Impact So Far',
                style: GoogleFonts.manrope(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              _buildStatRow(
                Icons.people,
                'Lives Impacted',
                ngoInfo.livesImpacted.toString(),
              ),
              SizedBox(height: 12.h),
              _buildStatRow(
                Icons.group,
                'Active Donors',
                ngoInfo.activeDonors.toString(),
              ),
              SizedBox(height: 12.h),
              _buildStatRow(
                Icons.location_city,
                'Communities',
                ngoInfo.communitiesServed.toString(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFE94560), size: 24.sp),
        SizedBox(width: 12.w),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white70),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE94560),
          ),
        ),
      ],
    );
  }
}
