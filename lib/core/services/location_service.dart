import 'package:geolocator/geolocator.dart';

Future<Position?> determinePosition() async {
  LocationPermission permission;
  permission = await Geolocator.checkPermission();
  var check = await Geolocator.isLocationServiceEnabled();
  print('we are here asking permissions');

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Not Available');
    }
  } else if (!check) {
    throw Exception('Error');
  }
  var result = await Geolocator.getCurrentPosition();
  print(result);
  return result;
}
