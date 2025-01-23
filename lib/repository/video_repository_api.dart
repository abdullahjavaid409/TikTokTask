
import 'package:tiktask/model/video_model.dart';

abstract class IVideoRepository {
  Future<Video?> get(String documentId);
  Future<List<Video>?> getAll();
  Future<void> add(Video user);
  Future<void> update(String documentId, Map<String, dynamic> map);
  Future<void> delete(String documentId);
}
