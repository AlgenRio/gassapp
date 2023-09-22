import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/navbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mainpage extends StatefulWidget {
  final String username;

  const Mainpage({Key? key, required this.username}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(username: '',),
        appBar: AppBar(
          backgroundColor: Color(0xffB81736),
          title: Text('Nearby foodie app'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            )
          ],
        ),
        body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: sourceLocation,
              zoom: 14.5,
            ),
            markers: {
              const Marker(
                markerId: MarkerId("source"),
                position: sourceLocation,
              ),
              const Marker(
                markerId: MarkerId("destination"),
                position: sourceLocation,
              )
            }));
  }
}
