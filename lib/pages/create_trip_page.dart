import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:wheels_un/components/my_display_textfield.dart';
import 'package:wheels_un/components/my_form_textfield.dart';
import 'package:wheels_un/components/my_button.dart';
import 'package:wheels_un/globalVariables/user_data.dart';
import 'package:wheels_un/graphql/graphql_client.dart';
import 'package:wheels_un/pages/home_page.dart';
import 'package:wheels_un/services/api_service.dart';
import 'package:wheels_un/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> plates = [];
String? tripPlate;

class CreateTripPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final String startingPoint;
  final String endingPoint;
  CreateTripPage(
      {Key? key, required this.startingPoint, required this.endingPoint})
      : super(key: key);

  final priceController = TextEditingController();

  Future<bool> createTrip(
      String start, String end, String? vehicle, int? price) async {
    if (_formKey.currentState!.validate()) {
      print("aca");
      final apiService = ApiService(getGraphQLClientTrip());
      final response =
          await apiService.createTripService(start, end, vehicle, price);
      print(response);
      if (response.data != null) {
        // Asumimos que response.isSuccessful es un campo que indica éxito
        return true;
      }
    }
    return false;
  }

  Future<void> getVehicles(BuildContext context) async {
    final apiService = ApiService(getGraphQLClient());
    final response = await apiService.vehicleById(appIdNumber);
    if (response.hasException) {
      throw Exception(response.exception.toString());
    } else {
      print("Get Vehicles successful");
      List<dynamic> responseData = response.data?['vehicleById'];
      plates = responseData.map((vehicleData) {
        return vehicleData['vehiclePlate'] as String;
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    //-----debug------
    appIdNumber = 666;
    //----------------
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Create Trip'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: const Color(0xFF68BB92),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder<void>(
          future: getVehicles(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  // Starting Point
                  MyReadOnlyField(
                      text: startingPoint, hintText: "Starting Point"),
                  const SizedBox(height: 20),
                  // Ending Point
                  MyReadOnlyField(text: endingPoint, hintText: "Ending Point"),
                  const SizedBox(height: 20),
                  // Dropdown Button
                  DropdownButtonFormField<String>(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    decoration: InputDecoration(
                      hintText: 'Elige un vehículo',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                    ),
                    value: null, // Initially no value selected
                    onChanged: (value) {
                      tripPlate = value;
                    },
                    items: plates.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  // Price
                  Form(
                    key: _formKey,
                    child: MyFormTextField(
                      hintText: "Precio (sin puntos ni comas)",
                      controller: priceController,
                      obscureText: false,
                      validator: validatePrice,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Create Trip Button
                  Center(
                    child: MyButton(
                      text: "Crear Viaje",
                      onTap: () async {
                        bool success = await createTrip(
                            startingPoint,
                            endingPoint,
                            tripPlate,
                            int.tryParse(priceController.text));
                        if (success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage()), // Asumiendo que NewScreen es tu nueva pantalla
                          );
                        } else {
                          // Opcional: Muestra algún mensaje de error si la creación del viaje falla
                          print("Failed to create trip");
                        }
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

String? validatePrice(String? value) {
  if (value == null || value.isEmpty) {
    return 'Price is required';
  }
  final double? price = double.tryParse(value);
  if (price == null || price <= 0) {
    return 'Please enter a valid price';
  }

  return null; // Returning null means the input is valid
}
