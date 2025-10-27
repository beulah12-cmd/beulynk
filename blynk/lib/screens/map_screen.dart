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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFE94560)),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition,
                    zoom: 10,
                  ),
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  myLocationButtonEnabled: false,
                  mapType: MapType.normal,
                ),
                // Refresh button
                Positioned(
                  top: 50.h,
                  right: 16.w,
                  child: FloatingActionButton(
                    onPressed: _loadApprovedPosts,
                    backgroundColor: const Color(0xFFE94560),
                    child: const Icon(Icons.refresh),
                  ),
                ),
                // Info banner
                if (_posts.isNotEmpty)
                  Positioned(
                    bottom: 80.h,
                    left: 16.w,
                    right: 16.w,
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16213E).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${_posts.length} approved problems on map',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
