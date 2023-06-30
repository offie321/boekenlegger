import 'package:flutter/material.dart';
import 'book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pageCountController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: pageCountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Page Count',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addBook();
              },
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addBook() async {
    final String title = titleController.text;
    final int pageCount = int.tryParse(pageCountController.text) ?? 0;
    final String imageUrl = imageUrlController.text;

    // Validate book data
    if (title.isEmpty || pageCount <= 0 || imageUrl.isEmpty) {
      return;
    }

    try {
      // Access the Firestore collection and add the book
      final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');
      final newBook = Book(title: title, pageCount: pageCount, imageUrl: imageUrl);
      await booksCollection.add(newBook.toMap());

      // Book added successfully, navigate back to the home page or perform any desired action
      Navigator.pop(context);
    } catch (e) {
      print('Failed to add book: $e');
    }
  }
}