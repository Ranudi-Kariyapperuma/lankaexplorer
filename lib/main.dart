import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'welcome_screen.dart'; // Ensure this file exists and is correctly implemented
import 'signin_screen.dart'; // Ensure this file exists and is correctly implemented
import 'signup_screen.dart'; // Ensure this file exists and is correctly implemented
import 'home_screen.dart'; // Import the HomeScreen

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter bindings are initialized
  await Firebase.initializeApp(); // Initialize Firebase (Ensure configuration files are in place)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanka Explorer',
      debugShowCheckedModeBanner: false, // Turn off debug banner
      theme: ThemeData(
        primarySwatch: Colors.cyan, // Theme color
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.black, // Dark theme background
        brightness: Brightness.dark, // Set overall theme brightness to dark
      ),
      initialRoute: '/', // Initial screen route
      routes: {
        '/': (context) => WelcomeScreen(), // Main welcome screen
        '/signin': (context) => SignInScreen(), // Sign-in screen
        '/signup': (context) => SignUpScreen(), // Sign-up screen
        '/home': (context) => HomeScreen(), // Home screen
      },
    );
  }
}
