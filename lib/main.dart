import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'booking_screen.dart';
import 'destination_list_screen.dart';
import 'destination_list_screen_city.dart';
import 'destination_list_screen_history.dart';
import 'destination_list_screen_park.dart';
import 'detail_screen.dart';
import 'favorites_list_screen.dart';
import 'itinerary_planner_screen.dart';
import 'public_transport_screen.dart';
import 'ride_sharing_screen.dart';
import 'ticket_booking_screen.dart';
import 'transportation_screen.dart';
import 'travel_tips_screen.dart';
import 'welcome_screen.dart'; 
import 'signin_screen.dart'; 
import 'signup_screen.dart'; 
import 'home_screen.dart';
import 'review_and_rating_screen.dart';
import 'settings_screen.dart';

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
        '/destination_list': (context) => DestinationListScreen(), // Add route for the destination list screen;
        '/settings': (context) => SettingsScreen(), // Add route for the settings screen
        '/destination_list_park': (context) => DestinationListScreenPark(), // Add route for the destination list screen;
        '/destination_list_history': (context) => DestinationListScreenHistory(), // Add route for the destination list screen;
        '/destination_list_city': (context) => DestinationListScreenCity(), // Add route for the destination list screen;
        '/itinerary_planner': (context) => ItineraryPlannerScreen(), // Add route for the itinerary planner screen
        '/transportation': (context) => TransportationScreen(), // Add route for the transportation screen
        '/public_transport': (context) => PublicTransportScreen(), // Add route for the public transport screen
        '/ride_sharing': (context) => RideSharingScreen(), // Add route for the ride sharing screen
        '/ticket_booking': (context) => TicketBookingScreen(), // Add route for
        '/travel_tips': (context) => TravelTipsScreen(), // Add route for the travel tips screen
        '/booking': (context) => BookingScreen(serviceName: '',), // Add route for the booking screen
        '/favourites_list': (context) => FavoritesListScreen(favoriteDestinations: [], favorites: [],), // Add route for the favourites list screen
        '/detail': (context) => DetailScreen(place: {}), // Add route for the detail screen
        
      
      },
    );
  }
}
