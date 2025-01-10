import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'favorites_list_screen.dart';
import 'home_screen.dart';
import 'review_and_rating_screen.dart';
import 'settings_screen.dart';

class ItineraryPlannerScreen extends StatefulWidget {
  @override
  _ItineraryPlannerScreenState createState() => _ItineraryPlannerScreenState();
}

class _ItineraryPlannerScreenState extends State<ItineraryPlannerScreen> {

int _selectedIndex = 2; // Default to the "Reviews" page

 void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      // Navigate to Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }  else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReviewAndRatingScreen(title: 'Review & Rating')),
      );
      // Stay on the current Reviews Screen
    } else if (index == 2) {
        Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => ItineraryPlannerScreen(),
        ),
      );
      // Navigate to Settings Screen (This is a placeholder)
      // You can add your settings screen logic here
     }else if (index == 3) {
      // Navigate to Settings Screen (This is a placeholder)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
      // You can add your settings screen logic here
    }
  }


  DateTime? startDate;
  DateTime? endDate;
  final List<Map<String, dynamic>> activities = [];
  final TextEditingController activityController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController timeSlotController = TextEditingController();
  final TextEditingController accommodationController = TextEditingController();

  void pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
      ),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  void addActivity() {
    if (activityController.text.isNotEmpty &&
        timeSlotController.text.isNotEmpty &&
        accommodationController.text.isNotEmpty) {
      setState(() {
        activities.add({
          'activity': activityController.text,
          'budget': budgetController.text.isEmpty ? "N/A" : budgetController.text,
          'timeSlot': timeSlotController.text,
          'accommodation': accommodationController.text,
        });
      });
      activityController.clear();
      budgetController.clear();
      timeSlotController.clear();
      accommodationController.clear();
    }
  }

  void editActivity(int index) {
    activityController.text = activities[index]['activity'];
    budgetController.text = activities[index]['budget'];
    timeSlotController.text = activities[index]['timeSlot'];
    accommodationController.text = activities[index]['accommodation'];
    setState(() {
      activities.removeAt(index);
    });
  }

  void deleteActivity(int index) {
    setState(() {
      activities.removeAt(index);
    });
  }

  void shareActivity(int index) {
    final activity = activities[index];
    final details =
        'Activity: ${activity['activity']}\nTime Slot: ${activity['timeSlot']}\nAccommodation: ${activity['accommodation']}\nBudget: ${activity['budget']}';
    Share.share(details);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Itinerary Planner',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 126, 91),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/ella_city_tours.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Picker
                ElevatedButton(
                  onPressed: pickDateRange,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Select Trip Dates',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                if (startDate != null && endDate != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'Trip Dates: ${startDate!.toLocal().toString().split(' ')[0]} - ${endDate!.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),

                
                SizedBox(height: 10),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: activityController,
                  decoration: InputDecoration(
                    hintText: 'Enter Activity',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: timeSlotController,
                  decoration: InputDecoration(
                    hintText: 'Enter Time Slot (e.g., 9:00 AM - 10:00 AM)',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: accommodationController,
                  decoration: InputDecoration(
                    hintText: 'Enter Accommodation',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Budget (Optional)',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 52, 182, 214),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Add Activity',
                    style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
                SizedBox(height: 20),

                // Display Activities
                if (activities.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 44, 44, 44),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Planned Activities:',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 4, 168, 218),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: activities.length,
                          itemBuilder: (context, index) {
                            final activity = activities[index];
                            return Card(
                              color: const Color.fromARGB(255, 59, 59, 59),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                title: Text(activity['activity'],
                                    style: TextStyle(color: Colors.white)),
                                subtitle: Text(
                                  'Time Slot: ${activity['timeSlot']}\nAccommodation: ${activity['accommodation']}\nBudget: ${activity['budget']}',
                                  style: TextStyle(color: Colors.grey[300]),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.green),
                                      onPressed: () => editActivity(index),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () => deleteActivity(index),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.share, color: Colors.blue),
                                      onPressed: () => shareActivity(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        
                      ],
                    ),
                  ),
                SizedBox(height: 20),
              ],
            ),
          ),
          
        ],
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, 
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), 
            label: 'Reviews',
          ),
         BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today, color: _selectedIndex == 3 ? Colors.teal : Colors.grey), // Color the rating icon
          label: 'Itinerary Planner'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.teal, 
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
