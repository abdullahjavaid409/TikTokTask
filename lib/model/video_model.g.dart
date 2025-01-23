// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      id: json['id'] as String,
      uploaderId: json['uploaderId'] as String?,
      videoUrl: json['videoUrl'] as String?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      hashtags: (json['hashtags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      zoomable: json['zoomable'] as bool? ?? false,
      cached: json['cached'] as bool? ?? false,
      duration: (json['duration'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'id': instance.id,
      'uploaderId': instance.uploaderId,
      'videoUrl': instance.videoUrl,
      'thumbnailUrl': instance.thumbnailUrl,
      'title': instance.title,
      'description': instance.description,
      'hashtags': instance.hashtags,
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'duration': instance.duration,
      'zoomable': instance.zoomable,
      'cached': instance.cached,
    };
