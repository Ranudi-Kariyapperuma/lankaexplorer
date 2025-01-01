import 'package:flutter/material.dart';
import 'welcome_screen.dart'; 
import 'signin_screen.dart'; 
import 'signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lanka Explorer',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Adding dark theme settings since your app uses dark colors
        scaffoldBackgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/signin': (context) => SignInScreen(), 
        '/signup': (context) => SignUpScreen(),
      },
    );
  }
}
