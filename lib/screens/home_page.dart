import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:ios_task/screens/users_lists.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller){
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(null),
          position: LatLng(23.259933, 77.412613),
        )
      );
    });
  }

  final String apiUrl = "http://aryu.co.in/tracking/viewreport";
  Future<List<dynamic>> fetchUsers() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body)['location'];
  }

  Double _lat(dynamic user) {
    return user['lat'];
  }

  Double _long(dynamic user) {
    return user['longg'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('iOS Task')
      ),
      body: Stack(children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(23.259933, 77.412613),
            zoom: 14.4746,
          ),
          markers: _markers,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(
            context, MaterialPageRoute(builder:(context)=>UsersLists()),
            );
          },
          child: Card(
            child: Container(
              height: 20.0,
              width: 200.0,
              decoration: BoxDecoration(color: Colors.purple),
              child: Center(
                child: Text(
                  'Click to see all users',
                  style: TextStyle(color: Colors.white),
                )
              ),
            ),
          ),
        )
      ],),
    );
  }
}
