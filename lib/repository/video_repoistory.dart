
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktask/model/video_model.dart';
import 'package:tiktask/repository/video_repository_api.dart';

class VideoApi implements IVideoRepository {
  final user = FirebaseFirestore.instance;
  final CollectionReference<Video> modelsRef = FirebaseFirestore
      .instance
      .collection('video')
      .withConverter<Video>(
    fromFirestore: (snapshot, _) =>
        Video.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

  @override
  Future<Video?> get(String documentId) =>
      modelsRef.doc(documentId).get().then((s) => s.data());

  @override
  Future<List<Video>?> getAll() async {
    final snapshot = await modelsRef.get();
    final docs = snapshot.docs;

    if (docs.isNotEmpty) {
      final List<Video> users = [];
      for (int i = 0; i < docs.length; i++) {
        users.add(docs[i].data());
      }
      return users;
    }
    return null;
  }

  @override
  Future<void> add(Video user) => modelsRef.doc(user.id).set(user);

  @override
  Future<void> update(String documentId, Map<String, dynamic> map) =>
      modelsRef.doc(documentId).update(map);

  @override
  Future<void> delete(String documentId) => modelsRef.doc(documentId).delete();
}
