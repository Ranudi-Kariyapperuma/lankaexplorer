import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'favorites_list_screen.dart';
import 'home_screen.dart';
import 'itinerary_planner_screen.dart';
import 'settings_screen.dart';


class ReviewAndRatingScreen extends StatefulWidget {
  const ReviewAndRatingScreen({super.key, required this.title});

  final String title;

  @override
  State<ReviewAndRatingScreen> createState() => _ReviewAndRatingScreenState();
}

class _ReviewAndRatingScreenState extends State<ReviewAndRatingScreen> {
  int _rating = 0;
  TextEditingController _reviewController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  List<Map<String, dynamic>> _reviews = [
    {
      'name': 'John Doe',
      'review': 'Amazing place! Highly recommended!',
      'rating': 5,
      'date': DateTime.now(),
    },
    {
      'name': 'Jane Smith',
      'review': 'Beautiful scenery, but a bit crowded.',
      'rating': 4,
      'date': DateTime.now().subtract(Duration(days: 1)),
    },
  ];

  int _selectedIndex = 2; 

  void _submitReview() {
    if (_reviewController.text.isNotEmpty && _nameController.text.isNotEmpty && _rating > 0) {
      setState(() {
        _reviews.add({
          'name': _nameController.text,
          'review': _reviewController.text,
          'rating': _rating,
          'date': DateTime.now(),
        });
        _reviewController.clear();
        _nameController.clear();
        _rating = 0;
      });
    }
  }

  double _calculateAverageRating() {
    if (_reviews.isEmpty) return 0.0;
    double sum = _reviews.fold(0, (total, review) => total + review['rating']);
    return sum / _reviews.length;
  }

  Map<int, int> _calculateRatingDistribution() {
    Map<int, int> distribution = {1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (var review in _reviews) {
      distribution[review['rating']] = (distribution[review['rating']] ?? 0) + 1;
    }
    return distribution;
  }
  
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
    } else if (index == 1) {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute( builder: (context) => FavoritesListScreen(favoriteDestinations: [], favorites: [],),),
      ); // Navigate to Favorite Screen (This is a placeholder)
      // You can add your favorite screen logic here
    } else if (index == 2) {
      // Stay on the current Reviews Screen
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItineraryPlannerScreen(),
        ),
      );
      // Navigate to Settings Screen (This is a placeholder)
      // You can add your settings screen logic here
    }else if (index == 4) {
      // Navigate to Settings Screen (This is a placeholder)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
      // You can add your settings screen logic here
    }
  }


  @override
  Widget build(BuildContext context) {
    double averageRating = _calculateAverageRating();
    Map<int, int> ratingDistribution = _calculateRatingDistribution();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Icon(Icons.travel_explore, size: 40, color: const Color.fromARGB(255, 247, 248, 248)),
            SizedBox(width: 10),
            Text(widget.title, style: TextStyle(color: const Color.fromARGB(255, 220, 244, 241))),
          ],
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.shade900,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ratings',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                averageRating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 209, 243, 239),
                                ),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star,
                                    color: index < averageRating ? Colors.amber : Color.fromARGB(255, 243, 240, 240),
                                  );
                                }),
                              ),
                              Text(
                                '${_reviews.length} reviews',
                                style: TextStyle(color: const Color.fromARGB(179, 247, 245, 245), fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              children: List.generate(5, (index) {
                                int star = 5 - index;
                                int count = ratingDistribution[star] ?? 0;
                                double percentage = count / _reviews.length;
                                return Row(
                                  children: [
                                    Text('$star', style: TextStyle(fontSize: 16, color: Colors.white)),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: percentage,
                                        backgroundColor: const Color.fromARGB(255, 225, 223, 223),
                                        color: const Color.fromARGB(255, 13, 194, 176),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text('$count', style: TextStyle(fontSize: 16, color: Colors.white)),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(height: 30, color: Colors.white70),
                Text(
                  'Rate Your Experience',
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic,fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                      icon: Icon(
                        Icons.star,
                        color: index < _rating ? Colors.amber : const Color.fromARGB(255, 243, 240, 240),
                        size: 30,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _reviewController,
                  maxLines: 4,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Write your review here...',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(Icons.comment, color: Colors.teal),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submitReview,
                    icon: Icon(Icons.send, color: Colors.white),
                    label: Text('Submit Review'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Divider(height: 30, color: Colors.white70),
                Text(
                  'Customer Reviews',
                  style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: _reviews.length,
                    itemBuilder: (context, index) {
                      final review = _reviews[index];

                      String formattedDate = DateFormat('yyyy-MM-dd').format(review['date']);

                      return Card(
                        color: Colors.grey.shade900,
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal,
                            child: Text(
                              review['rating'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Row(
                            children: [
                              Icon(Icons.person, color: Colors.teal),
                              SizedBox(width: 5),
                              Text(review['name'], style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(review['review'], style: TextStyle(color: Colors.white)),
                              SizedBox(height: 5),
                              Text(
                                'Posted on: $formattedDate',
                                style: TextStyle(fontSize: 12, color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
             // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Set current index based on selected tab
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // Optional: Add color if needed
            backgroundColor: _selectedIndex == 0 ? Colors.teal : Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: _selectedIndex == 2 ? Colors.teal : Colors.grey), // Color the rating icon
            label: 'Reviews',
          ),
         BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today), 
          label: 'Itinerary Planner'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        selectedItemColor: Colors.teal, // Set active tab color
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
