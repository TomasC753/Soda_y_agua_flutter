abstract class CrudInterface<T> {
  Future<List<T>> getAll({Map? filters});
  Future<T> getById(int id);
  Future<void> store(Map<String, dynamic> data);
  Future<void> update({required int id, required Map<String, dynamic> data});
  Future<void> delete(int id);
}
