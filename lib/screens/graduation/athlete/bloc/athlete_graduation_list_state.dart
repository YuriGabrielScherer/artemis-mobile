part of 'athlete_graduation_list_bloc.dart';

abstract class AthleteGraduationListState extends Equatable {
  const AthleteGraduationListState();

  @override
  List<Object> get props => [];
}

class AthleteGraduationListInitial extends AthleteGraduationListState {}

class AthleteGraduationListLoading extends AthleteGraduationListState {}

class AthleteGraduationListSuccess extends AthleteGraduationListState {
  final List<AthleteGraduation> athleteGraduations;
  const AthleteGraduationListSuccess({required this.athleteGraduations});
  @override
  List<Object> get props => [athleteGraduations];
}

class AthleteGraduationListError extends AthleteGraduationListState {}
