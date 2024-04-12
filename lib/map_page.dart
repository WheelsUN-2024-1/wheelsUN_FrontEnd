import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wheels_un/services/location_service.dart';
import 'package:wheels_un/services/network_utils.dart';
import  'package:flutter_google_places_web/flutter_google_places_web.dart';
import 'constants.dart';
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;

  static final LatLng university_center = const LatLng(4.6355555555556, -74.082777777778);
  static final LatLng waypoint = const LatLng(4.75, -74.082777777778);


  
  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
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
            Row(children: [
              Expanded(
                child: FlutterGooglePlacesWeb(
                apiKey: API_KEY,
                proxyURL: 'https://cors-anywhere.herokuapp.com/',
                components: 'country:co',
                required: false,
                ),
              )
            ],),
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