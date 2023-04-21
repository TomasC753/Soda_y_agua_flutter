part of 'service_response.dart';

class ResponseList<T> extends IServiceResponse<List<T>> {
  List<T> data = <T>[];
  RxList<T> printedData = <T>[].obs;
  bool Function(T, String)? conditionsForSearch;
  ResponseList(
      {required super.status,
      required super.getterFunction,
      required this.data,
      this.conditionsForSearch});

  @override
  Future<void>? getData() async {
    try {
      status.value = OperationStatus.loading;
      List<T> dataObtained = await getterFunction();
      data = dataObtained;
      printedData.value = dataObtained;
      if (dataObtained.isNotEmpty) {
        status.value = OperationStatus.success;
      } else {
        status.value = OperationStatus.empty;
      }
    } catch (e) {
      status.value = OperationStatus.error;
      errorMessage.value = e.toString();
    }
  }

  void search<E>(String query) {
    if (conditionsForSearch == null) {
      throw ('No se definieron las condiciones de busqueda');
    }
    if (query.isEmpty) {
      printedData.value = data;
    }
    query = query.toLowerCase();
    printedData.value = List<T>.from(
        data.where((element) => conditionsForSearch!(element, query)).toList());
  }
}

// class ResponseList<T> extends IServiceResponse<List<T>> {
//   Rx<List<T>> data;
//   late Rx<List<T>> printedData;
//   bool Function<E>(E, String)? conditionsForSearch;
  
//   ResponseList(
//       {required super.status,
//       required super.getterFunction,
//       required this.data,
//       this.conditionsForSearch}) {
//     printedData = data;
//   }

//   @override
//   Future<void> getData() async {
//     try {
//       status.value = OperationStatus.loading;
//       List<T> dataObtained = await getterFunction();
//       data.value = dataObtained;
//       if (dataObtained.isNotEmpty) {
//         status.value = OperationStatus.success;
//       } else {
//         status.value = OperationStatus.empty;
//       }
//     } catch (e) {
//       status.value = OperationStatus.error;
//       errorMessage.value = e.toString();
//     }
//   }

//   void search(String query) {
//     if (conditionsForSearch == null) {
//       throw ('No se definieron las condiciones de busqueda');
//     }
//     if (query.isEmpty) {
//       printedData = data;
//     }
//     query = query.toLowerCase();
//     printedData.value = List.from(
//       data.value.where((element) => conditionsForSearch!(element, query)),
//     ) as List<T>;
//   }
// }