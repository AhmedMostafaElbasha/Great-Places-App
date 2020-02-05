import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details';

  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context).settings.arguments as String;
    final place = Provider.of<GreatPlaces>(context).findById(placeId);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            place.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => MapScreen(
                    initialLocation: place.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text('View on Map'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
