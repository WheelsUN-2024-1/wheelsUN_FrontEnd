import 'package:flutter/material.dart';
import 'package:wheels_un/components/my_button.dart';
import 'package:wheels_un/components/my_form_textfield.dart';
import 'package:wheels_un/services/api_service.dart';
import 'package:wheels_un/graphql/graphql_client.dart';
import 'package:wheels_un/models/user_model.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _driverFormKey = GlobalKey<FormState>(); 
  final _passengerFormKey = GlobalKey<FormState>(); 

  final ccController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final postalCodeController = TextEditingController();
  final licenseExpDateController = TextEditingController();
  final passwordController = TextEditingController();

  bool isDriver = false; 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); 

  void signUserUp() async {
    final apiService = ApiService(getGraphQLClient());
    if (isDriver) {
      if (_driverFormKey.currentState!.validate()) {
        final driverModel = DriverInput(
          userIdNumber: int.parse(ccController.text), 
          userName: nameController.text, 
          userAge: int.parse(ageController.text), 
          userEmail: emailController.text, 
          userPhone: phoneController.text, 
          userAddress: addressController.text, 
          userCity: cityController.text, 
          userCountry: countryController.text, 
          userPostalCode: postalCodeController.text, 
          userLicenseExpirationDate: licenseExpDateController.text
        );
        final response = await apiService.createNewDriver(driverModel, passwordController.text);
        if (response.data == null) {
          _showErrorSnackBar(context, 'Register new driver failed'); // Show error message
        } else {
          // driver created (should show message and redirect to the login page)
          print('Register new driver successful');
        }
      }
    } else {
      if (_passengerFormKey.currentState!.validate()) {
        final passengerModel = PassengerInput(
          userIdNumber: int.parse(ccController.text), 
          userName: nameController.text, 
          userAge: int.parse(ageController.text), 
          userEmail: emailController.text, 
          userPhone: phoneController.text, 
          userAddress: addressController.text, 
          userCity: cityController.text, 
          userCountry: countryController.text, 
          userPostalCode: postalCodeController.text
        );
        final response = await apiService.createNewPassenger(passengerModel, passwordController.text);
        if (response.data == null) {
          _showErrorSnackBar(context, 'Register new passenger failed'); // Show error message
        } else {
          // passenger created (should show message and redirect to the login page)
          print('Register new passenger successful');
        }
      }
    }
  }

  void _showErrorSnackBar(BuildContext context, String errorMessage) {
    final snackBar = SnackBar(
      content: Text(errorMessage),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: isDriver
              ? Form(
                  key: _driverFormKey,
                  child: buildForm('Conductor', 'Registro de nuevo conductor'),
                )
              : Form(
                  key: _passengerFormKey,
                  child: buildForm('Pasajero', 'Registro de nuevo pasajero'),
                ),
        ),
      ),
    );
  }

  Widget buildForm(String type, String title) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Icon(
            Icons.person_add_alt_1,
            size: 100,
            color: Color(0xFF68BB92),
          ),
          const SizedBox(height: 50),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: ccController,
            hintText: 'Cedula de ciudadanía',
            obscureText: false,
            validator: validateCedula,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: nameController,
            hintText: 'Nombre Completo',
            obscureText: false,
            validator: validateFullName,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: ageController,
            hintText: 'Edad',
            obscureText: false,
            validator: validateAge,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: emailController,
            hintText: 'Email',
            obscureText: false,
            validator: validateEmail,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: phoneController,
            hintText: 'Celular',
            obscureText: false,
            validator: validatePhoneNumber,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: addressController,
            hintText: 'Dirección de residencia',
            obscureText: false,
            validator: validateAddress,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: cityController,
            hintText: 'Ciudad',
            obscureText: false,
            validator: validateCity,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: countryController,
            hintText: 'País',
            obscureText: false,
            validator: validateCountry,
          ),
          const SizedBox(height: 25),
          MyFormTextField(
            controller: postalCodeController,
            hintText: 'Código postal',
            obscureText: false,
            validator: validatePostalCode,
          ),
          if (isDriver) ...[
            const SizedBox(height: 25),
            MyFormTextField(
              controller: licenseExpDateController,
              hintText: 'Fecha de expiración permiso de conducción (AAAA-MM-DD)',
              obscureText: false,
              validator: validateLicenseExpDate,
            ),
          ],
          const SizedBox(height: 25),
          MyFormTextField(
            controller: passwordController,
            hintText: 'Contraseña',
            obscureText: true,
            validator: validatePassword,
          ),
          const SizedBox(height: 25),
          MyButton(
            onTap: signUserUp,
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isDriver = !isDriver; // Toggle between driver and passenger forms
              });
            },
            child: Text(isDriver ? '¿Quieres registrarte como pasajero? clic aquí' : '¿Quieres registrarte como conductor? clic aquí'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
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

String? validateFullName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your full name';
  }

  final nameRegex = RegExp(r'^[a-zA-Z\s]+$');
  if (!nameRegex.hasMatch(value)) {
    return 'Please enter a valid full name';
  }

  return null; // Return null if validation passes
}

String? validateAge(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your age';
  }

  final ageRegex = RegExp(r'^[0-9]+$');
  if (!ageRegex.hasMatch(value)) {
    return 'Age must contain only numbers';
  }

  final age = int.tryParse(value);
  if (age == null) {
    return 'Please enter a valid age';
  }

  if (age <= 16) {
    return 'Age must be greater than 16';
  }

  return null; // Return null if validation passes
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email';
  }

  return null; // Return null if validation passes
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your phone number';
  }

  final phoneNumberRegex = RegExp(r'^[0-9]{10}$');
  if (!phoneNumberRegex.hasMatch(value)) {
    return 'Please enter a valid phone number (exactly 10 digits)';
  }

  return null; // Return null if validation passes
}


String? validateAddress(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your home address';
  }

  return null; // Return null if validation passes
}

String? validateCity(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your city';
  }

  return null; // Return null if validation passes
}

String? validateCountry(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your country';
  }

  return null; // Return null if validation passes
}

String? validatePostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Postal Code';
  }

  return null; // Return null if validation passes
}

String? validateLicenseExpDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter the license expiration date';
  }

  final dateFormat = RegExp(r'^\d{4}-\d{2}-\d{2}$');
  if (!dateFormat.hasMatch(value)) {
    return 'Please enter a valid date format (YYYY-MM-DD)';
  }

  final parts = value.split('-');
  if (parts.length != 3) {
    return 'Please enter a valid date';
  }

  final year = int.tryParse(parts[0]);
  final month = int.tryParse(parts[1]);
  final day = int.tryParse(parts[2]);

  if (year == null || month == null || day == null) {
    return 'Please enter a valid date';
  }

  final currentDate = DateTime.now();
  final expirationDate = DateTime(year, month, day);
  if (expirationDate.isBefore(currentDate)) {
    return 'Not valid Expiration date';
  }

  return null; // Return null if validation passes
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }

  // You can add more validation rules here, such as requiring special characters, uppercase letters, etc.

  return null; // Return null if validation passes
}
