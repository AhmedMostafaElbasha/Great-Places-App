import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';
import './place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, dataSnapshot) => dataSnapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'There are no places. press',
                          style: TextStyle(fontSize: 12),
                          maxLines: 3,
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddPlaceScreen.routeName);
                          },
                        ),
                        Text(
                          'button to add new place.',
                          style: TextStyle(fontSize: 12),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                builder: (context, greatPlaces, child) => greatPlaces
                            .places.length <=
                        0
                    ? child
                    : Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: ListView.builder(
                          itemCount: greatPlaces.places.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 6,
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.places[index].image),
                              ),
                              title: Text(greatPlaces.places[index].title),
                              subtitle: Text(
                                  greatPlaces.places[index].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailsScreen.routeName,
                                  arguments: greatPlaces.places[index].id,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
