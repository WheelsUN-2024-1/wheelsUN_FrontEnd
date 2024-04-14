import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_button.dart';
import 'package:wheels_un/components/my_form_textfield.dart';

class RegisterVehiclePage extends StatelessWidget {
  RegisterVehiclePage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>(); // Define GlobalKey for the Form

  final ccOwnerController = TextEditingController();
  final plateController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final cylinderController = TextEditingController();
  final yearController = TextEditingController();
  final seatingCapacityController = TextEditingController();

  void registerVehicle() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with sign-up logic
      print('Register new vehicle successful!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form( // Wrap input fields with Form widget
            key: _formKey, // Assign GlobalKey to the Form
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
                    controller: ccOwnerController,
                    hintText: 'Cedula de Ciudadanía del Dueño',
                    obscureText: false,
                    validator: validateCedula,
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
                    onTap: registerVehicle,
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

String? validateCedula(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Cedula';
  }

  final numericRegex = RegExp(r'^[0-9]+$');
  if (!numericRegex.hasMatch(value)) {
    return 'Cedula must contain only numbers';
  }

  final cedula = int.tryParse(value);
  if (cedula == null || cedula <= 0) {
    return 'Cedula must be a positive number';
  }

  return null;
}

String? validatePlate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the vehicle plate';
  }

  final plateRegex = RegExp(r'^[A-Z]{3}\d{3}$');
  if (!plateRegex.hasMatch(value)) {
    return 'Please enter a valid vehicle plate (e.g., AAA000)';
  }

  return null; // Return null if validation passes
}

String? validateBrand(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the brand';
  }
  return null; // Return null if validation passes
}

String? validateModel(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the model';
  }
  return null; // Return null if validation passes
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

  return null; // Return null if validation passes
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

  return null; // Return null if validation passes
}
