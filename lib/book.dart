import 'package:firebase_auth/firebase_auth.dart';

class Book {
  final String title;
  final int pageCount;
  final String imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Book({required this.title, required this.pageCount, required this.imageUrl});

  String? getCurrentUserUid() {
    final User? user = _auth.currentUser;
    if (user != null) {
      final String uid = user.uid;
      return uid;
    }
    return null;
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