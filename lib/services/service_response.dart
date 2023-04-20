import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum OperationStatus { loading, loadingMore, success, empty, error }

class ServiceResponse<T> {
  late Rx<T> data;
  // RxStatus status;
  Rxn<OperationStatus> status;
  Future<T> Function() getterFunction;

  RxString errorMessage = ''.obs;

  ServiceResponse(
      {required this.data, required this.status, required this.getterFunction});

  Future<void> getData() async {
    try {
      status.value = OperationStatus.loading;
      T dataObtained = await getterFunction();
      data.value = dataObtained;
      if (dataObtained != null && dataObtained != List.empty()) {
        // status = RxStatus.success();
        status.value = OperationStatus.success;
      } else {
        // status.isEmpty;
        // status = RxStatus.empty();
        status.value = OperationStatus.empty;
      }
    } catch (e) {
      // status.isError;
      // status = RxStatus.error();
      status.value = OperationStatus.error;
      errorMessage.value = e.toString();
    }
  }

  Widget? returnContentWhen(
      {Widget? onSuccess,
      Widget? onLoading,
      Widget? onError,
      Widget? onEmpty,
      Widget? onLoadingMore}) {
    Map<OperationStatus, Widget?> results = {
      OperationStatus.success: onSuccess,
      OperationStatus.loading: onLoading,
      OperationStatus.empty: onEmpty,
      OperationStatus.error: onError,
      OperationStatus.loadingMore: onLoadingMore
    };
    return results[status];
  }
}
