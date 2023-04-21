import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'service_response.dart';

// class SearchableResponseService<T extends List> extends ServiceResponse<T> {
//   late Rx<T> printedData;
//   SearchableResponseService(
//       {required super.data,
//       required super.status,
//       required super.getterFunction}) {
//     printedData = data;
//   }

// void search(String query) {
//   if (query.isEmpty) {
//     printedData = data;
//   }
//   query = query.toLowerCase();
//   printedData = data.
// }
// }

enum OperationStatus { loading, loadingMore, success, empty, error }

class ServiceResponse<T extends List> {
  late Rx<T> data;
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
      if (dataObtained.isEmpty) {
        status.value = OperationStatus.success;
      } else {
        status.value = OperationStatus.empty;
      }
    } catch (e) {
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
