import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';

import 'api_service.dart';

class UserService extends GetxService {
  // TODO: UserService
  late User user;
  final api = ApiService();
  static final CrudFunctionalities<User> crudFunctionalities =
      CrudFunctionalities<User>(
          modelName: 'user',
          pluralModelName: 'users',
          serializer: User.fromJson);

  Future<bool> checkToken() async {
    try {
      final response =
          await api.get('/user', options: await api.getTokenAuthorization());

      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
        user.token = await api.recoveryToken();
        return true;
      }
      api.removeToken();
      return false;
    } catch (e) {
      api.removeToken();
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      var response =
          await api.post('login', data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        api.saveToken(response.data['token']);
        user = User.fromJson(response.data);
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<User>?> getUsers() async {
    try {
      var response = await crudFunctionalities.getAll();
      if (response is List<User>) {
        return response;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Future<User?> getUserById(int id) async {
  //   var response = await crudFunctionalities.getById(id);
  //   if (response is User) {
  //     return response;
  //   }
  //   return null;
  // }
}
