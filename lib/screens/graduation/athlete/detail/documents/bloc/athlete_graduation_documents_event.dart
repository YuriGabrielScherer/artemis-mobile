part of 'athlete_graduation_documents_bloc.dart';

abstract class AthleteGraduationDocumentsEvent extends Equatable {
  const AthleteGraduationDocumentsEvent();

  @override
  List<Object> get props => [];
}

class AthleteGraduationDocumentsListEvent extends AthleteGraduationDocumentsEvent {
  final int graduationCode;
  final int athleteCode;
  const AthleteGraduationDocumentsListEvent({required this.graduationCode, required this.athleteCode});
  @override
  List<Object> get props => [graduationCode, athleteCode];
}

class AthleteGraduationDocumentsRemoveEvent extends AthleteGraduationDocumentsEvent {
  final File file;
  final int graduationCode;
  final int athleteCode;
  const AthleteGraduationDocumentsRemoveEvent({required this.file, required this.graduationCode, required this.athleteCode});
  @override
  List<Object> get props => [file, graduationCode, athleteCode];
}
