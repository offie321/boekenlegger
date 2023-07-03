import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Book {
  final String title;
  final int pageCount;
  final String imageUrl;
  int currentPageCount;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String userId;

  Book({required this.title, required this.pageCount, required this.imageUrl, required this.userId, required this.currentPageCount,});

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
      currentPageCount: map['currentPageCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'pageCount': pageCount,
      'imageUrl': imageUrl,
      'userId': getCurrentUserUid(),
      'currentPageCount': currentPageCount,
    };
  }

  Future<void> updateCurrentPageCount(String documentId, int newCurrentPageCount) async {
    final CollectionReference booksCollection =
    FirebaseFirestore.instance.collection('books');

    try {
      await booksCollection.doc(documentId).update({'currentPageCount': newCurrentPageCount});
      currentPageCount = newCurrentPageCount;
    } catch (e) {
      print('Failed to update current page count: $e');
    }
  }


}