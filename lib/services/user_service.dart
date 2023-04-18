import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';

import 'api_service.dart';

class UserService extends GetxService {
  // TODO: UserService
  final api = ApiService();
  static final CrudFunctionalities<User> crudFunctionalities =
      CrudFunctionalities<User>(
          modelName: 'user',
          pluralModelName: 'users',
          serializer: User.fromJson);

  User? user;

  Future<bool> checkToken(String token) async {
    try {
      final response =
          await api.get('/user', options: await api.getTokenAuthorization());

      if (response.statusCode == 200) {
        user = response.data;
        return true;
      }
      api.removeToken();
      return false;
    } catch (e) {
      api.removeToken();
      return false;
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
