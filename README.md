# useful_classes

Package with useful classes to facilitate the creation of other resources

```dart
import 'package:useful_classes/useful_classes.dart';
```

## ValueBloc

Simple Bloc to make it easy to use StreamBuilder in your code

```dart
final ValueBloc<String> description = ValueBloc<String>(initialValue: 'Initial Description');
description.updateValue('Another Description');
description.dispose();
```

## ValuesBloc

Controlling multiple "ValueBloc"

```dart
final ValuesBloc packageInfo = ValuesBloc({
    'name': ValueBloc<String>(),
    'version': ValueBloc<String>(),
});
packageInfo.updateValues({
    'name': 'useful_classes',
    'version': '0.0.1'
});
packageInfo.dispose();
```

## Disposable

Class to implement disposable in classes

```dart
class Example extends Disposable {
    final ValueBloc<String> description = ValueBloc<String>();

    @override
    void dispose() {
        description.dispose();
        super.dispose();
    }
}
```