import 'package:flutter/material.dart';

class PublicTransportScreen extends StatelessWidget {
  final List<Map<String, String>> busSchedule = [
    {'Route': 'Colombo - Kandy', 'Time': '06:00 AM'},
    {'Route': 'Galle - Colombo', 'Time': '07:30 AM'},
    {'Route': 'Jaffna - Colombo', 'Time': '08:45 AM'},
    {'Route': 'Matara - Colombo', 'Time': '10:15 AM'},
  ];

  final List<Map<String, String>> trainSchedule = [
    {'Route': 'Colombo - Badulla', 'Time': '05:30 AM'},
    {'Route': 'Kandy - Colombo', 'Time': '07:00 AM'},
    {'Route': 'Matara - Colombo', 'Time': '09:00 AM'},
    {'Route': 'Jaffna - Colombo', 'Time': '01:00 PM'},
  ];

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
