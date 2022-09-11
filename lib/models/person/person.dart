import 'dart:convert';

import '../../core/enums/enum_gender.dart';
import '../athlete/athlete.dart';
import 'package:equatable/equatable.dart';

import '../association/association.dart';

class Person extends Equatable {
  final int code;
  final String name;
  final DateTime birth;
  final String document;
  final EnumGender gender;
  final Association? association;
  final Athlete? athlete;

  const Person({
    required this.code,
    required this.name,
    required this.birth,
    required this.document,
    required this.gender,
    this.association,
    this.athlete,
  });

  @override
  List<Object?> get props => [code, name, birth, document, gender, association, athlete];

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      code: map['code'],
      name: map['name'],
      birth: DateTime.parse(map['birth']),
      document: map['document'],
      gender: EnumGender.values.byName((map['gender'] as String).toLowerCase()),
      association: map['association'] != null ? Association.fromMap(map['association']) : null,
    );
  }

  factory Person.fromJson(String input) {
    return Person.fromMap(json.decode(input));
  }
}
