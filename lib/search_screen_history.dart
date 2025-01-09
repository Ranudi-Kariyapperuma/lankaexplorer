import 'package:flutter/material.dart';
import 'destination_list_screen_history.dart';
import 'package:share_plus/share_plus.dart';


class SearchScreenHistory extends StatefulWidget {
  final List<Map<String, String>> destinations;

  SearchScreenHistory({required this.destinations});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenHistory> {
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
        title: Text(
          'Search Destinations',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 126, 91),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterDestinations,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search Destinations...',
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.white),
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
                          builder: (context) => HistoryDetailScreen(
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
                            offset: Offset(0, 2),
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
                                Icon(Icons.favorite_border, color: Colors.grey),
                                SizedBox(width: 10),
                                Text(
                                  filteredDestinations[index]['name']!,
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 70, 187, 142),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
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
    );
  }
}
