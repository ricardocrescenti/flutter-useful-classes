# useful_classes

Package with useful classes to make it easy to create other features

```dart
import 'package:useful_classes/useful_classes.dart';
```

# State Management Classes

## **ValueProvider / ValueConsumer**

Simple class to notify listeners when value is changed.

```dart
ValueProvider<String> description = ValueProvider(initialValue: 'Initial Description');
```

You can modify value setting property 'value' or calling method 'setValue'.

```dart
description.value = 'Another Description';
description.setValue('Another Description');
```

Example to consume this value. In this case, when changing the description value, the Text Widget is rebuilt and shows the new value.

```dart
ValueConsumer<String>(
  provider: description,
  builder: (context, value) => Text(value)
);
```

## **ValuesProvider / ValuesConsumer**

Controlling multiple values and ValueProvider.

In the bellow example , is declared 'packageInfo' with the values 'name' os type String and value 'version' of type ValueProvider<String>. If you use a ValueProvider in value of ValuesProvider, on get value, is returned the value of ValueProvider, to get the ValueProvider instance, you need use 'getValueProvider' method.

```dart
ValuesProvider packageInfo = ValuesProvider({
  'name': 'package_name',
  'version': ValueProvider<String>(initialValue: ''),
});
```

To update the values on ValuesProvider use 'setValues' method passing a Map<String, dynamic>, and to update a single value, use 'setValue' with 'fieldName' and 'newValue' arguments.

```dart
packageInfo.setValues({
  'name': 'module_provider',
  'version': '1.0.0'
});
```

Example for consume all values of the ValuesProvider.

```dart
ValuesConsumer(
  provider: packageInfo,
  builder: (context, values) => Column() {
    childs: Widget[] {
      Text(values['name']),
      Text(values['version'])
    }
  }
);
```

Example for consume a ValueProvider in the ValuesProvider.

```dart
ValueConsumer<String>(
    provider: packageInfo.getValueProvider('version'),
    builder: (context, value) => Text(value)
);
```