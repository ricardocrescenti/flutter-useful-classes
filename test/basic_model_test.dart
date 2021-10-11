import 'package:flutter_test/flutter_test.dart';
import 'package:useful_classes/useful_classes.dart';

void main() {
  test('adds one to input values', () {

    var basicModelTest = BasicModelTest();
    basicModelTest.name = 'Test';

    Map json = basicModelTest.toJson();
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test');
    expect(json.containsKey('description'), true);
    expect(json['description'], null);
    
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test');
    expect(json.containsKey('description'), false);
    
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: false);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test');
    expect(json.containsKey('description'), false);
    
    json = basicModelTest.toJson(exportOnlyChanged: false, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test');
    expect(json.containsKey('description'), false);

    basicModelTest = BasicModelTest.fromJson({
      'name': 'Test',
      'description': 'Description'
    });

    json = basicModelTest.toJson();
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test');
    expect(json.containsKey('description'), true);
    expect(json['description'], 'Description');
    
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: true);
    expect(json.containsKey('name'), false);
    expect(json.containsKey('description'), false);
    
    json = basicModelTest.toJson(exportOnlyChanged: false, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test');
    expect(json.containsKey('description'), true);
    expect(json['description'], 'Description');
    
    basicModelTest.name = 'Test2';
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test2');
    expect(json.containsKey('description'), false);
    
    basicModelTest.description = null;
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test2');
    expect(json.containsKey('description'), false);
    
    json = basicModelTest.toJson(exportOnlyChanged: false, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test2');
    expect(json.containsKey('description'), false);
    
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: false);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test2');
    expect(json.containsKey('description'), true);
    expect(json['description'], null);
    
    basicModelTest.description = 'Description2';
    json = basicModelTest.toJson(exportOnlyChanged: true, ignoreNulls: true);
    expect(json.containsKey('name'), true);
    expect(json['name'], 'Test2');
    expect(json.containsKey('description'), true);
    expect(json['description'], 'Description2');
  });
}

class BasicModelTest extends BasicModel {
	String? name;
	String? description;

	BasicModelTest() : super();
	BasicModelTest.fromJson(dynamic json) : super.fromJson(json);

	@override
	void readValues() {
		name = readValue<String>('name');
		description = readValue<String>('description');
	}

	@override
	void writeValues(bool exportOnlyChanged, bool ignoreNulls) {
		writeValue('name', name);
		writeValue('description', description);
	}
}
