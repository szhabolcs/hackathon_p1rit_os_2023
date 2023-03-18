import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/user_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  final String url = "http://130.61.177.244:8080";
  final storage = const FlutterSecureStorage();
  post(String endpoint, String? token, body) async {
    Map<String, String> header = {
      'content-type': 'application/json',
    };

    if (token != null) {
      header['Authentication'] = "Bearer $token";
    }

    final resp = await http.post(
      Uri.parse(url + endpoint),
      headers: header,
      body: body
    );
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
    final resp = await post("/auth/login", null, json.encode(body));
    if (json.decode(resp.body)['token'] != null) {

      storage.write(key: "token", value: json.decode(resp.body)['token']);
      storage.write(key: "refresh", value: json.decode(resp.body)['refresh']);
      final userData = Jwt.parseJwt(json.decode(resp.body)['token']);
      final UserModel user = UserModel(userData['user']['id'], userData['user']['name'], email);
      UserService().storeUser(user);
      return true;
    } else {
      return false;
    }
  }

  search(List<String> list) async {
    Map<String, List<String>> body = {
      "list": list
    };
    final resp = await post("/list/query", await storage.read(key: "token"), json.encode(body));

    return resp.body;
  }
}