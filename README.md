# Useful Classes

Package with useful classes to assist in creating other packages and applications.

- **[Introduction](#introduction)**
- **[How to Install](#how-to-install)**
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