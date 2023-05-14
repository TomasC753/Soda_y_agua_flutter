Map<String, Map<String, int>> limitsAndConsumptionsFromJson(Map json) {
  Map<String, Map<String, int>> result = <String, Map<String, int>>{};
  Map<String, dynamic> limitsAndConsumptions = json['limits_and_consumptions'];
  dynamic consumptions = limitsAndConsumptions['consumptions'];
  dynamic limits = limitsAndConsumptions['limits'];
  result['consumptions'] = consumptions is Map<String, dynamic>
      ? Map<String, int>.from(
          consumptions.map((key, value) => MapEntry(key, value as int)))
      : <String, int>{};
  result['limits'] = limits is Map<String, dynamic>
      ? Map<String, int>.from(
          limits.map((key, value) => MapEntry(key, value as int)))
      : <String, int>{};

  return result;
}

Map limitsAndConsumptionsToJson(Map<String, Map<String, int>> object) {
  return {
    "consumptions": object['consumptions'] ?? {},
    "limits": object['limits'] ?? {}
  };
}
