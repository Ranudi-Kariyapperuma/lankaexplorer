import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'favorites_list_screen.dart';
import 'search_screen_city.dart';

class DestinationListScreenCity extends StatefulWidget {
  @override
  _DestinationListScreenCityState createState() => _DestinationListScreenCityState();
}

class _DestinationListScreenCityState extends State<DestinationListScreenCity> {
  final List<Map<String, String>> destinations = [
    {
      'name': 'Colombo City',
      'image': 'images/colombo_city_tour.jpg',
      'description': 'Colombo, the commercial capital of Sri Lanka, is a vibrant city that blends colonial charm with modern development. Visitors can explore historical landmarks such as the Gangaramaya Temple, the Colombo National Museum, and the colonial-era buildings that line the streets. The city is also known for its beautiful coastal views, vibrant markets, and bustling street life. Colombo offers a fascinating mix of cultural heritage, colonial history, and contemporary attractions, making it an essential stop on any tour of Sri Lanka.'
    },
    {
      'name': 'Ella City',
      'image': 'images/ella_city_tours.jpg',
      'description': 'Ella is a scenic hill town in Sri Lanka, known for its breathtaking views, lush greenery, and tranquil atmosphere. Situated in the central highlands, Ella offers visitors an opportunity to experience nature at its best. Popular attractions include the Ella Rock hike, the Nine Arches Bridge, and Ravana Falls. Ella is a paradise for nature lovers and adventure enthusiasts, offering opportunities for hiking, sightseeing, and relaxing amidst the misty hills and tea plantations. The town’s cool climate adds to its charm.'
    },
    {
      'name': 'Galle City',
      'image': 'images/galle_city_tours.jpg',
      'description': 'Galle, a UNESCO World Heritage site, is a historic city on the southwest coast of Sri Lanka. The Galle Fort, built by the Portuguese in the 16th century and expanded by the Dutch, is the highlight of the city, offering stunning views of the coastline. Galle is also known for its colonial-era architecture, charming streets, vibrant markets, and beautiful beaches. The city is a perfect blend of history, culture, and scenic beauty, making it one of the most popular tourist destinations in Sri Lanka.'
    },
    {
      'name': 'Kandy City',
      'image': 'images/kandy_city.jpg',
      'description': 'Kandy, the cultural capital of Sri Lanka, is nestled amidst lush hills and famed for the sacred Temple of the Tooth Relic, a UNESCO World Heritage Site. Its serene Kandy Lake, rich heritage, and vibrant Esala Perahera festival attract visitors seeking spiritual, cultural, and scenic experiences.'
    },
    {
      'name': 'Anuradhapura City',
      'image': 'images/anuradhapura_city_tour.jpg',
      'description': 'Anuradhapura, a cradle of ancient Sri Lankan civilization, is renowned for its monumental stupas, sacred Sri Maha Bodhi tree, and well-preserved ruins of palaces and monasteries.'
    },
    {
      'name': 'Jaffna City',
      'image': 'images/jaffna_city.jpg',
      'description': 'Situated in the northernmost part of Sri Lanka, Jaffna is a vibrant city that showcases the unique culture and heritage of the Tamil community. Known for its ancient temples, such as the majestic Nallur Kandaswamy Kovil, Jaffna is a city of resilience and tradition. '
    },
  ];

  // Fevorites
  List<bool> isFavorited = List.filled(6, false);
  List<Map<String, String>> favoriteDestinations = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 240, 240, 240)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'City Tours in Sri Lanka',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 126, 91),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              // Pass the favorite destinations list to the FavoritesScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesListScreen(favoriteDestinations: favoriteDestinations, favorites: [],),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreenCity(destinations: destinations),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityDetailScreen(
                      name: destinations[index]['name']!,
                      image: destinations[index]['image']!,
                      description: destinations[index]['description']!,
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorited[index] = !isFavorited[index];
                                if (isFavorited[index]) {
                                  favoriteDestinations.add(destinations[index]);
                                } else {
                                  favoriteDestinations.remove(destinations[index]);
                                }
                              });
                            },
                            child: Icon(
                              isFavorited[index] ? Icons.favorite : Icons.favorite_border,
                              color: isFavorited[index] ? Colors.red : Colors.grey,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            destinations[index]['name']!,
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
                        destinations[index]['image']!,
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
    );
  }
}


class CityDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String description;

  CityDetailScreen({
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  _CityDetailScreenState createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  bool isLiked = false; // Track the like status
  List<String> comments = []; // List to store the comments
  TextEditingController _commentController = TextEditingController(); // Controller for comment input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white, // Set the name color to white
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 126, 91),
        iconTheme: IconThemeData(color: Colors.white), // Set the back icon to white
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.image,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.name,
                style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 70, 187, 142),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Extra Images Section Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Extra Images',
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 70, 187, 142),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Display additional images for Arugambay Beach
            if (widget.name == "Colombo City") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/colombo_1.jpg');
                      },
                      child: Image.asset(
                        'images/colombo_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/colombo_2.jpg');
                      },
                      child: Image.asset(
                        'images/colombo_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/colombo_3.jpg');
                      },
                      child: Image.asset(
                        'images/colombo_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/colombo_4.jpg');
                      },
                      child: Image.asset(
                        'images/colombo_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Ella City") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/ella_1.jpg');
                      },
                      child: Image.asset(
                        'images/ella_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/ella_2.jpg');
                      },
                      child: Image.asset(
                        'images/ella_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/ella_3.jpg');
                      },
                      child: Image.asset(
                        'images/ella_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/ella_4.jpg');
                      },
                      child: Image.asset(
                        'images/ella_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Galle City") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/galle_1.jpg');
                      },
                      child: Image.asset(
                        'images/galle_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/galle_2.jpg');
                      },
                      child: Image.asset(
                        'images/galle_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/galle_3.jpg');
                      },
                      child: Image.asset(
                        'images/galle_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/galle_4.jpg');
                      },
                      child: Image.asset(
                        'images/galle_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Kandy City") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kandy_1.jpg');
                      },
                      child: Image.asset(
                        'images/kandy_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kandy_2.jpg');
                      },
                      child: Image.asset(
                        'images/kandy_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kandy_3.jpg');
                      },
                      child: Image.asset(
                        'images/kandy_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kandy_4.jpg');
                      },
                      child: Image.asset(
                        'images/kandy_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Anuradhapura City") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/anuradapura_1.jpg');
                      },
                      child: Image.asset(
                        'images/anuradapura_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/anuradapura_2.jpg');
                      },
                      child: Image.asset(
                        'images/anuradapura_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/anuradapura_3.jpg');
                      },
                      child: Image.asset(
                        'images/anuradapura_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('anuradapura_4.jpg');
                      },
                      child: Image.asset(
                        'images/anuradapura_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Jaffna City") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jaffna_1.jpg');
                      },
                      child: Image.asset(
                        'images/jaffna_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jaffna_2.jpg');
                      },
                      child: Image.asset(
                        'images/jaffna_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jaffna_3.jpg');
                      },
                      child: Image.asset(
                        'images/jaffna_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jaffna_4.jpg');
                      },
                      child: Image.asset(
                        'images/jaffna_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16),
            // Like, Comment, and Share Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Like Icon
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up,
                      color: isLiked ? Colors.yellow : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                  Text(
                    "Like",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Comment Icon
                  IconButton(
                    icon: Icon(
                      Icons.comment,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Comment'),
                          content: TextField(
                            controller: _commentController,
                            decoration: InputDecoration(
                              hintText: 'Write your comment...',
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  comments.add(_commentController.text); // Add comment to the list
                                  _commentController.clear(); // Clear the input field
                                });
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Post'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Text(
                    "Comment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Share Icon
                  IconButton(
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      final String shareText =
                          'Check out this amazing beach: ${widget.name}\n\nDescription: ${widget.description}';
                      Share.share(shareText);
                    },
                  ),
                  Text(
                    "Share",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // Loop through the list of comments and display each one
    for (var comment in comments)
      Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.all(10),
        width: double.infinity, // Make the container take up the full width
        height: 100, // Fixed height for each comment box
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 37, 37, 37), // Ash-colored background
          borderRadius: BorderRadius.circular(12), // Apply curved corners
        ),
        child: Text(
          comment,
          style: TextStyle(fontSize: 16,color: Colors.white),
          overflow: TextOverflow.ellipsis, // Handles long comments gracefully
          maxLines: 3, // Limits comment lines to 3
        ),
      ),
  ],
),

  // padding: const EdgeInsets.symmetric(horizontal: 16.0),
  // child: Column(
  //   crossAxisAlignment: CrossAxisAlignment.start,
  //   children: [
  //     // Loop through the list of comments and display each one
  //     for (var comment in comments)
  //       Container(
  //         margin: EdgeInsets.symmetric(vertical: 5),
  //         padding: EdgeInsets.all(10),
  //         width: double.infinity, // Make the container take up the full width
  //         height: 100, // Fixed height for each comment box
  //         color: const Color.fromARGB(255, 37, 37, 37), // Ash-colored background
  //         child: Text(
  //           comment,
  //           style: TextStyle(fontSize: 16),
  //           overflow: TextOverflow.ellipsis, // Handles long comments gracefully
  //           maxLines: 3, // Limits comment lines to 3
  //         ),
  //       ),
  //   ],
  // ),
),
            // SizedBox(height: 16),
            // // Display posted comments below the comment section
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       // Loop through the list of comments and display each one
            //       for (var comment in comments)
            //         Container(
            //           margin: EdgeInsets.symmetric(vertical: 5),
            //           padding: EdgeInsets.all(10),
            //           color: const Color.fromARGB(255, 0, 0, 0), // Ash-colored background
            //           child: Text(
            //             comment,
            //             style: TextStyle(fontSize: 16),
            //           ),
            //         ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // Function to show large image
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