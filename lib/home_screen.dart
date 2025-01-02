import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  final List<String> imgList = [
    'images/sigiriya.jpg',
    'images/ella.jpg',
    'images/galle.jpg',
    'images/nuwaraeliya.jpg',
  ];

  final List<Map<String, String>> places = [
    {
      "name": "Yala National Park",
      "description": "Yala National Park is a huge area of forest, grassland and lagoons bordering the Indian Ocean, in southeast Sri Lanka",
      "image": "images/yala.jpg",
    },
    {
      "name": "Kandy",
      "description": "Known for the Temple of the Tooth, a UNESCO World Heritage Site, and its beautiful Kandy Lake and lush botanical gardens.",
      "image": "images/kandy.jpeg",
    },
    {
      "name": "Sigiriya",
      "description": "An ancient rock fortress and palace, a UNESCO World Heritage Site, known for its historical ruins and stunning panoramic views.",
      "image": "images/sigiriya.jpg",
    },
    {
      "name": "Nuwara Eliya",
      "description": "Often called 'Little England,' it’s famous for its cool climate, tea plantations, and scenic landscapes.",
      "image": "images/nuwaraeliya.jpg",
    },
    {
      "name": "Ella",
      "description": "A picturesque town known for Ella Rock, Ravana Falls, and stunning views of the island’s greenery.",
      "image": "images/ella.jpg",
    },
  ];

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(130),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1B4D3E),
                Color(0xFF74B49B),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative circle in background
              Positioned(
                right: -30,
                top: -20,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              // Main content
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Added padding to move the logo slightly to the right
                        Padding(
                          padding: const EdgeInsets.only(left: 30), // Move logo right
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'images/logo.png',
                              height: 35,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20), // Increased spacing for balance
                        const Text(
                          "LankaExplorer",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 3,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                      "Get the Best Travel Experience",
                       style: TextStyle(
                       fontSize: 16,
                       color: Colors.white,
                       fontStyle: FontStyle.italic,
                       letterSpacing: 0.5,
                         ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Sliding Banner
            CarouselSlider(
              options: CarouselOptions(
                height: 220.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
              items: imgList.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search destinations, trips...",
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryCard(icon: Icons.beach_access, label: "Beaches"),
                  CategoryCard(icon: Icons.park, label: "Nature Parks"),
                  CategoryCard(icon: Icons.history, label: "Historical Sites"),
                  CategoryCard(icon: Icons.directions_bike, label: "City Tours"),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Top Travel Places
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                "Top Travel Places",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            const SizedBox(height: 10),
           ListView.builder(
           shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
             itemCount: places.length,
              itemBuilder: (context, index) {
           return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Card(
              elevation: 5,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              places[index]["image"]!,  // Use the dynamic image here
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(places[index]["name"]!),
          subtitle: Text(places[index]["description"]!),
          trailing: const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
      ),
    );
  },
),

          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
         BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
         BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Reviews'),
         BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, size: 35, color: Colors.teal),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
