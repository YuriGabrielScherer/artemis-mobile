part of 'athlete_graduation_timeline_bloc.dart';

abstract class AthleteGraduationTimelineEvent extends Equatable {
  const AthleteGraduationTimelineEvent();

  @override
  List<Object> get props => [];
}

class AthleteGraduationTimelineDownload extends AthleteGraduationTimelineEvent {
  const AthleteGraduationTimelineDownload({required this.graduationCode, required this.athleteCode});
  final int graduationCode;
  final int athleteCode;
  @override
  List<Object> get props => [graduationCode, athleteCode];
}
