import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheels_un/models/Trip.dart';
import 'package:wheels_un/services/location_service.dart';
import 'package:wheels_un/services/network_utils.dart';
import  'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class ListTrips extends StatefulWidget {
  const ListTrips({super.key});

  @override
  State<ListTrips> createState() => _ListTripsState();
}

class _ListTripsState extends State<ListTrips> {


  List<Trip> listTrips = [];

  void fetchTrips() async {
    
    final String ap_url = AG_URL+'/trip';
    String graphQLQuery = 
    'query{allTrips{id startingPoint endingPoint}}';
    try { 
      print(ap_url);
      print(graphQLQuery);
      var url = Uri.parse(ap_url);
      var response = await http.post(url,
            headers: {"Content-type": "application/json"},
            body: json.encode({'query': graphQLQuery}));
        final data = jsonDecode(response.body);
        
        setState(() {  // This will notify Flutter to redraw the widget
          listTrips.clear();  // Clearing the old predictions
          for (var item in data["data"]["allTrips"]) {
            listTrips.add(Trip(item["id"], item["startingPoint"], item["endingPoint"]));
          } 
    });

        print(listTrips.length);
        print(listTrips[0]);
    } catch (e){
        print(e);
        throw Exception("Fallo la conexion");
    } 
  }

  
  @override
  Widget build(BuildContext context) {
    fetchTrips();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Viajes'),
          backgroundColor: Colors.green[700],
        ),
        body:
          Container(
              height: 600,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listTrips.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    height: 100,
                    child: Text('id: ${listTrips[index].id} \n inicio: ${listTrips[index].startingPoint} \n final: ${listTrips[index].endingPoint}' ),  
                );
                }),
            ),
        )
        );
  }

}