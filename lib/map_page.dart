import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheels_un/select_creditCard.dart';
import 'package:wheels_un/services/location_service.dart';
import 'package:wheels_un/services/network_utils.dart';
import  'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:selectable_list/selectable_list.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  final String tripId;
  const MapPage({required this.tripId});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;

  static final LatLng university_center = const LatLng(4.6355555555556, -74.082777777778);
  static final LatLng waypoint = const LatLng(4.75, -74.082777777778);

  List<String> listPredictions = [];

  String? selectedPrediction;

  final TextEditingController _controller = TextEditingController();

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }

  void getCoordinates(String? address) async {
  if(address == null) return;
  try {
    List<Location> locations = await locationFromAddress(address);
    print(locations);
    Location location = locations.first;
    
    print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');
  } catch (e) {
    print('direccion');
    print(address);
    print('Error: ${e.toString()}');
  }
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
      debugShowCheckedModeBanner: false,

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
                controller: _controller,
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
                  return ListTile(
                    onTap: () {
                      setState(() {
                        selectedPrediction = listPredictions[index];
                        _controller.text = selectedPrediction!;  // Set the text of the TextFormField to the selected prediction.
                        listPredictions = [];  // Clear the list of predictions.
                        getCoordinates(selectedPrediction);
                      });
                    },
                    title: Text(listPredictions[index]),  
                );
                }),
            ),
           

            TextButton(
              child: Text('Navigate'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectCreditCard(selectedPrediction: selectedPrediction!, tripId: widget.tripId)),
                );
              },
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