import 'package:flutter/material.dart';
import 'book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;



class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pageCountController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            TextButton(
              onPressed: () {
                _selectImage();
              },
              child: selectedImage != null
                  ? Container(
                  width: 200,
                  height: 200,
                  child: Image.file(selectedImage!),
              )
                  : Text('Select Image'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _addBook();
              },
              child: Text('Add Book'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.orangeAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addBook() async {
    final String title = titleController.text;
    final int pageCount = int.tryParse(pageCountController.text) ?? 0;


    if (title.isEmpty || pageCount <= 0 || selectedImage == null) {
      return;
    }

    try {

      final String imageUrl = await _uploadImage();


      final CollectionReference booksCollection =
      FirebaseFirestore.instance.collection('books');
      final newBook = Book(title: title, pageCount: pageCount, imageUrl: imageUrl, userId: '', currentPageCount: 0,);
      await booksCollection.add(newBook.toMap());


      Navigator.pop(context);
    } catch (e) {
      print('Failed to add book: $e');
    }
  }

  Future<String> _uploadImage() async {

    final firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance.ref();


    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final firebase_storage.UploadTask uploadTask =
    storageRef.child('images/$fileName').putFile(selectedImage!);


    final firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);


    if (taskSnapshot.state == firebase_storage.TaskState.success) {

      final String imageUrl = await taskSnapshot.ref.getDownloadURL();


      return imageUrl;
    } else {
      throw Exception('Image upload failed');
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }
}