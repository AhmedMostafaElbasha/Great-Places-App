import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import 'package:great_places_app/helpers/database_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );

    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    final savedPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      image: pickedImage,
      location: updatedLocation,
    );

    _places.add(savedPlace);
    notifyListeners();

    DatabaseHelper.insert('user_places', {
      'id': savedPlace.id,
      'title': savedPlace.title,
      'image': savedPlace.image.path,
      'location_latitude': savedPlace.location.latitude,
      'location_langitude': savedPlace.location.longitude,
      'address': savedPlace.location.address,
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
            location: PlaceLocation(
              latitude: item['location_latitude'],
              longitude: item['location_langitude'],
              address: item['address'],
            ),
          ),
        )
        .toList();

    notifyListeners();
  }
}
