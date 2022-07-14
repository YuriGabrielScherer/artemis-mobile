import '../person/person.dart';

class Professor extends Person {
  const Professor({
    required super.code,
    required super.name,
    required super.birth,
    required super.document,
    required super.gender,
  });

  factory Professor.fromMap(Map<String, dynamic> value) {
    final Person person = Person.fromMap(value['person']);
    return Professor(
      code: person.code,
      name: person.name,
      birth: person.birth,
      document: person.document,
      gender: person.gender,
    );
  }
}
