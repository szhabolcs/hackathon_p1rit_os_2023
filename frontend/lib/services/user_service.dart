import 'package:frontend/models/user_model.dart';

class UserService {
  late UserModel _user;

  storeUser(UserModel user) {
    _user = user;
  }

  getUser() {
    return _user;
  }
}