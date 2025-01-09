import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'favorites_list_screen.dart';
import 'search_screen_park.dart';

class DestinationListScreenPark extends StatefulWidget {
  @override
  _DestinationListScreenParkState createState() => _DestinationListScreenParkState();
}

class _DestinationListScreenParkState extends State<DestinationListScreenPark> {
  final List<Map<String, String>> destinations = [
    {
      'name': 'Horton Plains Nature Park',
      'image': 'images/horton_plains_nature_park.jpg',
      'description': 'Horton Plains Nature Park is one of Sri Lanka’s most scenic and unique parks. Located in the central highlands, it is known for its stunning landscapes, including cloud forests, rolling grasslands, and the famous World’s End cliff, which offers panoramic views. The park is also home to a variety of wildlife, such as sambar deer, leopards, and numerous bird species. Visitors can enjoy hiking, exploring waterfalls, and experiencing the tranquility of nature in this UNESCO World Heritage site.'
    },
    {
      'name': 'Kaudulla Nature Park',
      'image': 'images/kaudulla_nature_park.jpg',
      'description': 'Kaudulla Nature Park is located in the north-central region of Sri Lanka and is a haven for wildlife enthusiasts. The park is famous for its large population of elephants, especially during the dry season when they gather around the park’s reservoir. Besides elephants, the park is home to various species of birds, including migratory species, making it a great spot for bird watching. The park’s serene atmosphere and rich biodiversity provide an ideal environment for nature lovers and wildlife photographers.'
    },
    {
      'name': 'Lunugamvehera Nature Park',
      'image': 'images/lunugamvehera_nature_park.jpg',
      'description': 'Lunugamvehera Nature Park is situated in the southern part of Sri Lanka and is part of the Yala National Park complex. The park is a sanctuary for a wide variety of animals, including elephants, leopards, and crocodiles. The park is less crowded compared to other national parks, providing a peaceful environment for wildlife viewing. The Lunugamvehera reservoir adds to the park’s scenic beauty, and visitors can enjoy safaris while exploring its lush landscapes and diverse ecosystems.'
    },
    {
      'name': 'Udawalawa Nature Park',
      'image': 'images/udawalwa_nature_park.jpg',
      'description': 'Udawalawa Nature Park is located in the southwestern part of Sri Lanka, known for its open grasslands and large herds of elephants. The park is home to many species of wildlife, including water buffalo, monkeys, and a variety of bird species. Udawalawa is particularly popular for its elephant safaris, where visitors can witness these majestic animals in their natural habitat. The park’s tranquil atmosphere, combined with its rich biodiversity, makes it a great spot for nature lovers and adventure seekers alike.'
    },
    {
      'name': 'Yala Nature Park',
      'image': 'images/yala_nature_park.jpg',
      'description': 'Yala Nature Park is one of the most famous and oldest national parks in Sri Lanka, located in the southeastern part of the island. It is renowned for its rich biodiversity, including a large population of leopards, elephants, and crocodiles. Yala’s varied landscape, consisting of jungles, scrublands, and wetlands, makes it a perfect destination for safari enthusiasts. The park is also home to over 200 species of birds, making it a birdwatcher’s paradise. A visit to Yala promises an unforgettable wildlife experience surrounded by natural beauty.'
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
            'Nature Parks in Sri Lanka',
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
              fontSize: 24,
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
                  builder: (context) => SearchScreenPark(destinations: destinations),
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
                    builder: (context) => NatureDetailScreen(
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



class NatureDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String description;

  NatureDetailScreen({
    required this.name,
    required this.image,
    required this.description,
  });

  @override
  _NatureDetailScreenState createState() => _NatureDetailScreenState();
}

class _NatureDetailScreenState extends State<NatureDetailScreen> {
  bool isLiked = false; // Track the like status
  List<String> comments = []; // List to store the comments
  TextEditingController _commentController = TextEditingController(); 

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
            
            // Display additional images 
            if (widget.name == "Horton Plains Nature Park") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/horton_1.jpg');
                      },
                      child: Image.asset(
                        'images/horton_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/horton_2.jpg');
                      },
                      child: Image.asset(
                        'images/horton_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/horton_3.jpg');
                      },
                      child: Image.asset(
                        'images/horton_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/horton_4.jpg');
                      },
                      child: Image.asset(
                        'images/horton_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Kaudulla Nature Park") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kaudulla_1.jpg');
                      },
                      child: Image.asset(
                        'images/kaudulla_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kaudulla_2.jpg');
                      },
                      child: Image.asset(
                        'images/kaudulla_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kaudulla_3.jpg');
                      },
                      child: Image.asset(
                        'images/kaudulla_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/kaudulla_4.jpg');
                      },
                      child: Image.asset(
                        'images/kaudulla_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Lunugamvehera Nature Park") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Lunugamvehera_1.jpg');
                      },
                      child: Image.asset(
                        'images/Lunugamvehera_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Lunugamvehera_2.jpg');
                      },
                      child: Image.asset(
                        'images/Lunugamvehera_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Lunugamvehera_3.jpg');
                      },
                      child: Image.asset(
                        'images/Lunugamvehera_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/Lunugamvehera_4.jpg');
                      },
                      child: Image.asset(
                        'images/Lunugamvehera_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Udawalawa Nature Park") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/udawalawa_1.jpg');
                      },
                      child: Image.asset(
                        'images/udawalawa_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/udawalawa_2.jpg');
                      },
                      child: Image.asset(
                        'images/udawalawa_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/udawalawa_3.jpg');
                      },
                      child: Image.asset(
                        'images/udawalawa_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/udawalawa_4.jpg');
                      },
                      child: Image.asset(
                        'images/udawalawa_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (widget.name == "Yala Nature Park") ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Extra Images for Arugambay Beach
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/yala_1.jpg');
                      },
                      child: Image.asset(
                        'images/yala_1.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/yala_2.jpg');
                      },
                      child: Image.asset(
                        'images/yala_2.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/yala_3.jpg');
                      },
                      child: Image.asset(
                        'images/yala_3.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showLargeImage('images/yala_4.jpg');
                      },
                      child: Image.asset(
                        'images/yala_4.jpg',
                        width: 70,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            // if (widget.name == "Unawatuna Beach") ...[
            //   Padding(
            //     padding: const EdgeInsets.all(16.0),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         // Extra Images for Arugambay Beach
            //         GestureDetector(
            //           onTap: () {
            //             _showLargeImage('images/unawatuna_1.jpg');
            //           },
            //           child: Image.asset(
            //             'images/unawatuna_1.jpg',
            //             width: 70,
            //             height: 60,
            //           ),
            //         ),
            //         SizedBox(width: 10),
            //         GestureDetector(
            //           onTap: () {
            //             _showLargeImage('images/unawatuna_2.jpg');
            //           },
            //           child: Image.asset(
            //             'images/unawatuna_2.jpg',
            //             width: 70,
            //             height: 60,
            //           ),
            //         ),
            //         SizedBox(width: 10),
            //         GestureDetector(
            //           onTap: () {
            //             _showLargeImage('images/unawatuna_3.jpg');
            //           },
            //           child: Image.asset(
            //             'images/unawatuna_3.jpg',
            //             width: 70,
            //             height: 60,
            //           ),
            //         ),
            //         SizedBox(width: 10),
            //         GestureDetector(
            //           onTap: () {
            //             _showLargeImage('images/unawatuna_4.jpg');
            //           },
            //           child: Image.asset(
            //             'images/unawatuna_4.jpg',
            //             width: 70,
            //             height: 60,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ],
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
