import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; // Import the Firebase Core package
import 'home_page.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Call the login function
                  await _loginWithEmailAndPassword(
                      emailController.text, passwordController.text);

                  // Login successful, navigate to the home page or update the login state
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } catch (e) {
                  // Handle login errors
                  print('Login Error: $e');
                }
              },
              child: Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await Firebase.initializeApp(); // Initialize Firebase

      // Call Firebase sign in with email and password
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Access the logged-in user
      User? user = userCredential.user;

      // Do something with the user, such as updating the login state or navigating to the home page
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}
