import 'package:flutter/material.dart';

class TukTukScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tuk-Tuk Availability'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Tuk-Tuks Nearby',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Check for available tuk-tuks in your current location.',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              onPressed: () {
                // Add functionality for finding tuk-tuks
              },
              child: Text('Find Tuk-Tuks'),
            ),
          ],
        ),
      ),
    );
  }
}
