import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              book.imageUrl,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            Text('Page: ${book.pageCount}'),
          ],
        ),
      ),
    );
  }
}
