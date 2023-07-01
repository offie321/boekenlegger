import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailPage extends StatefulWidget {
  final Book book;
  final String bookId;
  final Function(String) deleteBook;

  BookDetailPage({required this.book, required this.bookId, required this.deleteBook});

  @override
  _BookDetailPageState createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int currentPage = 0; // Track the current page count

  @override
  void initState() {
    super.initState();
    currentPage = widget.book.currentPageCount; // Initialize with the current page count from the book object
  }

  Future<String?> getBookDocumentId(String bookTitle) async {
    final CollectionReference booksCollection =
    FirebaseFirestore.instance.collection('books');

    try {
      final QuerySnapshot snapshot =
      await booksCollection.where('title', isEqualTo: bookTitle).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id; // Return the document ID of the first matching document
      }
    } catch (e) {
      print('Failed to retrieve book document ID: $e');
    }

    return null; // Return null if the book document was not found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.deleteBook(widget.bookId);
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
              widget.book.imageUrl,
              width: 150,
              height: 150,
            ),
            SizedBox(height: 16),
            Text('Page: $currentPage / ${widget.book.pageCount}'), // Show current page and max pages
            ElevatedButton(
              onPressed: () async {
                String? documentId = await getBookDocumentId(widget.book.title);
                if (documentId != null) {
                  int newCurrentPageCount = currentPage + 1; // Increment the current page count
                  await widget.book.updateCurrentPageCount(documentId, newCurrentPageCount);
                  setState(() {
                    currentPage = newCurrentPageCount; // Update the current page count locally
                  });
                } else {
                  print('Book document not found!');
                }
              },
              child: Text('Increment Page'),
            ),
            ElevatedButton(
              onPressed: () async {
                String? documentId = await getBookDocumentId(widget.book.title);
                if (documentId != null) {
                  int newCurrentPageCount = currentPage - 1; // Decrement the current page count
                  if (newCurrentPageCount >= 0) {
                    await widget.book.updateCurrentPageCount(documentId, newCurrentPageCount);
                    setState(() {
                      currentPage = newCurrentPageCount; // Update the current page count locally
                    });
                  } else {
                    print('Invalid page count!');
                  }
                } else {
                  print('Book document not found!');
                }
              },
              child: Text('Decrement Page'),
            ),
          ],
        ),
      ),
    );
  }
}
