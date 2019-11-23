# useful_classes

Package with useful classes to make it easy to create other features and applications

```dart
import 'package:useful_classes/useful_classes.dart';
```

## basic_localizations

Implement `localizations` in your packages and applications simply

First, I recommend that you declare an enumeration with the message names to make it easier to find messages

```dart
enum WidgetMessages { message1, message2 }
```

Below is an example localization, with the translation of `message1` and` message2` into English, Spanish and Portuguese.

If the application language does not match the supported languages that are declared in `supportedLocales`, the default language entered in` defaultLocale` will be used.

```dart
class DemoLocalizations extends BasicLocalizations {
  static DemoLocalizations of(BuildContext context) {
    DemoLocalizations localization = Localizations.of<DemoLocalizations>(context, DemoLocalizations);
    return localization ?? DemoLocalizations(Localizations.localeOf(context));
  }

  DemoLocalizations(Locale locale) : super(locale);

  @override
  Locale get defaultLocale => Locale('en');

  @override
  Iterable<Locale> get suportedLocales => [
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  @override
  Map<dynamic, Map<dynamic, String>> get localizedValues => {
    'en': {
      WidgetMessages.message1: 'First message',
      WidgetMessages.message2: 'Second message',
    },
    'es': {
      WidgetMessages.message1: 'Primer mensaje',
      WidgetMessages.message2: 'Segundo mensaje',
    },
    'pt': {
      WidgetMessages.message1: 'Primeira mensagem',
      WidgetMessages.message2: 'Segunda mensagem',
    }
  };
}

class DemoLocalizationsDelegate extends BasicLocalizationsDelegate<DemoLocalizations> {
  DemoLocalizationsDelegate(customLocalization) : super(customLocalization);

  @override
  DemoLocalizations defaultLocalization(Locale locale) => DemoLocalizations(locale);
}
```

Below will be shown how to get messages according to app location

```dart
Text(DemoLocalizations.of(context)[WidgetMessages.message1]);
```

It is not necessary to declare localization in `localizationsDelegates` of `MaterialApp`, but it is important that you enter `supportedLocales` to specify the languages supported by your application.

## disposable

Implement in their classes `dispose()` method, allowing notify listeners when class is disposed

```dart
class Test with Disposable {
    // your class structure

    @override
    dispose() {
        // dispose your class and call `super.dispose()` to notify listeners
        super.dispose();
    }
}
```

## log

Implement an simple log

```dart
Log log = Log('test')
log.info('information')
```