import 'package:flutter/material.dart';
import 'package:wheels_un/pages/register_vehicle.dart';
import 'package:wheels_un/pages/profile_page.dart';
import 'package:wheels_un/globalVariables/user_data.dart';

class Vehicle {
  final String plate;
  final String model;
  final int year;

  Vehicle({
    required this.plate,
    required this.model,
    required this.year,
  });
}

List<Vehicle> vehicles = [
  Vehicle(plate: 'ABC123', model: 'Toyota Camry', year: 2020),
  Vehicle(plate: 'XYZ789', model: 'Honda Civic', year: 2018),
  Vehicle(plate: 'DEF456', model: 'Ford Mustang', year: 2019),
];

class ViewVehiclesPage extends StatelessWidget {
  //appIdNumber = 666;

  ViewVehiclesPage();

  @override
  Widget build(BuildContext context) {
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
                                  'Placa: ${vehicles[index].plate}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Modelo: ${vehicles[index].model}'),
                                SizedBox(height: 10),
                                Text('Año: ${vehicles[index].year}'),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              //delete functionality
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
