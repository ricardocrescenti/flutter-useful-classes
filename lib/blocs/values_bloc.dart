import 'package:useful_classes/useful_classes.dart';

/// Class to control multiple "ValueBloc"
class ValuesBloc extends Disposable {
  final Map<String, ValueBloc<dynamic>> fields;
  
  ValuesBloc(this.fields, {Map<String, dynamic> initValues}) {
    if (initValues != null) {
      updateValues(initValues);
    }
  }

  ValueBloc<dynamic> field(String field) {
    if (fields.containsKey(field)) {
      return fields[field];
    }
    throw 'Invalid field \'$field\' in FieldsBloc.';
  }

  updateValues(Map<String, dynamic> values) {
    values.forEach((key, initValue) {
      if (fields.containsKey(key)) {
        fields[key].updateValue(initValue);
      }
    });
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    fields.forEach((key, field) {
      map[key] = field.value;
    });
    return map;
  }

  @override
  dispose() {
    if (fields != null) {
      fields.forEach((key, field) => field.dispose());
    }
    fields.clear();
    return super.dispose();
  }
}