import 'package:equatable/equatable.dart';

class AthleteGraduationFile extends Equatable {
  final String name;
  final String type;
  final DateTime lastModifiedDate;

  const AthleteGraduationFile({
    required this.name,
    required this.type,
    required this.lastModifiedDate,
  });

  factory AthleteGraduationFile.fromMap(Map<String, dynamic> value) {
    return AthleteGraduationFile(
      name: value['name'],
      type: value['type'],
      lastModifiedDate: DateTime.parse(value['lastModifiedDate']),
    );
  }

  @override
  List<Object?> get props => [name, type, lastModifiedDate];
}
