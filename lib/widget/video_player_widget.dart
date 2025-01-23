import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:tiktask/services/video_precache_service.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String? thumbnailUrl;
  final bool zoomable;

  const VideoPlayerWidget({
    required this.videoUrl,
    this.thumbnailUrl,
    this.zoomable = true,
    super.key,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  late ChewieController _chewieController;
  bool _isInitializing = true;
  String _errorMessage = '';
  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final cacheService = VideoCacheService.instance;
      final videoUrl = widget.videoUrl;

      final isCached = await cacheService.isVideoCached(videoUrl);
      final cachedPath = isCached ? await cacheService.getVideo(videoUrl) : null;

      _videoController = cachedPath != null
          ? VideoPlayerController.file(File(cachedPath))
          : VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      await _videoController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: true,
        allowFullScreen: false,
        fullScreenByDefault: false,
        allowMuting: false,
        aspectRatio: _videoController.value.aspectRatio,
        customControls: Container(),
      );

      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    } catch (e) {
      setState(() {
        _isInitializing = false;
        _errorMessage = 'Failed to load video.';
      });
    }
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Text(
          _errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (_isInitializing) {
      return widget.thumbnailUrl != null
          ? Image.network(widget.thumbnailUrl!, fit: BoxFit.cover)
          : const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_videoController.value.isPlaying) {
            _videoController.pause();
          } else {
            _videoController.play();
          }
        });
      },
      onScaleStart: (details) {
        if (widget.zoomable) {
          _baseScaleFactor = _scaleFactor;
        }
      },
      onScaleUpdate: (details) {
        if (widget.zoomable) {
          setState(() {
            _scaleFactor = _baseScaleFactor * details.scale;
          });
        }
      },
      child: Transform.scale(
        scale: _scaleFactor,
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoController.value.size.width,
              height: _videoController.value.size.height,
              child: Chewie(controller: _chewieController),
            ),
          ),
        ),
      ),
    );
  }
}
