# useful_classes

Package with useful classes to facilitate the creation of other resources

```dart
import 'package:useful_classes/useful_classes.dart';
```

## ValueModel

Simple class to notify listeners when value is changed, you can modify value setting property 'value' or calling method 'updateValue'.

```dart
final ValueModel<String> description = ValueModel<String>(initialValue: 'Initial Description');
description.value = 'Another Description';
description.updateValue('Another Description');
```

## ValuesModel

Controlling multiple "ValueModel"

```dart
final ValuesModel packageInfo = ValuesModel({
    'name': ValueModel<String>(null),
    'version': ValueModel<String>(null),
});
packageInfo.updateValues({
    'name': 'useful_classes',
    'version': '0.0.1'
});
```

## ValueConsumer

Simple class to make easy to consume and receive changes notification from ValueNotifier

```dart
final ValueModel<String> description = ValueModel<String>(null);
description.value = 'Another Description';

ValueConsumer<String>(
    value: description,
    builder: (context, value) => Text(value)
);
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