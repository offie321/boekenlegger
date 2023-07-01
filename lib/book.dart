import 'package:firebase_auth/firebase_auth.dart';

class Book {
  final String title;
  final int pageCount;
  final String imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String userId;

  Book({required this.title, required this.pageCount, required this.imageUrl, required this.userId});

  String? getCurrentUserUid() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String uid = user.uid;
      return uid;
    }
    return null;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      title: map['title'] as String,
      pageCount: map['pageCount'] as int,
      imageUrl: map['imageUrl'] as String,
      userId: map['userId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'pageCount': pageCount,
      'imageUrl': imageUrl,
      'userId': getCurrentUserUid(),
    };
  }


}