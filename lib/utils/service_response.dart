import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'response_generic.dart';
part 'response_list.dart';

enum OperationStatus { loading, loadingMore, success, empty, error }

class IServiceResponse<T> {
  Rxn<OperationStatus> status;
  Future<T> Function({int? id}) getterFunction;
  RxString errorMessage = ''.obs;

  IServiceResponse({required this.status, required this.getterFunction});

  Future<void> getData({int? id, void Function(T)? onSuccess}) async {}

  Widget returnContentWhen(
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
    return results[status] ?? const SizedBox();
  }

  // void doWhen(
  //     {Function(T)? onSuccess,
  //     Function()? onLoading,
  //     Function()? onEmpty,
  //     Function(String)? onError,
  //     Function()? onLoadingMore}) {
  //   Map<OperationStatus, Function?> results = {
  //     OperationStatus.success: onSuccess,
  //     OperationStatus.loading: onLoading,
  //     OperationStatus.empty: onEmpty,
  //     OperationStatus.error: onError,
  //     OperationStatus.loadingMore: onLoadingMore
  //   };

  //   results[status] != null ? results[status]!() : {};
  // }
}
