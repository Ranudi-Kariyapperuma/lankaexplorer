import 'package:flutter/material.dart';

class TravelTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Tips'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.black87),
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTipCard(
              'Stay Hydrated',
              'Always carry a water bottle and stay hydrated, especially during hot weather.',
            ),
            _buildTipCard(
              'Respect Local Culture',
              'Dress modestly and respect local customs and traditions.',
            ),
            _buildTipCard(
              'Use Trusted Transport',
              'Use registered taxis or well-known ride-sharing apps for safer travel.',
            ),
            _buildTipCard(
              'Be Cautious with Wildlife',
              'Avoid feeding or disturbing wildlife during your travels.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(String title, String description) {
    return Card(
      color: Colors.grey[800],
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
