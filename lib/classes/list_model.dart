import 'package:scoped_model/scoped_model.dart';
import 'package:useful_classes/useful_classes.dart';

class ListModel<T> extends Model with Disposable {
  List<T> _items = [];
  List<T> get items => _items;

  ValueBloc<List<T>> onInsert = ValueBloc<List<T>>();
  ValueBloc<List<T>> onRemove = ValueBloc<List<T>>();  

  ListModel({List<T> initialItems}) {
    if (initialItems != null) {
      _items.addAll(initialItems);
    }
  }

  insertItem(T item) {
    _items.add(item);

    onInsert.updateValue([item]);
    notifyListeners();
  }
  insertItems(List<T> items) {
    _items.addAll(items);

    onInsert.updateValue(items);
    notifyListeners();
  }

  removeItem(T item) {
    if (_items.contains(item)) {
      _items.remove(item);

      onRemove.updateValue([item]);
      notifyListeners();
    }
  }

  @override
  dispose() {
    onInsert.dispose();
    onRemove.dispose();
    return super.dispose();
  }
}