import 'package:firebase_storage/firebase_storage.dart';

class FirebaseVideoRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Fetches the list of video URLs from Firebase Storage
  Future<List<String>> fetchVideoUrls(String folderPath) async {
    final ListResult result = await _storage.ref(folderPath).listAll();
    final List<Reference> allFiles = result.items;

    // Retrieve download URLs for each file
    List<String> urls = [];
    for (var file in allFiles) {
      final String url = await file.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
}
