part of 'athlete_graduation_timeline_bloc.dart';

abstract class AthleteGraduationTimelineState extends Equatable {
  const AthleteGraduationTimelineState();

  @override
  List<Object> get props => [];
}

class AthleteGraduationTimelineInitial extends AthleteGraduationTimelineState {}

class AthleteGraduationTimelineLoading extends AthleteGraduationTimelineState {}

class AthleteGraduationTimelineSuccess extends AthleteGraduationTimelineState {}

class AthleteGraduationTimelineError extends AthleteGraduationTimelineState {}
