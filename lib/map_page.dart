import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheels_un/services/location_service.dart';
import 'package:wheels_un/services/network_utils.dart';
import  'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;

  static final LatLng university_center = const LatLng(4.6355555555556, -74.082777777778);
  static final LatLng waypoint = const LatLng(4.75, -74.082777777778);

  List<String> listPredictions = [];

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  void placeAutocomplete(String query) async {
    listPredictions = [];
    final String ap_url = AG_URL+'/trip';
    String graphQLQuery = 
    'query {autoComplete(query: "$query"){description}}';
    try { 
      print(ap_url);
      print(graphQLQuery);
      var url = Uri.parse(ap_url);
      var response = await http.post(url,
            headers: {"Content-type": "application/json"},
            body: json.encode({'query': graphQLQuery}));
        final data = jsonDecode(response.body);
        
        setState(() {  // This will notify Flutter to redraw the widget
          listPredictions.clear();  // Clearing the old predictions
          for (var item in data["data"]["autoComplete"]) {
            listPredictions.add(item["description"]);
          } 
    });

        print(listPredictions.length);
        print(listPredictions[0]);
    } catch (e){
        print(e);
        throw Exception("Fallo la conexion");
    } 
  }


  static final Marker _kUniversityMarker = Marker(
    markerId: MarkerId('University'),
    infoWindow: InfoWindow(title:'Universidad Nacional'),
    icon: BitmapDescriptor.defaultMarker,
    position: university_center
  );

  static final Marker _kHomeMarker = Marker(
    markerId: MarkerId('Home'),
    infoWindow: InfoWindow(title:'Punto de recogida'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: waypoint
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WheelsUN'),
          backgroundColor: Colors.green[700],
        ),
        body: 
        
        Column(
          children: [
            Text("Destino: Universidad Nacional de Colombia"),
            Row(children: [
              Expanded(child: TextFormField(
                onChanged: (value) {
                  placeAutocomplete(value);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: "Donde te encuentras?",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),)
                ),
              )),
              IconButton(onPressed: () {
                
              }, icon: Icon(Icons.search))
            
            ],),
            const Divider(
              height: 4,
              thickness: 4,
            ),
            Container(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: listPredictions.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 50,
                    height: 50,
                    child: Text(listPredictions[index]),  
                );
                }),
            ),
            Expanded(
              child: GoogleMap(
                markers: {_kUniversityMarker, _kHomeMarker},
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: university_center,
                  zoom: 12.0,
                  ),
                  ),
            ),
          ],
        ),
            )
    );
  }
}