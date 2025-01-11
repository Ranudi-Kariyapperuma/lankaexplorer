import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database

class RideSharingScreen extends StatefulWidget {
  @override
  _RideSharingScreenState createState() => _RideSharingScreenState();
}

class _RideSharingScreenState extends State<RideSharingScreen> {
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController(); // Time controller

  List<Map<String, String?>> _bookings = []; // List to store booking details
  String _selectedService = '';
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('bookings'); // Firebase reference

  @override
  void initState() {
    super.initState();
    _enableOfflinePersistence(); // Enable offline mode
    _loadBookings(); // Load existing bookings from Firebase
  }

  // Enable offline persistence
  void _enableOfflinePersistence() {
    FirebaseDatabase.instance.setPersistenceEnabled(true); // Enable persistence
    FirebaseDatabase.instance.setPersistenceCacheSizeBytes(10000000); // Set cache size (optional)
  }

  // Load bookings from Firebase
  Future<void> _loadBookings() async {
    _dbRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          _bookings.clear();
          data.forEach((key, value) {
            _bookings.add(Map<String, String?>.from(value)..['id'] = key); // Add Firebase ID as 'id' key
          });
        });
      }
    });
  }

  // Method to delete booking from Firebase and the UI
  void _deleteBooking(String? bookingId) async {
    try {
      if (bookingId != null) {
        await _dbRef.child(bookingId).remove(); // Remove booking from Firebase
        setState(() {
          _bookings.removeWhere((booking) => booking['id'] == bookingId); // Remove booking from local list
        });
      }
    } catch (e) {
      print("Error deleting booking: $e"); // Debug error if deletion fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride Sharing & Rentals'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Book a Ride or Rent a Vehicle',
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Choose from various ride-sharing services or rental options to suit your travel needs.',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            _buildDateField(),
            SizedBox(height: 16),
            _buildTimeField(), // Time picker field
            SizedBox(height: 16),
            _buildOptionCard(
              context,
              'Uber',
              Icons.local_taxi,
              'Book a quick ride using Uber for convenient travel.',
              Colors.orangeAccent,
            ),
            _buildOptionCard(
              context,
              'PickMe',
              Icons.directions_car,
              'Find affordable rides and local taxis with PickMe.',
              Colors.greenAccent,
            ),
            _buildOptionCard(
              context,
              'Car Rentals',
              Icons.car_rental,
              'Rent a car for a day or long-term travel needs.',
              Colors.blueAccent,
            ),
            _buildOptionCard(
              context,
              'Bike Rentals',
              Icons.pedal_bike,
              'Explore on two wheels by renting a bike or scooter.',
              Colors.purpleAccent,
            ),
            SizedBox(height: 24),
            Text(
              'Your Bookings:',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildBookingsList(),
          ],
        ),
      ),
    );
  }

  // Date picker field with calendar
  Widget _buildDateField() {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        child: TextField(
          controller: _dateController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Select Date',
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.calendar_today, color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }

  // Time picker field
  Widget _buildTimeField() {
    return GestureDetector(
      onTap: _selectTime,
      child: AbsorbPointer(
        child: TextField(
          controller: _timeController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Select Time',
            labelStyle: TextStyle(color: Colors.white70),
            prefixIcon: Icon(Icons.access_time, color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white70),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      ),
    );
  }

  // Open Date Picker Dialog
  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = _dateFormat.format(pickedDate); // Format selected date
      });
    }
  }

  // Open Time Picker Dialog
  Future<void> _selectTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context); // Format selected time
      });
    }
  }

  // Option card for ride-sharing or rentals
  Widget _buildOptionCard(
      BuildContext context, String title, IconData icon, String description, Color color) {
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
          style: TextStyle(color: const Color.fromARGB(179, 255, 242, 242)),
        ),
        onTap: () {
          setState(() {
            _selectedService = title;
          });
          _showBookingDialog(title);
        },
      ),
    );
  }

  // Show booking dialog
  void _showBookingDialog(String serviceName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Booking for $serviceName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date: ${_dateController.text}', style: TextStyle(color: const Color.fromARGB(255, 255, 251, 251))),
              SizedBox(height: 8),
              Text('Time: ${_timeController.text}', style: TextStyle(color: const Color.fromARGB(255, 255, 251, 251))),
              SizedBox(height: 8),
              Text('Service: $serviceName', style: TextStyle(color: const Color.fromARGB(255, 253, 250, 250))),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Save booking to Firebase
                final newBookingRef = _dbRef.push(); // Create a new unique reference for the booking
                newBookingRef.set({
                  'service': serviceName,
                  'date': _dateController.text,
                  'time': _timeController.text,
                });

                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Display bookings list
  Widget _buildBookingsList() {
    if (_bookings.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          'No bookings yet. Start by booking a ride!',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true, // Makes sure the list view only takes up necessary space
      itemCount: _bookings.length,
      itemBuilder: (context, index) {
        final booking = _bookings[index];
        return Card(
          color: Colors.grey[800],
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(Icons.check_circle, color: Colors.greenAccent),
            title: Text(
              '${booking['service']} - ${booking['date']} at ${booking['time']}',
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                // Call the delete method when the delete icon is tapped
                _deleteBooking(booking['id']);
              },
            ),
          ),
        );
      },
    );
  }
}
