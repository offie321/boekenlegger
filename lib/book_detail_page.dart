import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;
  final String bookId;
  final Function(String) deleteBook;

  BookDetailPage({required this.book, required this.bookId, required this.deleteBook});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteBook(bookId);
              Navigator.pop(context);
            },
          ),
        ],
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
