import '../person/person.dart';
import 'package:equatable/equatable.dart';

class Association extends Equatable {
  final int code;
  final String name;
  final DateTime since;
  final String city;
  final Person? manager;

  const Association({
    required this.code,
    required this.name,
    required this.since,
    required this.city,
    this.manager,
  });

  @override
  List<Object?> get props => [code, name, since, city, manager];

  factory Association.fromMap(Map<String, dynamic> value) {
    return Association(
      code: value['code'],
      name: value['name'],
      since: DateTime.parse(value['since']),
      city: value['city'],
      manager: value['manager'] != null ? Person.fromMap(value['manager']) : null,
    );
  }
}
