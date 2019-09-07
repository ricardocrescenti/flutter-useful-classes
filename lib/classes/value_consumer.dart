import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'value_model.dart';

class ValueConsumer<T> extends StatelessWidget {
  final Key key;
  final ValueModel<T> value;
  final Widget Function(BuildContext context, ValueModel<T> value) builder;
  ValueConsumer({
    this.key,
    @required this.value,
    @required this.builder});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ValueModel<T>>(
      model: value,
      child: new ScopedModelDescendant<ValueModel<T>>(
        builder: (context, child, model) => builder(context, model),
      ),
    );
  }
}