import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/api_service.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/hero_section_widget.dart';
import '../widgets/custom_footer.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  bool _isLoading = false;
  String _connectionStatus = 'Unknown';
  String _statusMessage = 'Click "Test Connection" to verify API connectivity';
  Map<String, dynamic>? _testResults;

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _connectionStatus = 'Testing...';
      _statusMessage = 'Connecting to backend...';
    });

    try {
      // Test 1: NGO Info endpoint
      final ngoInfo = await ApiService.getNGOInfo();
      
      if (ngoInfo != null) {
        setState(() {
          _connectionStatus = 'Success';
          _statusMessage = '✅ Connected to BEULYNK Backend Successfully!';
          _testResults = {
            'ngo_info': {
              'name': ngoInfo.name,
              'full_name': ngoInfo.fullName,
              'tagline': ngoInfo.tagline,
              'lives_impacted': ngoInfo.livesImpacted,
              'active_donors': ngoInfo.activeDonors,
              'communities_served': ngoInfo.communitiesServed,
            },
            'endpoints_tested': [
              '/api/ngo-info/',
            ],
          };
        });
      } else {
        setState(() {
          _connectionStatus = 'Failed';
          _statusMessage = '❌ Could not fetch NGO information';
        });
      }
    } catch (e) {
      setState(() {
        _connectionStatus = 'Error';
        _statusMessage = '❌ Connection failed: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeroSectionWidget(
                title: 'API Connection Test',
                subtitle: 'Verify backend connectivity',
                icon: Icons.wifi_protected_setup,
                minHeight: 280.h,
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),

                    // Status Card
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: _connectionStatus == 'Success'
                            ? Colors.green.withOpacity(0.1)
                            : _connectionStatus == 'Failed'
                                ? Colors.red.withOpacity(0.1)
                                : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: _connectionStatus == 'Success'
                              ? Colors.green
                              : _connectionStatus == 'Failed'
                                  ? Colors.red
                                  : Colors.blue,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            _connectionStatus == 'Success'
                                ? Icons.check_circle
                                : _connectionStatus == 'Failed'
                                    ? Icons.error
                                    : Icons.info_outline,
                            size: 48.w,
                            color: _connectionStatus == 'Success'
                                ? Colors.green
                                : _connectionStatus == 'Failed'
                                    ? Colors.red
                                    : Colors.blue,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            _statusMessage,
                            style: GoogleFonts.manrope(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ).animate().fadeIn().scale(),

                    SizedBox(height: 24.h),

                    // Test Button
                    PrimaryButton(
                      text: 'Test Connection',
                      onPressed: _isLoading ? () {} : _testConnection,
                      isLoading: _isLoading,
                      icon: Icons.refresh,
                      width: double.infinity,
                    ),

                    SizedBox(height: 32.h),

                    // API Info
                    Container(
                      constraints: BoxConstraints(maxWidth: 600.w),
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Backend URL',
                            style: GoogleFonts.manrope(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFE94560),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'https://beulynk-backend.onrender.com',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (_testResults != null) ...[
                      SizedBox(height: 24.h),

                      // Test Results
                      Container(
                        constraints: BoxConstraints(maxWidth: 600.w),
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Test Results',
                              style: GoogleFonts.manrope(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              'NGO Information Retrieved:',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            if (_testResults!['ngo_info'] != null)
                              ..._testResults!['ngo_info'].entries.map(
                                (entry) => Padding(
                                  padding: EdgeInsets.only(bottom: 6.h),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 16.w,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          '${entry.key}: ${entry.value}',
                                          style: GoogleFonts.inter(
                                            fontSize: 13.sp,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ).animate().fadeIn().slideY(),
                    ],

                    SizedBox(height: 40.h),

                    const CustomFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

