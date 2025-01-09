import 'package:flutter/material.dart';
import 'public_transport_screen.dart';
import 'ride_sharing_screen.dart';
import 'ticket_booking_screen.dart';
import 'travel_tips_screen.dart';

class TransportationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transportation & Travel Options'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildOptionCard(
              context,
              'Public Transport',
              Icons.directions_bus,
              'Find schedules and routes for buses and trains.',
              Colors.blueAccent,
              PublicTransportScreen(),
            ),
            _buildOptionCard(
              context,
              'Ride Sharing & Rentals',
              Icons.local_taxi,
              'Book taxis, tuk-tuks, or rent cars.',
              Colors.orangeAccent,
              RideSharingScreen(),
            ),
          
            _buildOptionCard(
              context,
              'Ticket Booking',
              Icons.confirmation_number,
              'Book your tickets for travel.',
              Colors.redAccent,
              TicketBookingScreen(),
            ),
            _buildOptionCard(
              context,
              'Travel Tips',
              Icons.help_outline,
              'Get essential travel tips for Sri Lanka.',
              Colors.purpleAccent,
              TravelTipsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, String title, IconData icon, String description, Color color, Widget screen) {
    return Card(
      color: Colors.grey[800],
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        leading: Icon(icon, color: color, size: 40),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.white70),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
