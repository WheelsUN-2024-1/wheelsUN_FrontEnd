// auth_model.dart
import 'package:wheels_un/models/user_model.dart';

class RegisterModel {
  String userId;
  String password;

  RegisterModel({required this.userId, required this.password});
}

class RegisterResponse {
  String token;
  String message;

  RegisterResponse({required this.token, required this.message});
}

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});
}

class PassengerLoginResponse {
  String token;
  String message;
  PassengerModel passenger;

  PassengerLoginResponse({required this.token, required this.message, required this.passenger});
}

class DriverLoginResponse {
  String token;
  String message;
  DriverModel driver;

  DriverLoginResponse({required this.token, required this.message, required this.driver});
}

class LogoutResponse {
  String message;

  LogoutResponse({required this.message});
}
