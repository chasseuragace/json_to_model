import 'package:json_to_model/core/json_model.dart';
import 'package:json_to_model/core/model_template.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('All supported types', () {
    const content = <String, dynamic>{
      "name": "Mark",
      "age?": 25,
      "city?": "New York",
      "birthdate": "@datetime",
      "timeStamp": "@timestamp",
      "doubleValue": 0.0,
      "nullableDoubleValue?": 0.0,
    };

    final jsonModel = JsonModel.fromMap(
      'types',
      content,
      relativePath: './',
      packageName: 'core',
      indexPath: 'index.dart',
    );

    final output = modelFromJsonModel(jsonModel);

    expect(output, contains('final String name;'));
    expect(output, contains('final int? age;'));
    expect(output, contains('final String? city;'));
    expect(output, contains('final DateTime birthdate;'));
    expect(output, contains('final DateTime timeStamp;'));
    expect(output, contains('final double doubleValue;'));
    expect(output, contains('final double? nullableDoubleValue;'));

    expect(output, contains("doubleValue: (json['doubleValue'] as num).toDouble()"));
    expect(
      output,
      contains(
        "nullableDoubleValue: json['nullableDoubleValue'] != null ? (json['nullableDoubleValue'] as num).toDouble() : null",
      ),
    );
  });
}
