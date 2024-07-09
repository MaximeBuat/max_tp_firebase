import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String description;

  Post({required this.id, required this.title, required this.description});

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
    };
  }
}
