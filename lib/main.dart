import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false; // Set the login state based on your logic

    if (isLoggedIn) {
      return MaterialApp(
        title: 'Book Library',
        home: HomePage(),
      );
    } else {
      return MaterialApp(
        title: 'My App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      );
    }
  }
}
