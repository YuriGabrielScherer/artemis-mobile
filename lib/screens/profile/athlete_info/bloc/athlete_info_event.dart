part of 'athlete_info_bloc.dart';

abstract class AthleteInfoEvent extends Equatable {
  const AthleteInfoEvent();

  @override
  List<Object> get props => [];
}

class AthleteInfoRequest extends AthleteInfoEvent {
  const AthleteInfoRequest({required this.athleteCode});
  final int athleteCode;
  @override
  List<Object> get props => [athleteCode];
}
