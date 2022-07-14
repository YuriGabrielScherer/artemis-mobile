import '../../core/enums/enum_belt.dart';
import '../person/person.dart';
import 'package:equatable/equatable.dart';

class Athlete extends Equatable {
  final DateTime since;
  final EnumBelt currentBelt;
  final Person person;

  const Athlete({
    required this.since,
    required this.currentBelt,
    required this.person,
  });

  @override
  List<Object?> get props => [since, currentBelt, person];

  factory Athlete.fromMap(Map<String, dynamic> value) {
    return Athlete(
      since: DateTime.parse(value['since']),
      currentBelt: EnumBelt.values.byName((value['currentBelt'] as String).toLowerCase()),
      person: Person.fromMap(value['person']),
    );
  }
}
