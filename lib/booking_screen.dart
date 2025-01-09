import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  final String serviceName;

  BookingScreen({required this.serviceName});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.serviceName} Booking'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book ${widget.serviceName}',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Fill in the details to book your ride or rental.',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            _buildTextField('Destination', _destinationController, Icons.location_on),
            SizedBox(height: 16),
            _buildTextField('Date (DD/MM/YYYY)', _dateController, Icons.calendar_today),
            SizedBox(height: 16),
            _buildTextField('Time (HH:MM)', _timeController, Icons.access_time),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                onPressed: () {
                  // Implement booking confirmation logic here
                  _confirmBooking();
                },
                child: Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.greenAccent),
        ),
      ),
    );
  }

  void _confirmBooking() {
    final destination = _destinationController.text;
    final date = _dateController.text;
    final time = _timeController.text;

    if (destination.isEmpty || date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all the fields.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking Confirmed for $destination on $date at $time!')),
    );

    // Clear fields after confirmation
    _destinationController.clear();
    _dateController.clear();
    _timeController.clear();
  }
}
