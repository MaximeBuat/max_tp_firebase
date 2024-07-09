import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:max_tp_firebase/models/post.dart';

abstract class PostRepository {
  Stream<List<Post>> getPostsStream();
  Future<void> addPost(Post post);
  Future<void> updatePost(Post post);
}

class FirestorePostRepository implements PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Post>> getPostsStream() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  @override
  Future<void> addPost(Post post) async {
    await _firestore.collection('posts').add(post.toMap());
  }

  @override
  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update(post.toMap());
  }
}
