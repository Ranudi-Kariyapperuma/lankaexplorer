import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'welcome_screen.dart'; 
import 'signin_screen.dart'; 
import 'signup_screen.dart'; 
import 'home_screen.dart';
import 'review_and_rating_screen.dart';

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
        '/review_and_rating': (context) => ReviewAndRatingScreen(title: 'Review & Rating ',), // Add route for the review and rating screen
      },
    );
  }
}
