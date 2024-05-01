import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;

  final _storage = const FlutterSecureStorage();

  bool get isAuthenticated => _isAuthenticated;

  void checkAuthentication() async {
    String? token = await _storage.read(key: 'jwt_token');
    _isAuthenticated = token != null;
    notifyListeners();
  }

  void login(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() async {
    await _storage.delete(key: 'jwt_token');
    _isAuthenticated = false;
    notifyListeners();
  }
}
