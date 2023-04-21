part of 'service_response.dart';

class ResponseGeneric<T> extends IServiceResponse<T> {
  Rx<T> data;

  ResponseGeneric(
      {required super.status,
      required super.getterFunction,
      required this.data});

  @override
  Future<void> getData() async {
    try {
      status.value = OperationStatus.loading;
      T dataObtained = await getterFunction();
      data.value = dataObtained;
      if (dataObtained != null && dataObtained != List.empty()) {
        status.value = OperationStatus.success;
      } else {
        status.value = OperationStatus.empty;
      }
    } catch (e) {
      status.value = OperationStatus.error;
      errorMessage.value = e.toString();
    }
  }
}
