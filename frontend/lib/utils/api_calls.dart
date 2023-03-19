import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/product_service.dart';
import 'package:frontend/services/user_service.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiCalls {
  final String url = "http://130.61.177.244:8080";
  final storage = const FlutterSecureStorage();
  post(String endpoint, String? token, body) async {
    Map<String, String> header = {
      'content-type': 'application/json',
    };

    if (token != null) {
      header['Authorization'] = "Bearer $token";
    }

    // log(header.toString());

    final resp = await http.post(
      Uri.parse(url + endpoint),
      headers: header,
      body: body
    );
    return resp;
  }

  get(String endpoint, String? token) async {

    Map<String, String> header = {
      'content-type': 'application/json',
    };

    if (token != null) {
      header['Authorization'] = "Bearer $token";
    }

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
    log(resp.toString());
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

  getGroceryLists() async {
    final token = await storage.read(key: "token");
    log(token.toString());
    final resp = await get('/list/meta', token);
    return json.decode(resp.body);
  }

  saveGroceryLists(List<ProductModel> products) async {
    late double price = 0.0;
    Map<String, dynamic> body = {

    };

    List<int> ids = [];

    for (var element in products) {
      ids.add(element.id);
      price += element.price;
    }

    body['products'] = ids;
    body['price'] = price;
    body['store'] = products[0].storeName;
    List<String> list = ProductService().getGroceryList();
    String query = list.join(", ");
    body['query'] = query;

    // log(body.toString());
    log(json.encode(body));
    final token = await storage.read(key: "token");

    final resp = await post('/list/save', token, json.encode(body));

    return resp.body;
  }
}