import 'package:get/get.dart';

class ServiceResponse<T> {
  late Rx<T> data;
  RxStatus status;
  Future<T> Function() getterFunction;

  RxString errorMessage = ''.obs;

  ServiceResponse(
      {required this.data, required this.status, required this.getterFunction});

  void getData() async {
    status.isLoading;
    try {
      T dataObtained = await getterFunction();
      data.value = dataObtained;
      if (dataObtained != null || dataObtained != List.empty()) {
        status.isSuccess;
      } else {
        status.isEmpty;
      }
    } catch (e) {
      status.isError;
      errorMessage.value = e.toString();
    }
  }
}
