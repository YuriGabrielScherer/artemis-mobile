part of 'athlete_graduation_list_bloc.dart';

abstract class AthleteGraduationListEvent extends Equatable {
  const AthleteGraduationListEvent();

  @override
  List<Object> get props => [];
}

class AthleteGraduationListRequest extends AthleteGraduationListEvent {
  const AthleteGraduationListRequest({required this.athleteCode});

  final int athleteCode;

  @override
  List<Object> get props => [athleteCode];
}
