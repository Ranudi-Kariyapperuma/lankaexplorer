import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  void _search() {
    String searchText = _searchController.text;
    if (searchText.isNotEmpty) {
      // Pass the search text back to the home screen
      Navigator.pop(context, searchText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Enter search term...",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _search,
              child: const Text("Search"),
            ),
          ],
        ),
      ),
    );
  }
}
