import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Video {
  final String id;
  final String? uploaderId;
  final String? videoUrl;
  final String? thumbnailUrl;
  final String? title;
  final String? description;
  final List<String>? hashtags;
  final int likesCount;
  final int commentsCount;
  final double duration;
  final bool zoomable;
  final bool cached;

  Video({
    required this.id,
    required this.uploaderId,
    this.videoUrl,
    this.thumbnailUrl,
    this.title,
    this.description,
    this.hashtags,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.zoomable = false,
    this.cached = false,
    this.duration = 0.0,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  Map<String, dynamic> toJson() => _$VideoToJson(this);

  factory Video.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Video(
      id: doc.id,
      uploaderId: data['uploaderId'] ?? '',
      videoUrl: data['videoUrl'],
      thumbnailUrl: data['thumbnailUrl'],
      title: data['title'],
      description: data['description'],
      hashtags: data['hashtags'] != null ? List<String>.from(data['hashtags']) : null,
      likesCount: data['likesCount'] ?? 0,
      commentsCount: data['commentsCount'] ?? 0,
      cached: data['cached'] ?? false,
      duration: (data['duration'] ?? 0).toDouble(),
      zoomable: data['zoomable'] ?? true,
    );
  }
}
final List<Video> dummyVideos = [
  Video(
    id: '1',
    uploaderId: 'user123',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    thumbnailUrl: 'https://via.placeholder.com/150?text=Thumbnail+1',
    title: 'Big Buck Bunny',
    description: 'Enjoy the classic animated movie Big Buck Bunny!',
    hashtags: ['#animation', '#classic', '#funny'],
    likesCount: 120,
    commentsCount: 45,
    duration: 596.0,
    zoomable: true,
    cached: true,
  ),
  Video(
    id: '2',
    uploaderId: 'user456',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    thumbnailUrl: 'https://via.placeholder.com/150?text=Thumbnail+2',
    title: 'Elephants Dream',
    description: 'Watch Elephants Dream, a surreal and mesmerizing animation.',
    hashtags: ['#animation', '#dream', '#surreal'],
    likesCount: 200,
    commentsCount: 60,
    duration: 654.0,
    zoomable: true,
    cached: false,
  ),
  Video(
    id: '3',
    uploaderId: 'user789',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    thumbnailUrl: 'https://via.placeholder.com/150?text=Thumbnail+3',
    title: 'Sintel',
    description: 'Experience the emotional journey of Sintel in this short film.',
    hashtags: ['#animation', '#emotional', '#journey'],
    likesCount: 150,
    commentsCount: 35,
    duration: 900.0,
    zoomable: true,
    cached: true,
  ),
  Video(
    id: '4',
    uploaderId: 'user101',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    thumbnailUrl: 'https://via.placeholder.com/150?text=Thumbnail+4',
    title: 'Tears of Steel',
    description: 'Tears of Steel combines sci-fi and drama in this short film.',
    hashtags: ['#sci-fi', '#drama', '#shortfilm'],
    likesCount: 180,
    commentsCount: 50,
    duration: 720.0,
    zoomable: false,
    cached: true,
  ),
  Video(
    id: '5',
    uploaderId: 'user202',
    videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    thumbnailUrl: 'https://via.placeholder.com/150?text=Thumbnail+5',
    title: 'For Bigger Blazes',
    description: 'For Bigger Blazes brings high-action scenes and thrilling visuals.',
    hashtags: ['#action', '#thrilling', '#blazes'],
    likesCount: 300,
    commentsCount: 100,
    duration: 450.0,
    zoomable: true,
    cached: false,
  ),
];
