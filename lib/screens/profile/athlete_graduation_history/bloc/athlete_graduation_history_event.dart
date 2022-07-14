part of 'athlete_graduation_history_bloc.dart';

abstract class AthleteGraduationHistoryEvent extends Equatable {
  const AthleteGraduationHistoryEvent();

  @override
  List<Object> get props => [];
}

class AthleteGraduationHistoryRequest extends AthleteGraduationHistoryEvent {
  const AthleteGraduationHistoryRequest({required this.athleteCode});

  final int athleteCode;

  @override
  List<Object> get props => [athleteCode];
}
