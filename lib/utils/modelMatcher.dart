relateMatrixToModel<T>({required data, required Function serializerOfModel}) {
  return List<T>.from(data.map((item) => serializerOfModel(item)).toList());
}

relateToModel<T>({required data, required Function serializerOfModel}) {
  return serializerOfModel(data);
}
