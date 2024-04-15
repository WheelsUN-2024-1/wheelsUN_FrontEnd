// auth_model.dart

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

class LoginResponse {
  String token;
  String message;

  LoginResponse({required this.token, required this.message});
}

class LoginResponseWithUserInfo extends LoginResponse {
  dynamic user; // This should be replaced with the actual type of user (Driver or Passenger)

  LoginResponseWithUserInfo({required super.token, required super.message, required this.user});
}

class LogoutResponse {
  String message;

  LogoutResponse({required this.message});
}
