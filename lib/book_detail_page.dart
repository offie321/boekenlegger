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
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    currentPage = widget.book.currentPageCount;
  }

  Future<String?> getBookDocumentId(String bookTitle) async {
    final CollectionReference booksCollection = FirebaseFirestore.instance.collection('books');

    try {
      final QuerySnapshot snapshot = await booksCollection.where('title', isEqualTo: bookTitle).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.id;
      }
    } catch (e) {
      print('Failed to retrieve book document ID: $e');
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
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
      body: Column(
        children: [
          Expanded(
            child: Hero(
              tag: widget.book.imageUrl,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.book.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 75, 16 , 75),
            child: Column(
              children: [
                Text(
                  'Page: $currentPage / ${widget.book.pageCount}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (currentPage == widget.book.pageCount)
                      ? null
                      : () async {
                    String? documentId = await getBookDocumentId(widget.book.title);
                    if (documentId != null) {
                      int newCurrentPageCount = currentPage + 1;
                      await widget.book.updateCurrentPageCount(documentId, newCurrentPageCount);
                      setState(() {
                        currentPage = newCurrentPageCount;
                      });
                    } else {
                      print('Book document not found!');
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      (currentPage == widget.book.pageCount) ? Colors.grey : Colors.orangeAccent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: currentPage > 0 ? () async {
                    String? documentId = await getBookDocumentId(widget.book.title);
                    if (documentId != null) {
                      int newCurrentPageCount = currentPage - 1;
                      await widget.book.updateCurrentPageCount(documentId, newCurrentPageCount);
                      setState(() {
                        currentPage = newCurrentPageCount;
                      });
                    } else {
                      print('Book document not found!');
                    }
                  } : null,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '-',
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      } else {
                        return Colors.orangeAccent;
                      }
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                ],
            ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
