part of 'athlete_graduation_detail_bloc.dart';

abstract class AthleteGraduationDetailEvent extends Equatable {
  const AthleteGraduationDetailEvent();

  @override
  List<Object?> get props => [];
}

class AthleteGraduationDetailSearch extends AthleteGraduationDetailEvent {
  const AthleteGraduationDetailSearch({this.athleteGraduation, this.athleteCode, this.graduationCode});
  final AthleteGraduation? athleteGraduation;
  final int? athleteCode;
  final int? graduationCode;

  @override
  List<Object?> get props => [athleteGraduation, athleteCode, graduationCode];
}
