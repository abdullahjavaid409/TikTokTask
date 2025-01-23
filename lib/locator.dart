
import 'package:get_it/get_it.dart';
import 'package:tiktask/repository/video_repoistory.dart';
import 'package:tiktask/repository/video_repository_api.dart';

final _locator = GetIt.instance;

IVideoRepository get videoRepository =>
    _locator<IVideoRepository>();

abstract class DependencyInjectionEnvironment {
  static Future<void> setup() async {
    _locator
        .registerLazySingleton<IVideoRepository>(() => VideoApi());

  }
}
