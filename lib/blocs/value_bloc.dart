import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:useful_classes/useful_classes.dart';

/// Simple Bloc to make it easy to use StreamBuilder in your code
class ValueBloc<T> extends Disposable {

  final BehaviorSubject<T> bloc = BehaviorSubject();

  T get value => bloc.value;  
  ValueObservable<T> get value$ => bloc.stream;

  set value(T value) => bloc.sink.add(value);

  ValueBloc({T initValue}) {
    updateValue(initValue);
  }

  updateValue(T newValue) {
    if (newValue != this.value) {
      value = newValue;
    }
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }
}