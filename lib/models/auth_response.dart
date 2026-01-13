class AuthResponse {
  final String? token;
  final String? error;

  AuthResponse({this.token, this.error});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(token: json['token'], error: json['error']);
  }

  bool get isSuccess => token != null;
}
