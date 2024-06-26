import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_button.dart';
import 'package:wheels_un/components/my_form_textfield.dart';
import 'package:wheels_un/globalVariables/user_data.dart';
import 'package:wheels_un/pages/view_vehicles_page.dart';
import 'package:wheels_un/services/api_service.dart';
import 'package:wheels_un/graphql/graphql_client.dart';
import 'package:wheels_un/models/vehicle_model.dart';

class RegisterVehiclePage extends StatelessWidget {
  RegisterVehiclePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final plateController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final cylinderController = TextEditingController();
  final yearController = TextEditingController();
  final seatingCapacityController = TextEditingController();

  void registerVehicle(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final apiService = ApiService(getGraphQLClient());
      final vehicleModel = VehicleInput(
        vehicleBrand: brandController.text,
        vehicleCylinder: cylinderController.text,
        vehicleModel: modelController.text,
        vehicleOwnerId: appIdNumber,
        vehiclePlate: plateController.text,
        vehicleSeatingCapacity: int.parse(seatingCapacityController.text),
        vehicleYear: int.parse(yearController.text),
      );

      final response = await apiService.createNewVehicle(vehicleModel);
      if (response.data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to create vehicle. Please try again.'),
          ),
        );
        print('Register new vehicle failed');
      } else {
        // Vehicle created successfully, navigate to previous page or do other actions
        print('Register new vehicle successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ViewVehiclesPage()),
        );
      }
      //print(response.data);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.car_rental,
                    size: 100,
                    color: Color(0xFF68BB92),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    'Registro de Nuevo Vehículo',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  MyFormTextField(
                    controller: plateController,
                    hintText: 'Placa del Vehículo (AAA000)',
                    obscureText: false,
                    validator: validatePlate,
                  ),
                  const SizedBox(height: 25),
                  MyFormTextField(
                    controller: brandController,
                    hintText: 'Marca',
                    obscureText: false,
                    validator: validateBrand,
                  ),
                  const SizedBox(height: 25),
                  MyFormTextField(
                    controller: modelController,
                    hintText: 'Modelo',
                    obscureText: false,
                    validator: validateModel,
                  ),
                  const SizedBox(height: 25),
                  MyFormTextField(
                    controller: cylinderController,
                    hintText: 'Cilindraje del Vehículo (sí aplica)',
                    obscureText: false,
                  ),
                  const SizedBox(height: 25),
                  MyFormTextField(
                    controller: yearController,
                    hintText: 'Año del Vehículo',
                    obscureText: false,
                    validator: validateYear,
                  ),
                  const SizedBox(height: 25),
                  MyFormTextField(
                    controller: seatingCapacityController,
                    hintText: 'Cantidad Máxima de Pasajeros',
                    obscureText: false,
                    validator: validateSeatingCapacity,
                  ),
                  
                  const SizedBox(height: 10),
                  MyButton(
                    onTap: () => registerVehicle(context),
                    text: "Add Vehicle",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RegisterVehiclePage(),
  ));
}

String? validatePlate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the vehicle plate';
  }

  final plateRegex = RegExp(r'^[A-Z]{3}\d{3}$');
  if (!plateRegex.hasMatch(value)) {
    return 'Please enter a valid vehicle plate (e.g., AAA000)';
  }

  return null;
}

String? validateBrand(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the brand';
  }
  return null;
}

String? validateModel(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the model';
  }
  return null;
}

String? validateYear(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the vehicle year';
  }

  final numericRegex = RegExp(r'^[0-9]+$');
  if (!numericRegex.hasMatch(value)) {
    return 'Please enter a valid year (positive integer)';
  }

  final year = int.tryParse(value);
  if (year == null || year <= 0) {
    return 'Please enter a valid year (positive integer)';
  }

  return null;
}

String? validateSeatingCapacity(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the vehicle seating capacity';
  }

  final numericRegex = RegExp(r'^[0-9]+$');
  if (!numericRegex.hasMatch(value)) {
    return 'Please enter a valid seating capacity';
  }

  final year = int.tryParse(value);
  if (year == null || year <= 0) {
    return 'Please enter a valid seating capacity';
  }

  return null;
}
