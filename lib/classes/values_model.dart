import 'package:flutter/material.dart';

class ValuesModel {
  final Map<String, ValueNotifier> values;

  ValuesModel(this.values);

  updateValues(Map<String, dynamic> newValues) {
    if (newValues == null) {
      throw Exception('The map containing new values cannot be null');
    }
    newValues.forEach((key, value) {
      if (!values.containsKey(key)) {
        throw Exception('The key ($key) dont exists in values.');
      }
      values[key].value = value;
    });
  }
}