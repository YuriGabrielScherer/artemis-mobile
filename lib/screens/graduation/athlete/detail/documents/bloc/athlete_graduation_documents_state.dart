part of 'athlete_graduation_documents_bloc.dart';

enum EnumAthleteGraduationDocumentsError {
  fetch,
  delete;
}

abstract class AthleteGraduationDocumentsState extends Equatable {
  const AthleteGraduationDocumentsState();

  @override
  List<Object> get props => [];
}

class AthleteGraduationDocumentsInitial extends AthleteGraduationDocumentsState {}

class AthleteGraduationDocumentsLoading extends AthleteGraduationDocumentsState {}

class AthleteGraduationDocumentsSuccess extends AthleteGraduationDocumentsState {
  final List<File> files;
  const AthleteGraduationDocumentsSuccess({required this.files});
  @override
  List<Object> get props => [files];
}

class AthleteGraduationDocumentsError extends AthleteGraduationDocumentsState {
  final EnumAthleteGraduationDocumentsError error;
  const AthleteGraduationDocumentsError({this.error = EnumAthleteGraduationDocumentsError.fetch});
  @override
  List<Object> get props => [error];
}
