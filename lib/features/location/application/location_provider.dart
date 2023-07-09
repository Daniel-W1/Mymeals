import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_meals/core/services/location_service.dart';
import 'package:nominatim_geocoding/nominatim_geocoding.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentLocation;

  Position? get currentLocation => _currentLocation;

  Future<void> syncLocation(BuildContext context) async {
    _currentLocation = await determinePosition(context);
    notifyListeners();
  }

  // convert location to address
  convertLocation(latitude, longtitude) async {
    final coordinates =
        new Coordinate(latitude: latitude, longitude: longtitude);
    Geocoding geocoding =
        await NominatimGeocoding.to.reverseGeoCoding(coordinates);

    return geocoding;
  }
}
