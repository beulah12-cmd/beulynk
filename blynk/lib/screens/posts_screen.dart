import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/api_service.dart';
import 'location_picker_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<dynamic> _posts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() => _isLoading = true);
    try {
      final posts = await ApiService.getAllPosts();
      setState(() {
        _posts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Problem Posts',
          style: GoogleFonts.manrope(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadPosts,
            color: Colors.white,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFE94560)),
            )
          : _posts.isEmpty
          ? Center(
              child: Text(
                'No posts yet.\nBe the first to report a problem!',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: Colors.white70,
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: _loadPosts,
              color: const Color(0xFFE94560),
              child: ListView.builder(
                padding: EdgeInsets.all(16.w),
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return _buildPostCard(_posts[index]);
                },
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreatePostDialog,
        backgroundColor: const Color(0xFFE94560),
        icon: const Icon(Icons.add),
        label: Text(
          'Report Problem',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    final isConfirmed = post['is_confirmed'] ?? false;
    final photoUrl = post['photo']?.toString();
    final user = post['user'] as Map<String, dynamic>?;
    final username = user?['username'] ?? 'Unknown';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo
          if (photoUrl != null && photoUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              child: Image.network(
                photoUrl,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200.h,
                  color: Colors.grey[800],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            ),

          // Content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        post['title'] ?? 'No title',
                        style: GoogleFonts.manrope(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: isConfirmed ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        isConfirmed ? 'Approved' : 'Pending',
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Description
                Text(
                  post['description'] ?? '',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white70,
                  ),
                ),

                SizedBox(height: 12.h),

                // Posted by and date
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 16.sp,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      username,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    if (post['created_at'] != null)
                      Text(
                        _formatDate(post['created_at']),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          return '${difference.inMinutes}m ago';
        }
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString;
    }
  }

  void _showCreatePostDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    File? selectedImage;
    LatLng? selectedLocation;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF16213E),
          title: Text(
            'Report a Problem',
            style: GoogleFonts.manrope(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.h),
                TextField(
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.white),
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12.h),
                
                // Location selection
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: selectedLocation != null
                        ? const Color(0xFF0F3460).withOpacity(0.5)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: selectedLocation != null
                          ? const Color(0xFFE94560)
                          : Colors.white.withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedLocation != null) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: const Color(0xFFE94560),
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Text(
                                'Lat: ${selectedLocation!.latitude.toStringAsFixed(4)}\nLng: ${selectedLocation!.longitude.toStringAsFixed(4)}',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                      ],
                      ElevatedButton.icon(
                        onPressed: () async {
                          // Close dialog temporarily
                          Navigator.pop(context);
                          
                          // Open location picker
                          final LatLng? location = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationPickerScreen(
                                initialLocation: selectedLocation,
                              ),
                            ),
                          );
                          
                          // Reopen dialog with updated location
                          if (location != null) {
                            selectedLocation = location;
                          }
                          
                          // Reopen the create post dialog
                          _showCreatePostDialog();
                          titleController.text = titleController.text;
                          descriptionController.text = descriptionController.text;
                        },
                        icon: Icon(
                          selectedLocation != null
                              ? Icons.edit_location
                              : Icons.add_location,
                          size: 18.sp,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE94560),
                          minimumSize: Size(double.infinity, 40.h),
                        ),
                        label: Text(
                          selectedLocation != null
                              ? 'Change Location'
                              : 'Select Location on Map',
                          style: GoogleFonts.inter(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                
                // Photo selection
                if (selectedImage != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(selectedImage!, height: 150.h),
                  ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      setDialogState(() => selectedImage = File(image.path));
                    }
                  },
                  icon: const Icon(Icons.photo),
                  label: Text(
                    selectedImage == null ? 'Add Photo' : 'Change Photo',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Validation
                if (titleController.text.isEmpty ||
                    descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill title and description')),
                  );
                  return;
                }
                
                if (selectedLocation == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select location on map'),
                      backgroundColor: Colors.orange,
                    ),
                  );
                  return;
                }

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Submitting post...')),
                );

                final result = await ApiService.createPost(
                  title: titleController.text,
                  description: descriptionController.text,
                  latitude: selectedLocation!.latitude,
                  longitude: selectedLocation!.longitude,
                  photoPath: selectedImage?.path,
                );

                if (result['id'] != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post submitted! Pending approval.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  _loadPosts();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error: ${result['message'] ?? 'Failed to submit'}',
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE94560),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.inter(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
