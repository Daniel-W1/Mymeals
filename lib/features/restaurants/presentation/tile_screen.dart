import 'package:flutter/material.dart';
import '../domain/restaurant.dart';

class RestaurantTile extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantTile({required this.restaurant});

  @override
  _RestaurantTileState createState() => _RestaurantTileState();
}

class _RestaurantTileState extends State<RestaurantTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: const Color.fromARGB(255, 241, 238, 238)),
      ),
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
      child: ExpansionTile(
        title: Text(
          widget.restaurant.name,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Rating: ${widget.restaurant.rating.toStringAsFixed(1)} - City: ${widget.restaurant.city}',
          style: TextStyle(fontSize: 14.0),
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _expanded = expanded;
          });
        },
        trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        backgroundColor: Colors.grey[200],
        children: _expanded ? _buildExpandedContent() : [],
      ),
    );
  }

  List<Widget> _buildExpandedContent() {
    return [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.restaurant.imageUrl),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Address:',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4.0),
                Flexible(
                  child: Text(
                    widget.restaurant.address,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Country:',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4.0),
                Flexible(
                  child: Text(
                    widget.restaurant.country,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Text(
                  'Website:',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4.0),
                Flexible(
                  child: Text(
                    widget.restaurant.webUrl,
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
