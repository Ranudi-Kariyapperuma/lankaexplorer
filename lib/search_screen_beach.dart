import 'package:flutter/material.dart';
import 'destination_list_screen.dart';
import 'package:share_plus/share_plus.dart';


class SearchScreenBeach extends StatefulWidget {
  final List<Map<String, String>> destinations;

  const SearchScreenBeach({super.key, required this.destinations});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenBeach> {
  List<Map<String, String>> filteredDestinations = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredDestinations = widget.destinations; 
  }

  void _filterDestinations(String query) {
    List<Map<String, String>> results = [];
    if (query.isEmpty) {
      results = widget.destinations; 
    } else {
      results = widget.destinations
          .where((destination) =>
              destination['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      filteredDestinations = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Destinations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 126, 91),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterDestinations,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Destinations...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BeachDetailScreen(
                            name: filteredDestinations[index]['name']!,
                            image: filteredDestinations[index]['image']!,
                            description: filteredDestinations[index]['description']!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 48, 47, 47),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                const Icon(Icons.favorite_border, color: Colors.grey),
                                const SizedBox(width: 10),
                                Text(
                                  filteredDestinations[index]['name']!,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 70, 187, 142),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                            child: Image.asset(
                              filteredDestinations[index]['image']!,
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Reviews'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            // Navigate to the FavoritesListScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritesListScreen(
                  favorites: const [],
                  favoriteDestinations: const [],
                ),
              ),
            );
          } else if (index == 2) {
            // Navigate to the ReviewAndRatingScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewAndRatingScreen(
                  title: 'Review & Rating',
                ),
              ),
            );
          } else if (index == 4) {
            // Navigate to the SettingsScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  void _showLargeImage(String imagePath) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// Placeholder for other screens
class FavoritesListScreen extends StatelessWidget {
  final List favorites;
  final List favoriteDestinations;

  const FavoritesListScreen({required this.favorites, required this.favoriteDestinations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: Center(child: Text('Favorites Screen')),
    );
  }
}

class ReviewAndRatingScreen extends StatelessWidget {
  final String title;

  const ReviewAndRatingScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('Review & Rating Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(child: Text('Settings Screen')),
    );
  }
}








