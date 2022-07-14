part of 'athlete_graduation_history_bloc.dart';

abstract class AthleteGraduationHistoryState extends Equatable {
  const AthleteGraduationHistoryState();

  @override
  List<Object> get props => [];
}

class AthleteGraduationHistoryInitial extends AthleteGraduationHistoryState {}

class AthleteGraduationHistoryLoading extends AthleteGraduationHistoryState {}

class AthleteGraduationHistorySuccess extends AthleteGraduationHistoryState {
  final List<AthleteGraduation> athleteGraduations;
  const AthleteGraduationHistorySuccess({required this.athleteGraduations});
  @override
  List<Object> get props => [athleteGraduations];
}

class AthleteGraduationHistoryError extends AthleteGraduationHistoryState {}
