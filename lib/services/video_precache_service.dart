import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoCacheService {
  VideoCacheService._privateConstructor();
  static final VideoCacheService instance = VideoCacheService._privateConstructor();

  final _cacheManager = DefaultCacheManager();

  Future<void> preloadVideos(List<String> urls) async {
    for (final url in urls) {
      try {
        print("Preloading video: $url");
        await _cacheManager.downloadFile(url);
      } catch (e) {
        print("Error preloading video: $e");
      }
    }
  }

  Future<String?> getVideo(String url) async {
    final file = await _cacheManager.getSingleFile(url);
    return file.path;
  }

  Future<bool> isVideoCached(String url) async {
    final file = await _cacheManager.getFileFromCache(url);
    return file != null;
  }
  Future<void> cacheVideo(String url) async {
    try {
      await _cacheManager.downloadFile(url);
      print("Video cached: $url");
    } catch (e) {
      print("Error caching video: $e");
    }
  }

}