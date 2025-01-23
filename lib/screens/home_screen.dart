import 'package:flutter/material.dart';
import 'package:tiktask/locator.dart';
import 'package:tiktask/widget/video_player_widget.dart';
import 'package:tiktask/repository/firebase_repository.dart';
import 'package:tiktask/model/video_model.dart';
import 'package:tiktask/services/connectivity_service.dart';
import 'package:tiktask/services/video_precache_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VideoCacheService _cacheService = VideoCacheService.instance;
  List<Video> _videos = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      if (await ConnectivityService.instance.isOffline) {
        throw Exception('No network connection. Please check your internet.');
      }

      final data = await videoRepository.getAll() ?? [];

      if (data.isEmpty) {
        throw Exception('No videos available.');
      }

      _cacheService.preloadVideos(data.map((e) => e.videoUrl ?? '').toList());

      setState(() {
        _videos = data;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchVideos,
              child: const Text('Retry'),
            ),
          ],
        ),
      )
          : PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          final video = _videos[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              VideoPlayerWidget(
                videoUrl: video.videoUrl ?? '',
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  video.title ?? 'Untitled',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
