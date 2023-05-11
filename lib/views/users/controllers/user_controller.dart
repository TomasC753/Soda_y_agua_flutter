import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/User.dart';
import 'package:soda_y_agua_flutter/utils/service_response.dart';

class UsersController extends GetxController {
  //
  var isLoading = false.obs;

  ResponseList<User> users = ResponseList<User>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await User.crudFunctionalities.getAll(),
      data: <User>[],
      conditionsForSearch: (userr, query) =>
          userr.name.toLowerCase().contains(query));

  ResponseGeneric<User> user = ResponseGeneric<User>(
      status: Rxn(OperationStatus.empty),
      getterFunction: ({int? id}) async =>
          await User.crudFunctionalities.getById(id!),
      data: Rxn<User>());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    users.getData();
  }
}
