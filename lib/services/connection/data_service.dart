import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:soda_y_agua_flutter/models/ideable.dart';
import 'package:soda_y_agua_flutter/services/connection/hive/hive_service.dart';

import 'api/api_service.dart';
import 'api/crud_operations.dart';
import 'interfaces/crud_interface.dart';
import 'synchronization/synchronization_service.dart';

enum DataStrategy { api, localDb }

class DataService<T extends Iideable> implements CrudInterface<T> {
  DataStrategy currentStrategy = DataStrategy.api;
  String pluralModelName;
  String singularModelName;
  Function(Map<String, dynamic>) serializer;

  final SynchronizationService _synchronizationService =
      Get.find<SynchronizationService>();

  ApiService api = ApiService();
  HiveService? _hive;
  late ApiCrudOperations _apiCrudOperations;

  final Connectivity connectivity = Connectivity();

  DataService({
    required this.pluralModelName,
    required this.singularModelName,
    required this.serializer,
  }) {
    connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
    _apiCrudOperations = ApiCrudOperations<T>(
        modelName: singularModelName, serializer: serializer);
  }

  Future<void> _initHiveService() async {
    _hive = await HiveService.init<T>(
      serializer: serializer,
      name: pluralModelName,
    );
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      currentStrategy = DataStrategy.localDb;
    } else {
      currentStrategy = DataStrategy.api;
    }
  }

  Future<void> waitForHiveToBeDefined() async {
    if (_hive == null) {
      await _initHiveService();
    }
    return;
  }

  @override
  Future<List<T>> getAll({Map? filters}) async {
    // await waitForHiveToBeDefined();
    // if (_hive!.box.isNotEmpty) {
    //   return await _hive!.getAll() as List<T>;
    // }
    if (currentStrategy == DataStrategy.api) {
      List<T> data =
          await _apiCrudOperations.getAll(filters: filters) as List<T>;
      // _synchronizationService.syncData(_hive!.box, listData: data);
      return data;
    }

    throw Exception('Ocurrió un error');
  }

  @override
  Future<T> getById(int id) async {
    // await waitForHiveToBeDefined();
    try {
      // if (_hive.box.isNotEmpty) {
      //   return await _hive.getById(id) as T;
      // }
      if (currentStrategy == DataStrategy.api) {
        T data = await _apiCrudOperations.getById(id) as T;
        // _synchronizationService.syncData(_hive!.box, data: data);
        return data;
      }
      throw Exception('Ocurrió un error');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> store(Map<String, dynamic> data) async {
    await waitForHiveToBeDefined();
    _hive!.store(data);
    if (currentStrategy == DataStrategy.api) {
      await _apiCrudOperations.store(data);
      return;
    }
    // Acciones en local
    _synchronizationService.addToQueue(() => _apiCrudOperations.store(data),
        description:
            'Se creo una nueva instancia del model $singularModelName en la base de datos');
  }

  @override
  Future<void> update(
      {required int id, required Map<String, dynamic> data}) async {
    await waitForHiveToBeDefined();
    _hive!.update(id: id, data: data);
    if (currentStrategy == DataStrategy.api) {
      await _apiCrudOperations.update(id: id, data: data);
      return;
    }
    // Acciones en local
    _synchronizationService.addToQueue(
        () => _apiCrudOperations.update(id: id, data: data),
        description:
            'El id ($id) del modelo $singularModelName ha sido actualizado en la base de datos');
  }

  @override
  Future<void> delete(int id) async {
    await waitForHiveToBeDefined();
    _hive!.delete(id);
    if (currentStrategy == DataStrategy.api) {
      await _apiCrudOperations.destroy(id);
      return;
    }
    // Acciones en local
    _synchronizationService.addToQueue(() => _apiCrudOperations.destroy(id),
        description:
            'El id ($id) del modelo $singularModelName ha sido borrado de la base de datos');
  }
}
