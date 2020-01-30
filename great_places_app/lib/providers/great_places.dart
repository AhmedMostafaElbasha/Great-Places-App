import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import 'package:great_places_app/helpers/database_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final savedPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: null,
    );
    _places.add(savedPlace);
    notifyListeners();
    DatabaseHelper.insert('user_places', {
      'id': savedPlace.id,
      'title': savedPlace.title,
      'image': savedPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final placesDataList = await DatabaseHelper.fetchData('user_places');

    _places = placesDataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null,
          ),
        )
        .toList();

    notifyListeners();    
  }
}
