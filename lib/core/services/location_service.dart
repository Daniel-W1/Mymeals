import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

Future<Position> determinePosition(BuildContext context) async {
  try {
    Position position = await Geolocator.getCurrentPosition();
    return position;
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      // Handle permission denied error
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Location Permission'),
          content: Text('Location permissions are denied.'),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                context.go('/');
              },
            ),
          ],
        ),
      );
    } else if (e.code == 'SERVICE_STATUS_ERROR') {
      // Handle location services disabled error
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Location Services'),
          content: Text('Location services are disabled.'),
          actions: [
            ElevatedButton(
              child: Text('Open Settings'),
              onPressed: () {
                Geolocator.openLocationSettings();
                context.go('/');
              },
            ),
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                context.go('/');
              },
            ),
          ],
        ),
      );
    } else {
      // Handle other errors
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.message ?? ""),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                context.go('/');
              },
            ),
          ],
        ),
      );
    }

    return Future.error('Location services are disabled.');
  }
}
