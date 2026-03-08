import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewerData {
  final String imageUrl;
  final String? title;
  final String? authorName;
  final String heroTag;

  ImageViewerData({
    required this.imageUrl,
    this.title,
    this.authorName,
    required this.heroTag,
  });
}

class FullScreenImageViewer extends StatefulWidget {
  final ImageViewerData data;

  const FullScreenImageViewer({super.key, required this.data});

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Photo View Gallery with Hero Animation
          Hero(
            tag: widget.data.heroTag,
            createRectTween: (begin, end) {
              return MaterialRectCenterArcTween(begin: begin, end: end);
            },
            child: PhotoViewGallery(
              pageController: _pageController,
              onPageChanged: (index) {
                setState(() {});
              },
              pageOptions: [
                PhotoViewGalleryPageOptions(
                  imageProvider: CachedNetworkImageProvider(
                    widget.data.imageUrl,
                  ),
                  initialScale: PhotoViewComputedScale.contained * 1.0,
                  minScale: PhotoViewComputedScale.contained * 0.8,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
                ),
              ],
            ),
          ),

          /// Top Bar with Close Button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    if (widget.data.title != null)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.data.authorName != null)
                              Text(
                                widget.data.authorName!,
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            Text(
                              widget.data.title!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Bottom Help Text
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'Double tap to zoom • Pinch to zoom • Swipe to dismiss',
                  style: GoogleFonts.manrope(
                    fontSize: 11,
                    color: Colors.white54,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
