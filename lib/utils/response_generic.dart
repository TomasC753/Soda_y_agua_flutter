part of 'service_response.dart';

class ResponseGeneric<T> extends IServiceResponse<T> {
  Rxn<T> data;

  ResponseGeneric(
      {required super.status,
      required super.getterFunction,
      required this.data});

  @override
  Future<void> getData(
      {int? id, void Function(T)? onSuccess, Widget? whileLoading}) async {
    try {
      if (whileLoading != null) {
        Get.dialog(whileLoading);
      }
      status.value = OperationStatus.loading;
      T dataObtained = await getterFunction(id: id);
      data.value = dataObtained;
      if (whileLoading != null) {
        Get.back();
      }
      if (dataObtained != null) {
        status.value = OperationStatus.success;
        onSuccess?.call(dataObtained);
      } else {
        status.value = OperationStatus.empty;
      }
    } catch (e) {
      status.value = OperationStatus.error;
      errorMessage.value = e.toString();
    }
  }
}
