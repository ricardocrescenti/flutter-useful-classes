## 2.3.1

* Fixed the `readValue` method of `BasicModel` which was always returning null.

## 2.3.0

* Added the `readList` method in `BasicModel` to load a list of objects from a JSON.

## 2.2.0

* Adjustments to the `BasicModel` documentation.

## 2.2.0

* Removed the constructor named `empty` from the `BasicModel` class.
* Added the `exportOnlyChanged` and `ignoreNulls` parameters in the `writeValues` method of the `BasicModel` class.
* Repositioned methods of the `BasicModel` class.
* Added test for the `BasicModel` class.

## 2.1.0+1

* Adjustment in the readme query selector

## 2.1.0

* Added `BasicModel` to standardize and facilitate the initialization of classes based on a `JSON` and also to export a class to `JSON`.
* Removed unused dependencies

## 2.0.0

* Restructured package and left only auxiliary classes for the development of other packages.
* Added `Logger` class.
* Added `OnDispose` class.

## 1.1.0

* Removed providers, moved to module [provider_package](https://github.com/ricardocrescenti/flutter-module-provider) package.
* Added `BasicLocalization` to facilitate a internationalization of applications e packages.

## 1.0.0

* Added ValueProvider, ValuesProvider, ListProvider with your consumers.
* Removed ValueBloc and ValuesBloc.

## 0.0.3

* Removed ValueModel, ValuesModel

## 0.0.2

* Added ValueModel, ValuesModel

## 0.0.1

* Initial version