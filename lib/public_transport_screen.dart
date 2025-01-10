import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // To encode/decode JSON data

class PublicTransportScreen extends StatefulWidget {
  @override
  _PublicTransportScreenState createState() => _PublicTransportScreenState();
}

class _PublicTransportScreenState extends State<PublicTransportScreen> {
  late List<Map<String, String>> busSchedule;
  late List<Map<String, String>> trainSchedule;

  @override
  void initState() {
    super.initState();
    _loadSchedules();
  }

  // Load schedules from shared preferences or default values if not available
  _loadSchedules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? busScheduleJson = prefs.getString('busSchedule');
    String? trainScheduleJson = prefs.getString('trainSchedule');

    if (busScheduleJson != null && trainScheduleJson != null) {
      // Decode JSON if available
      setState(() {
        busSchedule = List<Map<String, String>>.from(json.decode(busScheduleJson));
        trainSchedule = List<Map<String, String>>.from(json.decode(trainScheduleJson));
      });
    } else {
      // If not available, use default values
      setState(() {
        busSchedule = [
          {'Route': 'Colombo - Kandy', 'Time': '06:00 AM'},
          {'Route': 'Galle - Colombo', 'Time': '07:30 AM'},
          {'Route': 'Jaffna - Colombo', 'Time': '08:45 AM'},
          {'Route': 'Matara - Colombo', 'Time': '10:15 AM'},
        ];

        trainSchedule = [
          {'Route': 'Colombo - Badulla', 'Time': '05:30 AM'},
          {'Route': 'Kandy - Colombo', 'Time': '07:00 AM'},
          {'Route': 'Matara - Colombo', 'Time': '09:00 AM'},
          {'Route': 'Jaffna - Colombo', 'Time': '01:00 PM'},
        ];
      });
    }
  }

  // Save schedules to shared preferences
  _saveSchedules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('busSchedule', json.encode(busSchedule));
    prefs.setString('trainSchedule', json.encode(trainSchedule));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Public Transport'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bus and Train Schedules',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildScheduleSection('Bus Schedule', busSchedule),
                  SizedBox(height: 16),
                  _buildScheduleSection('Train Schedule', trainSchedule),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleSection(String title, List<Map<String, String>> schedule) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: schedule.length,
          separatorBuilder: (context, index) => Divider(color: Colors.white24),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                schedule[index]['Route']!,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                schedule[index]['Time']!,
                style: TextStyle(color: Colors.white70),
              ),
            );
          },
        ),
      ],
    );
  }
}
