import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart'; 
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ticket Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicketBookingScreen(),
    );
  }
}

class TicketBookingScreen extends StatefulWidget {
  @override
  _TicketBookingScreenState createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedTransport = 'Bus';

  final List<String> _transportOptions = ['Bus', 'Train', 'Activity'];
  
  // Firebase Realtime Database reference
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref().child('bookings');
  
  // Date formatting
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket Booking'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Your Tickets',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Easily book tickets for buses, trains, or activities with just a few clicks.',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            _buildDropdown(),
            SizedBox(height: 16),
            _buildTextField('Destination', _destinationController, Icons.location_on),
            SizedBox(height: 16),
            _buildDateField(),
            SizedBox(height: 16),
            _buildTextField('Time (HH:MM)', _timeController, Icons.access_time),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: _saveBooking,
                child: Text('Book Ticket'),
              ),
            ),
            SizedBox(height: 24),
            Divider(color: Colors.white70),
            Text(
              'Your Bookings',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBookingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedTransport,
      dropdownColor: Colors.black87,
      decoration: InputDecoration(
        labelText: 'Transport Type',
        labelStyle: TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
      style: TextStyle(color: Colors.white),
      items: _transportOptions.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedTransport = newValue!;
        });
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
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
          borderSide: BorderSide(color: Colors.redAccent),
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
            labelText: 'Date (DD/MM/YYYY)',
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

  Widget _buildBookingsList() {
    return StreamBuilder(
      stream: _dbRef.onValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final data = snapshot.data?.snapshot?.value;
        if (data == null) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'No bookings yet. Start by booking a ticket!',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        // Cast the data to Map<String, dynamic>
        Map<dynamic, dynamic> bookingsData = data as Map<dynamic, dynamic>;

        // Convert the data into a list of bookings
        List<Map<String, String>> bookings = [];
        bookingsData.forEach((key, value) {
          bookings.add({
            'id': key, // Store the Firebase ID for deletion
            'transport': value['transport'] ?? 'Unknown', // Handle null by providing default values
            'destination': value['destination'] ?? 'Unknown',
            'date': value['date'] ?? 'Unknown',
            'time': value['time'] ?? 'Unknown',
          });
        });

        return Expanded(
          child: ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                color: Colors.grey[800],
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(
                    Icons.confirmation_num,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    '${booking['transport']} to ${booking['destination']}',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Date: ${booking['date']} - Time: ${booking['time']}',
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => _deleteBooking(booking['id']),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Function to delete a booking
  void _deleteBooking(String? id) {
    if (id != null) {
      _dbRef.child(id).remove().then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking deleted successfully!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting booking: $error')),
        );
      });
    }
  }

  void _saveBooking() {
    final destination = _destinationController.text;
    final date = _dateController.text;
    final time = _timeController.text;

    if (destination.isEmpty || date.isEmpty || time.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all the fields.')),
      );
      return;
    }

    // Save booking to Firebase Realtime Database
    _dbRef.push().set({
      'transport': _selectedTransport,
      'destination': destination,
      'date': date,
      'time': time,
    });

    // Clear input fields
    _destinationController.clear();
    _dateController.clear();
    _timeController.clear();
    setState(() {
      _selectedTransport = 'Bus';
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking added successfully!')),
    );
  }
}
