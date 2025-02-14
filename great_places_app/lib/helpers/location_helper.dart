import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_MAPS_API_KEY = 'AIzaSyDz7P-_dwZXeuRMtGQNVAo4bkuWZM1sQDg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$GOOGLE_MAPS_API_KEY';
  }

  static Future<String> getPlaceAddress(double latitude, double langitude) async {
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$langitude&key=$GOOGLE_MAPS_API_KEY';
    final response = await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
