import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'favorites_list_screen.dart';
import 'search_screen_history.dart';

class DestinationListScreenHistory extends StatefulWidget {
  @override
  _DestinationListScreenHistoryState createState() => _DestinationListScreenHistoryState();
}

class _DestinationListScreenHistoryState extends State<DestinationListScreenHistory> {
  final List<Map<String, String>> destinations = [
    {
      'name': 'Adams Peak',
      'image': 'images/Adams_Peak_historical_sites.jpg',
      'description': 'Adam’s Peak, also known as Sri Pada, is one of Sri Lanka’s most sacred mountains. Pilgrims from various religions visit the peak, where a footprint-shaped mark is said to belong to Lord Buddha, Shiva, or Adam, depending on the belief. The 2,243-meter tall mountain is also a UNESCO World Heritage site and is famous for its breathtaking sunrise. Visitors can trek the 5,000-step route, passing through lush forests and witnessing stunning views from the summit.'
    },
    {
      'name': 'Dambulla Viharaya',
      'image': 'images/Dambulla_wiharaya_historical_sites.jpg',
      'description': 'The Dambulla Cave Temple is a historic Buddhist temple located in central Sri Lanka. Known for its intricate rock paintings and statues of Buddha, it is one of the largest and best-preserved cave temples in Sri Lanka. The temple complex consists of five caves, which are adorned with stunning murals that depict the life of the Buddha. The site, a UNESCO World Heritage site, has attracted both religious pilgrims and tourists for its historical and spiritual significance.'
    },
    {
      'name': 'Rock Temple',
      'image': 'images/gal_wiharaya_historical_sites.jpg',
      'description': 'The Rock Temple, also known as the Gal Vihara, is a remarkable historical site in Sri Lanka. Located in Polonnaruwa, it features a series of Buddha statues carved into a massive granite rock. The most famous of these is the 14-meter long reclining Buddha. The site is a significant testament to the artistic and architectural achievements of ancient Sri Lankan civilization. It is an important place of worship and a UNESCO World Heritage site, showcasing the rich cultural heritage of the island.'
    },
    {
      'name': 'Isurumuniya Temple',
      'image': 'images/Isurumuniya_Temple_historical_sites.jpg',
      'description': 'Isurumuniya Temple, located near Anuradhapura, is one of Sri Lanka’s most renowned ancient temples. Famous for its beautiful rock carvings, including the iconic Isurumuniya Lovers, the temple is a significant Buddhist site. The temple complex features a serene atmosphere, with a large pond and peaceful surroundings. The history of Isurumuniya dates back to the 3rd century BCE, making it a valuable cultural and historical landmark. It is also an important pilgrimage site for Buddhists around the world.'
    },
    {
      'name': 'Jaya Sri Maha Bhodiya',
      'image': 'images/jayasirimaha_bodiya_historical_sites.jpg',
      'description': 'Jaya Sri Maha Bodhiya, located in Anuradhapura, is one of the most revered Buddhist sites in Sri Lanka. It is home to the Sri Maha Bodhi, the oldest historically authenticated tree in the world, which is said to have been grown from a cutting of the original tree under which Buddha attained enlightenment. This sacred site attracts thousands of pilgrims who come to pay homage. The temple complex surrounding the tree includes beautiful stupas, statues, and shrines, adding to its religious and historical significance.'
    },
    {
      'name': 'Sigiriya',
      'image': 'images/sigiriya_historical_sites.jpg',
      'description': 'Sigiriya, also known as Lion’s Rock, is a stunning ancient rock fortress located in central Sri Lanka. It is a UNESCO World Heritage site and one of the most iconic landmarks of Sri Lankan history. The fortress was built during the 5th century by King Kashyapa and is renowned for its impressive frescoes, its massive lion’s paws at the entrance, and its remarkable water gardens. Sigiriya offers panoramic views of the surrounding landscape and is a must-visit for anyone interested in Sri Lanka’s history and architecture.'
    },
    {
      'name': 'Temple of the Tooth',
      'image': 'images/Temple_of_the_Tooth_historical_site.jpg',
      'description': 'The Temple of the Tooth, located in Kandy, is one of the most important Buddhist sites in Sri Lanka. It houses the sacred relic of Buddha’s tooth, which has great religious significance. The temple, also known as the Dalada Maligawa, is a symbol of Sri Lanka’s rich Buddhist heritage and history. Pilgrims from around the world visit this site to pay respects and participate in religious ceremonies. The surrounding complex includes beautiful gardens, museums, and stunning architecture, making it a cultural treasure for Sri Lanka.'
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
            'Historical Sites in Sri Lanka',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 22,
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
            icon: Icon(Icons.search,color: Colors.white),
            onPressed: () {
              // Navigate to the SearchScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreenHistory(destinations: destinations),
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
                    builder: (context) => HistoryDetailScreen(
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



class HistoryDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String description;

  HistoryDetailScreen({
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  _HistoryDetailScreenState createState() => _HistoryDetailScreenState();
}

class _HistoryDetailScreenState extends State<HistoryDetailScreen> {
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
            if (widget.name == "Adams Peak") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/adam_1.jpg');
                      },
                      child: Image.asset(
                        'images/adam_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/adam_2.jpg');
                      },
                      child: Image.asset(
                        'images/adam_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/adam_3.jpg');
                      },
                      child: Image.asset(
                        'images/adam_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/adam_4.jpg');
                      },
                      child: Image.asset(
                        'images/adam_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Dambulla Viharaya") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/dambulla_1.jpg');
                      },
                      child: Image.asset(
                        'images/dambulla_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/dambulla_2.jpg');
                      },
                      child: Image.asset(
                        'images/dambulla_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/dambulla_3.jpg');
                      },
                      child: Image.asset(
                        'images/dambulla_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/dambulla_4.jpg');
                      },
                      child: Image.asset(
                        'images/dambulla_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Rock Temple") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/rock_1.jpg');
                      },
                      child: Image.asset(
                        'images/rock_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/rock_2.jpg');
                      },
                      child: Image.asset(
                        'images/rock_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/rock_3.jpg');
                      },
                      child: Image.asset(
                        'images/rock_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/rock_4.jpg');
                      },
                      child: Image.asset(
                        'images/rock_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Isurumuniya Temple") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/isurumuni_1.jpg');
                      },
                      child: Image.asset(
                        'images/isurumuni_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/isurumuni_2.jpg');
                      },
                      child: Image.asset(
                        'images/isurumuni_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/isurumuni_3.jpg');
                      },
                      child: Image.asset(
                        'images/isurumuni_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/isurumuni_4.jpg');
                      },
                      child: Image.asset(
                        'images/isurumuni_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Jaya Sri Maha Bhodiya") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jayasri_1.jpg');
                      },
                      child: Image.asset(
                        'images/jayasri_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jayasri_2.jpg');
                      },
                      child: Image.asset(
                        'images/jayasri_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jayasri_3.jpg');
                      },
                      child: Image.asset(
                        'images/jayasri_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('jayasri_4.jpg');
                      },
                      child: Image.asset(
                        'images/jayasri_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Sigiriya") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/sigiriya_1.jpg');
                      },
                      child: Image.asset(
                        'images/sigiriya_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/sigiriya_2.jpg');
                      },
                      child: Image.asset(
                        'images/sigiriya_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/sigiriya_3.jpg');
                      },
                      child: Image.asset(
                        'images/sigiriya_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/sigiriya_4.jpg');
                      },
                      child: Image.asset(
                        'images/sigiriya_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Temple of the Tooth") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Tooth_1.jpg');
                      },
                      child: Image.asset(
                        'images/Tooth_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Tooth_2.jpg');
                      },
                      child: Image.asset(
                        'images/Tooth_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Tooth_3.jpg');
                      },
                      child: Image.asset(
                        'images/Tooth_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Tooth_4.jpg');
                      },
                      child: Image.asset(
                        'images/Tooth_4.jpg',
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