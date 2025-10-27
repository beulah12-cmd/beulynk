import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/api_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  List<dynamic> _posts = [];
  bool _isLoading = true;
  LatLng _initialPosition = const LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _loadApprovedPosts();
  }

  Future<void> _loadApprovedPosts() async {
    setState(() => _isLoading = true);
    try {
      final posts = await ApiService.getApprovedPosts();
      setState(() {
        _posts = posts;
        _markers = _createMarkers(posts);
        if (posts.isNotEmpty) {
          _initialPosition = LatLng(
            posts.first['latitude']?.toDouble() ?? 0,
            posts.first['longitude']?.toDouble() ?? 0,
          );
        } else {
          _initialPosition = const LatLng(
            37.7749,
            -122.4194,
          ); // Default to San Francisco
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Set<Marker> _createMarkers(List<dynamic> posts) {
    final markers = <Marker>{};

    for (int i = 0; i < posts.length; i++) {
      final post = posts[i];
      final lat = post['latitude']?.toDouble();
      final lng = post['longitude']?.toDouble();

      if (lat != null && lng != null) {
        markers.add(
          Marker(
            markerId: MarkerId('post_$i'),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: post['title'] ?? 'Problem',
              snippet: post['description'] ?? '',
            ),
          ),
        );
      }
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Problem Map',
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadApprovedPosts,
            color: Colors.white,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFE94560)),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.map,
                    size: 80.sp,
                    color: Colors.white70,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Map View',
                    style: GoogleFonts.manrope(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Google Maps integration\ncoming soon!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.white70,
                    ),
                  ),
                  if (_posts.isNotEmpty) ...[
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16213E).withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: Text(
                        '${_posts.length} approved problem${_posts.length > 1 ? 's' : ''}',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
