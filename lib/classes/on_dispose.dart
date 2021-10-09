//import 'dart:async';

import 'package:flutter/foundation.dart';

/// This class allows you to implement listeners notification when disposing
/// object.
///
/// To notify listeners, create a `dispose()` method in your class.
///
/// ```dart
/// class Test with OnDispose {
///     // your class structure
///
///     @override
///     dispose() {
///         // dispose your class and call `super.dispose()` to notify listeners
///         super.dispose();
///     }
/// }
///
/// final Test test = Test();
/// test.onDispose.add(() => print('Object disposed'));
///
/// test.dispose();
/// ```
abstract class OnDispose {
  /// List of methods that will be called when the object is dropped.
  final List<Function(dynamic)> onDispose = [];

  /// Method that discards the object and notifies listeners
  @mustCallSuper
  void dispose() {
    notifyDispose();
  }

  /// Notify listeners with dispose of this object.
  @mustCallSuper
  void notifyDispose() {
    onDispose.forEach((element) => element(this));
    onDispose.clear();
  }
}
