import 'dart:convert';

import 'package:flutter/material.dart';

/// Basic classics to control data models using maps.
/// 
/// This class already has standard methods to create or update a class based
/// on a [Map] of data, and also to export a class to a [Map]. In Dart, JSONs
/// are converted to maps `Map<string,dynamic`.
/// 
/// See below the methods used publicly to create/update a class, and to 
/// generate a [Map].
/// 
/// - [fromJson]: Create an instance of the class based on a [Map].
/// - [updateValues]: Update a class already instantiated with new values 
/// contained in a [Map].
/// - [toJson]: Export an instantiated class to a [Map].
/// 
/// Implementation example:
/// 
/// ```dart
/// class UserModel extends BasicModel {
///   int id;
///   String name;
///   String email;
///   String phoneNumber;
///   
///   UserModel() : super();  
///   UserModel.fromJson(json) : super.fromJson(json);
/// 
///   @override
///   void readValues() {
///     super.readValues();
///     this.id = readValue<int>('id');
///     this.name = readValue<String>('name');
///     this.email = readValue<String>('email');
///     this.phoneNumber = readValue<String>('phone_number');
///   }
/// 
///   @override
///   void writeValues() {
///     super.writeValues();
///     writeValue('id', this.id);
///     writeValue('name', this.name);
///     writeValue('email', this.email);
///     writeValue('phone_number', this.phoneNumber);
///   }
/// }
/// ```
abstract class BasicModel {
	/// Original map used in the creation of the class.
	Map<String, dynamic> _originalMap = Map();

	/// Last map read by the [updateValues] method to update the class values.
	Map<String, dynamic> _lastReadedMap;

	/// Last map generated by the [toJson] method.
	Map<String, dynamic> _lastWritedMap;

	/// Indicates whether only the modified values should be exported during data
	/// export. This property is set by [toJson] itself, which has a parameter
	/// with the same name.
	bool _exportOnlyChanged = false;
	
	/// Indicates whether null objects should be ignored during export. This property
	/// is set by [toJson] itself, which has a parameter with the same name.
	bool _ignoreNulls = false;

	/// Standard constructor of class [BasicModel].
	BasicModel();
	
	/// Generate the class based on a [Map] `(JSON)`.
	@mustCallSuper
	BasicModel.fromJson(dynamic json) {
		if (json is String) {
			this._originalMap = jsonDecode(json);
		} else {
			this._originalMap = Map.from(json);
		}

		updateValues(json);
	}

	/// This method updates the class data with the [map] passed by parameter.
	@mustCallSuper
	void updateValues(Map<String, dynamic> map) {
		_lastReadedMap = map;
		readValues();
	}

	/// This method updates the class data. It is called by the [updateValues] 
	/// and [BasicModel.fromJson] method for creating the class.
	/// 
	/// This method is overridden in all classes that inherit from [BasicModel]
	/// to define the initialization structure of the class based on a [Map] `(JSON)`.
	@mustCallSuper
	@protected
	void readValues();

	/// This method is used to read a value from the [Map] `(JSON)` data and return
	/// it in the defined type.
	/// 
	/// If it is necessary to carry out a conversion of the read object before it
	/// is returned, pass the conversion function in the parameter [convertion], 
	/// with that the function will receive the value informed in the map, and it
	/// can be converted as needed.
	/// 
	/// It is also possible to indicate a default value for cases where the field
	/// to be read does not exist in [Map] or is null.
	/// 
	/// Use this method within the [readValues] method that you will override in
	/// the inheritance classes to define how the [Map] will be read for your class.
	@protected
	T readValue<T>(String fieldName, {T Function(dynamic value) convertion, T nullValue}) {
		if (this._lastReadedMap[fieldName] != null) {
			if (convertion != null) {
				return convertion(this._lastReadedMap[fieldName]);
			} else if (T == int) {
				return int.parse(this._lastReadedMap[fieldName].toString()) as T;
			} else if (T == BigInt) {
				return BigInt.parse(this._lastReadedMap[fieldName].toString()) as T;
			} else if (T == double) {
				return double.parse(this._lastReadedMap[fieldName].toString()) as T;
			} else if (T == DateTime) {
				if (!(this._lastReadedMap[fieldName] is DateTime)) {
					return DateTime.parse(this._lastReadedMap[fieldName].toString()) as T;
				}
			}
			return this._lastReadedMap[fieldName] as T;
		}
		return nullValue;
	}

	/// This method is used in cases where it is necessary to export the class to
	/// a [Map] `(JSON)`.
	/// 
	/// When calling this function, a new [_lastWritedMap] will be created to store
	/// the [Map] that will be generated, and then the [writeValues] method that
	/// has the [Map] generation structure will be executed.
	@mustCallSuper
	Map<String, dynamic> toJson({bool exportOnlyChanged = false, bool ignoreNulls = false}) {
		_exportOnlyChanged = exportOnlyChanged ?? false;
		_ignoreNulls = ignoreNulls ?? false;

		_lastWritedMap = Map();
		writeValues(_exportOnlyChanged, _ignoreNulls);

		return _lastWritedMap;
	}

	/// This method is used to define the export structure of the class values
	/// to a [Map].
	/// 
	/// To write a value to the [Map] that will be exported, use the [writeValue] 
	/// method.
	@mustCallSuper
	@protected
	void writeValues(bool exportOnlyChanged, bool ignoreNulls);
	
	/// This method is used to save the values in a [Map] `(JSON)`, this will be
	/// used when the class is being exported to a `JSON`,
	/// 
	/// To do this, you must enter the [fieldName] parameter with the name of the
	/// [Map] key, and in the [value] parameter the value that will be recorded 
	/// in [Map].
	/// 
	/// If it is necessary to convert the exported value to another format, inform
	/// the [convertion] parameter the conversion method, this method will receive
	/// the current value of the property, and may return the value as needed.
	/// 
	/// It will also be possible to indicate whether null values should be ignored
	/// using the [ignoreNull] parameter.
	/// 
	/// Use this method inside the [writeValues] method that you will override to
	/// define how the output `JSON` will be formed.
	@protected
	writeValue(String fieldName, dynamic value, {bool ignoreNull, exportIfChanged, dynamic Function(dynamic value) convertion}) {    
		
		ignoreNull ??= (_ignoreNulls ?? false);
		if (ignoreNull && value == null) {
			return;
		}

		if (value is List && convertion != null) {
			value = (value as List).map((item) => convertion(item)).toList();
		} else {
			value = (convertion != null ? convertion(value) : value);
		}

		exportIfChanged ??= (_exportOnlyChanged ?? false);
		if (_originalMap != null && _exportOnlyChanged && _originalMap[fieldName] == value && exportIfChanged) {
			return;
		}

		_lastWritedMap[fieldName] = value;
	}
}