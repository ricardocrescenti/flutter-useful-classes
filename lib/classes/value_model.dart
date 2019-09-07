import 'package:scoped_model/scoped_model.dart';

class ValueModel<T> extends Model {
  T _value;

  T get value => _value;
  set value(T newValue) => updateValue(newValue);

  ValueModel({T initialValue}) {
    value = initialValue;
  }

  updateValue(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }
}