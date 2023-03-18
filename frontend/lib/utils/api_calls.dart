import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  final String url = "http://10.0.89.152:8080";

  post(String endpoint, String? token, body) async {
    Map<String, String> header = {
      'content-type': 'application/json',
      (token != null) ? 'Authentication': 'Bearer $token' : ""
    };
    final resp = await http.post(
      Uri.parse(url + endpoint),
      headers: header,
      body: body
    );
    log(resp.toString());
    return resp;
  }

  get(String endpoint, Map<String, String>? header) async {
    final resp = await http.get(
        Uri.parse(url + endpoint),
        headers: header
    );

    return resp;
  }


  login(String email, String password) async {
    Map<String, String> body = {
      "email": email,
      "password": password
    };
    log(body.toString());
    final resp = await post("/auth/login", null, json.encode(body));

    if (resp.ok) {
      const storage = FlutterSecureStorage();

      storage.write(key: "token", value: resp.token);
      storage.write(key: "refresh", value: resp.refresh);

      final userData = Jwt.parseJwt(resp.token);
      final UserModel user = UserModel(userData['id'], userData['name'], email);
      UserService().storeUser(user);
      return true;
    } else {
      return false;
    }
  }
}