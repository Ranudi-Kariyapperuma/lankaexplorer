import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'favorites_list_screen.dart' as favorites;
import 'search_screen_beach.dart';

class DestinationListScreen extends StatefulWidget {
  @override
  _DestinationListScreenState createState() => _DestinationListScreenState();
}

class _DestinationListScreenState extends State<DestinationListScreen> {
  final List<Map<String, String>> destinations = [
    {
      'name': 'Arugambay Beach',
      'image': 'images/arugambay_beach.jpg',
      'description': 'Arugambay Beach is famous for its amazing surfing spots and laid-back atmosphere. The beach is a haven for surfers from around the globe, boasting some of the best waves in the region. Visitors can enjoy the tranquil environment, golden sands, and clear waters. The area also offers exciting nightlife, unique local cuisine, and charming accommodations. Beyond surfing, Arugambay provides an escape into nature with nearby lagoons, wildlife, and cultural attractions, making it a versatile destination for all travelers.'
      
    },
    {
      'name': 'Jungle Beach',
      'image': 'images/jungle_beach.jpg',
      'description': 'Jungle Beach offers a secluded paradise surrounded by lush greenery and pristine sands. Located near Galle, this hidden gem provides a peaceful retreat away from the crowds. Visitors can enjoy crystal-clear waters perfect for swimming and snorkeling. The beach is flanked by dense forests, adding to its exotic charm. Whether you’re relaxing under the sun, exploring the jungle trails, or admiring the marine life, Jungle Beach ensures a memorable experience. It’s a perfect destination for nature lovers and adventurers.'
    },
    {
      'name': 'Marble Beach',
      'image': 'images/marbel_beach.jpg',
      'description': 'Marble Beach is known for its crystal-clear waters and scenic beauty that captivate every visitor. Situated in Trincomalee, this picturesque beach offers a serene atmosphere ideal for relaxation. The soft, white sands and calm waves make it a perfect spot for swimming and picnics. With breathtaking views of the surrounding landscape, it’s a great destination for photography enthusiasts. Whether you want to bask in the sun, enjoy a romantic sunset, or explore nearby attractions, Marble Beach has something for everyone.'
    },
    {
      'name': 'Mirissa Beach',
      'image': 'images/mirissa_beach.jpg',
      'description': 'Mirissa Beach is a hotspot for whale watching and golden sunsets, making it a must-visit destination. Located in the southern province, this beach is a paradise for both adventure seekers and those looking to unwind. Visitors can embark on boat tours to witness blue whales and dolphins in their natural habitat. The golden sands and turquoise waters are perfect for swimming, sunbathing, and beach games. As the sun sets, the vibrant nightlife and seafood restaurants bring the beach to life.'
    },
    {
      'name': 'Mount Lavinia Beach',
      'image': 'images/mount_lavinia_beach.jpg',
      'description': 'Mount Lavinia Beach is a popular destination with a rich history and vibrant nightlife. Located near Colombo, this beach offers a blend of cultural heritage and modern entertainment. It’s a favorite spot for locals and tourists alike, known for its lively atmosphere and stunning ocean views. Visitors can enjoy water sports, beachside dining, and live music. The historical Mount Lavinia Hotel adds to the beach’s charm, providing a glimpse into Sri Lanka’s colonial past. It’s an ideal spot for a day trip or evening getaway.'
    },
    {
      'name': 'Unawatuna Beach',
      'image': 'images/unawatuna_beach.jpg',
      'description': 'Unawatuna Beach is loved for its calm waters, ideal for swimming and snorkeling. Situated near Galle, this beach is a family-friendly destination with a relaxed vibe. The shallow waters and coral reefs attract snorkelers and marine life enthusiasts. Unawatuna is also known for its vibrant cafes, shops, and yoga retreats. Visitors can hike to the nearby Japanese Peace Pagoda for stunning views or explore the ancient temples. Whether you’re seeking adventure or tranquility, Unawatuna Beach offers a perfect blend of both.'
    },
  ];

  // List to track whether the heart icon is filled for each destination
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
            'Beaches in Sri Lanka',
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesListScreen(
          favoriteDestinations: favoriteDestinations, favorites: [],
        ),
                ),
              );
            },
          ),
        
          IconButton(
            icon: Icon(Icons.search,color: Colors.white ),
            onPressed: () {
              // Navigate to the SearchScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreenBeach(destinations: destinations),
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
                    builder: (context) => BeachDetailScreen(
                      name: destinations[index]['name']!,
                      image: destinations[index]['image']!,
                      description: destinations[index]['description']!,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 48, 47, 47), // Light ash color
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


class BeachDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String description;

  BeachDetailScreen({
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  _BeachDetailScreenState createState() => _BeachDetailScreenState();
}

class _BeachDetailScreenState extends State<BeachDetailScreen> {
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
            color: Colors.white, 
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 42, 126, 91),
        iconTheme: IconThemeData(color: Colors.white), 
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
            if (widget.name == "Arugambay Beach") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/arugambe_1.jpg');
                      },
                      child: Image.asset(
                        'images/arugambe_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/arugambay_2.jpg');
                      },
                      child: Image.asset(
                        'images/arugambay_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/arugambay_3.jpg');
                      },
                      child: Image.asset(
                        'images/arugambay_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/arugambay_4.jpg');
                      },
                      child: Image.asset(
                        'images/arugambay_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Jungle Beach") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jungle_1.jpg');
                      },
                      child: Image.asset(
                        'images/jungle_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jungle_2.jpg');
                      },
                      child: Image.asset(
                        'images/jungle_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jungle_3.jpg');
                      },
                      child: Image.asset(
                        'images/jungle_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/jungle_4.jpg');
                      },
                      child: Image.asset(
                        'images/jungle_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Marble Beach") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/marbel_1.jpg');
                      },
                      child: Image.asset(
                        'images/marbel_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/marbel_2.jpg');
                      },
                      child: Image.asset(
                        'images/marbel_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/marbel_3.jpg');
                      },
                      child: Image.asset(
                        'images/marbel_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/marbel_4.jpg');
                      },
                      child: Image.asset(
                        'images/marbel_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Mirissa Beach") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mirissa_1.jpg');
                      },
                      child: Image.asset(
                        'images/mirissa_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mirissa_2.jpg');
                      },
                      child: Image.asset(
                        'images/mirissa_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mirissa_3.jpg');
                      },
                      child: Image.asset(
                        'images/mirissa_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mirissa_4.jpg');
                      },
                      child: Image.asset(
                        'images/mirissa_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Mount Lavinia Beach") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mount_1.jpg');
                      },
                      child: Image.asset(
                        'images/mount_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mount_2.jpg');
                      },
                      child: Image.asset(
                        'images/mount_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/mount_3.jpg');
                      },
                      child: Image.asset(
                        'images/mount_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('mount_4.jpg');
                      },
                      child: Image.asset(
                        'images/mount_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Unawatuna Beach") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/unawatuna_1.jpg');
                      },
                      child: Image.asset(
                        'images/unawatuna_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/unawatuna_2.jpg');
                      },
                      child: Image.asset(
                        'images/unawatuna_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/unawatuna_3.jpg');
                      },
                      child: Image.asset(
                        'images/unawatuna_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/unawatuna_4.jpg');
                      },
                      child: Image.asset(
                        'images/unawatuna_4.jpg',
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