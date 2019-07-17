class Serialization {

  Map<String, dynamic> filterMap(Map<String, dynamic> map, Iterable<String> filterFields) {
    map.removeWhere((key, value) => (key != 'id' && key != 'uuid' && filterFields != null && !filterFields.contains(key)));
    return map;
  }

}