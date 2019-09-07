import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'list_model.dart';

class ListConsumer<T> extends StatelessWidget {
  final Key key;
  final ListModel<T> list;
  final Widget Function(BuildContext context, ListModel<T> list) builder;
  ListConsumer({
    this.key,
    @required this.list,
    @required this.builder});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ListModel<T>>(
      model: list,
      child: new ScopedModelDescendant<ListModel<T>>(
        builder: (context, child, model) => builder(context, model),
      ),
    );
  }
}