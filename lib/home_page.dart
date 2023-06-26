import 'package:flutter/material.dart';
import 'book.dart';
import 'book_detail_page.dart';

class HomePage extends StatelessWidget {
  final List<Book> books = [
    Book(
      title: 'Book 1',
      pageCount: 200,
      imageUrl: 'book1.jpg',
    ),
    Book(
      title: 'Book 2',
      pageCount: 150,
      imageUrl: 'book2.jpg',
    ),
    // Add more books...
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Library'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetailPage(book: books[index]),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: Image.network(
                  books[index].imageUrl,
                  width: 50,
                  height: 50,
                ),
                title: Text(books[index].title),
                subtitle: Text('${books[index].pageCount} pages'),
              ),
            ),
          );
        },
      ),
    );
  }
}
