import 'package:flutter_login/data/network/api_clients.dart';
import 'package:flutter_login/data/network/api_end_points.dart';
import 'package:flutter_login/models/auth_response.dart';

class AuthRepository {
  final ApiClient _apiClient;

  AuthRepository(this._apiClient);

  Future<AuthResponse> login(String email, String password) async {
    final response = await _apiClient.post(ApiEndPoints.localLogin, {
      'email': email,
      'password': password,
    });
    return AuthResponse.fromJson(response);
  }

  Future<AuthResponse> signUp(
    String name,
    String email,
    String password,
  ) async {
    final response = await _apiClient.post(ApiEndPoints.localSignUp, {
      'name': name,
      'email': email,
      'password': password,
    });
    return AuthResponse.fromJson(response);
  }
}
