part of 'athlete_info_bloc.dart';

abstract class AthleteInfoState extends Equatable {
  const AthleteInfoState();

  @override
  List<Object> get props => [];
}

class AthleteInfoInitial extends AthleteInfoState {}

class AthleteInfoLoading extends AthleteInfoState {}

class AthleteInfoSuccess extends AthleteInfoState {
  final Athlete athlete;
  const AthleteInfoSuccess({required this.athlete});
  @override
  List<Object> get props => [athlete];
}

class AthleteInfoError extends AthleteInfoState {}
