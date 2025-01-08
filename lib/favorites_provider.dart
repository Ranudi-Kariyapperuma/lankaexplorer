import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Map<String, String>> _favoriteDestinations = [];

  List<Map<String, String>> get favoriteDestinations => _favoriteDestinations;

  void addFavorite(Map<String, String> destination) {
    _favoriteDestinations.add(destination);
    notifyListeners();
  }

  void removeFavorite(Map<String, String> destination) {
    _favoriteDestinations.remove(destination);
    notifyListeners();
  }

  bool isFavorite(Map<String, String> destination) {
    return _favoriteDestinations.contains(destination);
  }
}
