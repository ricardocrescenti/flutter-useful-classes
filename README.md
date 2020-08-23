# Useful Classes

Package with useful classes to assist in creating other packages and applications.

- **[Introduction](#introduction)**
- **[How to Install](#how-to-install)**
- **[Basic Model](#basic-model)**
- **[Logger](#logger)**
- **[OnDispose](#ondispose)**

## Introduction

This package was developed with the intention of maintaining useful classes that are used in other packages, to avoid replicating copies of the same classes.

## How to install

Add the dependency on `pubspec.yaml`. 

*Informing `^` at the beginning of the version, you will receive all updates that are made from version `2.0.0` up to the version before `3.0.0`.*

```yaml
dependencies:
  useful_classes: ^2.0.0
```

Import the package in the source code.

```dart
import 'package:useful_classes/useful_classes.dart';
```

## Basic Model

`BasicModel` is very useful for classes that need to be created from a `JSON` (on the flutter a `JSON` is a field and value map) or write a `JSON` from the instance data.

In the example below, a class with the name `UserModel` will be created, after that an example of how to create the class from a `JSON` will be shown and after generating `JSON` again based on the data contained in the class instance.

Class implementation

```dart
class UserModel extends BasicModel {
  int id;
  String name;
  String email;
  String phoneNumber;

  UserModel() : super();  
  UserModel.fromJson(json) : super.fromJson(json);

  @override
  void readValues() {
    super.readValues();
    this.id = readValue<int>('id');
    this.name = readValue<String>('name');
    this.email = readValue<String>('email');
    this.phoneNumber = readValue<String>('phone_number');
  }

  @override
  void writeValues(bool exportOnlyChanged, bool ignoreNulls) {
    writeValue('id', this.id);
    writeValue('name', this.name);
    writeValue('email', this.email);
    writeValue('phone_number', this.phoneNumber);
  }
}
```

Import the class based on a JSON

```dart
Map<String, dynamic> json = {
  'id': 1,
  'name': 'Darth Vader',
  'email': 'darth.vader@sith.galaxy',
  'phone_number': '547889633245'
};

UserModel user = UserModel.fromJson(json);
```

Generate JSON

```dart
UserModel user = UserModel()
  ..name = 'Obi-Wan Kenobi'
  ..email = 'obiwan.Kenobi@jedi.galaxy'
  ..phoneNumber = '478998789753'

Map<String, dynamic> json = user.toJson();
```

## Logger

The `Logger` class is a simple class for printing information on the terminal only when the application is in debug mode.

Below is an example of implementing the logger.

```dart
final Logger logger = Logger();

logger.log('simple log');
/// output: simple log

logger.info('information log');
/// output: 💡 information log

logger.warning('warning log');
/// output: ⚠️ warning log

logger.error('error log');
/// output: ⛔ error log
```

If it is necessary to add a prefix when printing all logs, use the `prefix` parameter in the class constructor.

```dart
final Logger logger = Logger(prefix: 'My prefix');
```

## OnDispose

Implement in their classes `dispose()` method, allowing notify listeners when class is disposed

```dart
class Test with OnDispose {

    // your class structure

    @override
    dispose() {
        // dispose your class and call `super.dispose()` to notify listeners
        super.dispose();
    }
}
```

In the example below, the test class will be created and an event added when discarding the class to print the text `Object disposed`.

```dart
final Test test = Test();
test.onDispose.add((object) => print('Object disposed'));

test.dispose();
/// output: Object disposed
```