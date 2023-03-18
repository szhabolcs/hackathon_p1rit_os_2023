import 'dart:developer';

import 'package:frontend/models/user_model.dart';

class UserService {
  static late UserModel _user;

  storeUser(UserModel user) {
    _user = user;
  }

  getUser() {
    return _user;
  }
}