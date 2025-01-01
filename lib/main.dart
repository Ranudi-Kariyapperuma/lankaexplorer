import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Make sure to import your WelcomeScreen
import 'signin_screen.dart'; // Import the SignInScreen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanka Explorer',
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Adding dark theme settings since your app uses dark colors
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      // Define the routes for navigation
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/signin': (context) => SignInScreen(), // Route for the SignIn screen
        '/signup': (context) => Scaffold(body: Center(child: Text('Sign Up Screen - To be implemented'))),
      },
    );
  }
}
