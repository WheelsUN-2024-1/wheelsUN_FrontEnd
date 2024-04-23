import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheels_un/globalVariables/user_data.dart';
import 'package:wheels_un/models/Trip.dart';
import 'package:wheels_un/pages/create_trip_page.dart';
import 'package:wheels_un/select_creditCard.dart';
import 'package:wheels_un/services/location_service.dart';
import 'package:wheels_un/services/network_utils.dart';
import 'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'package:selectable_list/selectable_list.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  final String tripId;
  final String startingPoint;
  final String endingPoint;
  const MapPage(
      {Key? key,
      required this.tripId,
      required this.startingPoint,
      required this.endingPoint})
      : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

bool switchOrigin = false;

class _MapPageState extends State<MapPage> {
  LatLng? starting_center;
  LatLng? ending_center;
  Marker? _kHomeMarker;

  LatLng? waypoint;
  String? startingPoint;
  String? endingPoint;

  @override
  void initState() {
    super.initState();
    startingPoint = widget.startingPoint;
    endingPoint = widget.endingPoint;
  }

  late GoogleMapController mapController;

  List<Prediction> listPredictions = [];
  String? selectedPrediction;
  String? selectedPlaceId;

  final TextEditingController _controller = TextEditingController();
  final TextEditingController dummyController = TextEditingController();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<LatLng> getCoordinates(String? address) async {
    final String ap_url = AG_URL + '/trip';
    String graphQLQuery =
        'query{ getCoordinates(placeId: "$address"){lat lng}}';
    try {
      print(graphQLQuery);
      var url = Uri.parse(ap_url);
      var response = await http.post(url,
          headers: {"Content-type": "application/json"},
          body: json.encode({'query': graphQLQuery}));
      final data = jsonDecode(response.body);
      print("datos");
      print(data["data"]["getCoordinates"]["lat"]);
      return LatLng(data["data"]["getCoordinates"]["lat"],
          data["data"]["getCoordinates"]["lng"]);
    } catch (e) {
      print(e);
      throw Exception("Fallo la conexion");
    }
  }

  void placeAutocomplete(String query) async {
    listPredictions = [];
    final String ap_url = AG_URL + '/trip';
    String graphQLQuery =
        'query {autoComplete(query: "$query"){description placeId}}';
    try {
      print(ap_url);
      print(graphQLQuery);
      var url = Uri.parse(ap_url);
      var response = await http.post(url,
          headers: {"Content-type": "application/json"},
          body: json.encode({'query': graphQLQuery}));
      final data = jsonDecode(response.body);

      setState(() {
        // This will notify Flutter to redraw the widget
        listPredictions.clear(); // Clearing the old predictions
        for (var item in data["data"]["autoComplete"]) {
          listPredictions.add(Prediction(item["description"], item["placeId"]));
        }
      });

      print(listPredictions.length);
      print(listPredictions[0]);
    } catch (e) {
      print(e);
      throw Exception("Fallo la conexion");
    }
  }

  @override
  Widget build(BuildContext context) {
    //debug
    //appIsDriver = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WheelsUN'),
          backgroundColor: Colors.green[700],
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Icon(
                      switchOrigin ? Icons.circle_outlined : Icons.location_on,
                      color: switchOrigin ? Colors.black : Colors.red[700],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: TextFormField(
                        //TEXT BOX 1
                        readOnly: true,
                        controller: dummyController,
                        onChanged: (value) {
                          placeAutocomplete(value);
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: switchOrigin
                              ? "Sede Bogotá - Universidad Nacional de Colombia (Origen)"
                              : "Sede Bogotá - Universidad Nacional de Colombia (Destino)",
                          prefixIcon: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            //Middle row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    // Swap points
                    setState(() {
                      switchOrigin = !switchOrigin;
                    });
                  },
                  icon: Icon(Icons.swap_vert_circle_outlined),
                ),
              ],
            ),
            //End middle row
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                Icon(
                  switchOrigin ? Icons.location_on : Icons.circle_outlined,
                  color: switchOrigin ? Colors.red[700] : Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                Expanded(
                  child: TextFormField(
                    //TEXT BOX 2
                    controller: _controller,
                    onChanged: (value) {
                      placeAutocomplete(value);
                    },
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: switchOrigin
                          ? "¿A dónde vas?"
                          : "¿Dónde te encuentras?",
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    onTap: () async {
                      selectedPrediction = listPredictions[index].description;
                      selectedPlaceId = listPredictions[index].placeId;
                      _controller.text = selectedPrediction!;
                      listPredictions = [];
                      waypoint = await getCoordinates(selectedPlaceId);
                      setState(() {
                        _kHomeMarker = Marker(
                          markerId: MarkerId('Home'),
                          infoWindow: InfoWindow(title: 'Punto de recogida'),
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                          position: waypoint!,
                        );
                      });
                    },
                    title: Text(listPredictions[index].description),
                  );
                },
              ),
            ),
            TextButton(
              child: Text('Navigate'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectCreditCard(
                          selectedPrediction: selectedPrediction!,
                          tripId: widget.tripId)),
                );
              },
            ),
            if(appIsDriver)...[
              const SizedBox(width: 50),
              TextButton(
                child: Text('Crear Viaje'),
                onPressed: (){
                  //router to createTrip page
                  Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => switchOrigin ? CreateTripPage(startingPoint: "Sede Bogotá - Universidad Nacional de Colombia", endingPoint: _controller.text) : CreateTripPage(startingPoint: _controller.text, endingPoint: "Sede Bogotá - Universidad Nacional de Colombia")),
                            );
                },
              ),
            ],
            Expanded(
              child: GoogleMap(
                markers: _kHomeMarker != null ? {_kHomeMarker!} : {},
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(4.60971, -74.08175),
                  zoom: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
