import 'package:flutter/material.dart';
import 'welcome_screen.dart';  // Make sure to import your WelcomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanka Explorer',
      debugShowCheckedModeBanner: false,  // Removes the debug banner
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
        // Add these routes when you create the screens
        '/signin': (context) => Scaffold(body: Center(child: Text('Sign In Screen - To be implemented'))),
        '/signup': (context) => Scaffold(body: Center(child: Text('Sign Up Screen - To be implemented'))),
      },
    );
  }
}