import 'package:flutter/material.dart';
import 'package:wheels_un/graphql/graphql_client.dart';
import 'package:wheels_un/pages/register_vehicle.dart';
import 'package:wheels_un/pages/profile_page.dart';
import 'package:wheels_un/globalVariables/user_data.dart';
import 'package:wheels_un/models/vehicle_model.dart';
import 'package:wheels_un/services/api_service.dart';

List<VehicleModel> vehicles = [];

class ViewVehiclesPage extends StatelessWidget {
  ViewVehiclesPage();

  @override
  Widget build(BuildContext context) {
    //#######this is for debug############
    appIdNumber = 666;
    appIsDriver = true;
    //####################################

    return FutureBuilder<void>(
      future: getVehicles(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the data, display a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If an error occurs, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // If the data is successfully fetched, build the UI with the vehicles
          return buildViewWithVehicles(context);
        }
      },
    );
  }

  Future<void> getVehicles(BuildContext context) async {
    final apiService = ApiService(getGraphQLClient());
    final response = await apiService.vehicleById(appIdNumber);
    if (response.hasException) {
      throw Exception(response.exception.toString());
    } else {
      print("Get Vehicles successful");
      List<dynamic> responseData = response.data?['vehicleById'];
      vehicles = responseData.map((vehicleData) {
        return VehicleModel(
          vehiclePlate: vehicleData['vehiclePlate'],
          vehicleModel: vehicleData['vehicleModel'],
          vehicleYear: vehicleData['vehicleYear'],
          vehicleBrand: vehicleData['vehicleBrand'],
          //this are just filler data
          vehicleCylinder: "",
          vehicleOwnerId: 0,
          vehicleSeatingCapacity: 0,
        );
      }).toList();
    }
  }

  Widget buildViewWithVehicles(BuildContext context) {
    //print("my vehicles:");
    //print(vehicles.length);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Mis Vehículos'),
        backgroundColor: const Color(0xFF68BB92),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 20),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Placa: ${vehicles[index].vehiclePlate}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Modelo: ${vehicles[index].vehicleBrand} ${vehicles[index].vehicleModel}'),
                                SizedBox(height: 10),
                                Text('Año: ${vehicles[index].vehicleYear}'),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () async{
                              //delete functionality
                              final apiService = ApiService(getGraphQLClient());
                              final response = await apiService.deleteVehicle(vehicles[index].vehiclePlate);
                              if (response.hasException) {
                                print("Delete Vehicle error: $response");
                                throw Exception(response.exception.toString());
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => ViewVehiclesPage()),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //add vehicle page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RegisterVehiclePage()),
          );
        },
        label: Text('Add Vehicle'),
        foregroundColor: Colors.black,
        icon: Icon(Icons.add),
        backgroundColor: const Color(0xFF68BB92),
      ),
    );
  }
}
