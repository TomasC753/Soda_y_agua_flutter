import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/routes.dart';
import 'package:soda_y_agua_flutter/services/crud_functionalities.dart';
import 'package:soda_y_agua_flutter/services/route_service.dart';

import 'api_service.dart';

class UserService extends GetxService {
  // TODO: UserService
  User? user;

  final api = ApiService();
  static final CrudFunctionalities<User> crudFunctionalities =
      CrudFunctionalities<User>(
          modelName: 'user',
          pluralModelName: 'users',
          serializer: User.fromJson);

  Future<bool> checkToken() async {
    try {
      final response =
          await api.get('/myuser', options: await api.getTokenAuthorization());

      if (response.statusCode == 200) {
        user = User.fromJson(response.data);
        user!.token = await api.recoveryToken();
        Get.find<RouteService>().obtainRoutes();
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
        Get.find<RouteService>().obtainRoutes();
        Get.offAllNamed('/dashboard');
      }
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      var response =
          await api.get('logout', options: await api.getTokenAuthorization());
      if (response.statusCode == 200) {
        Get.offAllNamed('login');
      }
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
