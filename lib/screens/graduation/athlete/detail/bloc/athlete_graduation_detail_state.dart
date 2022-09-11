part of 'athlete_graduation_detail_bloc.dart';

abstract class AthleteGraduationDetailState extends Equatable {
  const AthleteGraduationDetailState();

  @override
  List<Object> get props => [];
}

class AthleteGraduationDetailInitial extends AthleteGraduationDetailState {}

class AthleteGraduationDetailLoading extends AthleteGraduationDetailState {}

class AthleteGraduationDetailSuccess extends AthleteGraduationDetailState {
  const AthleteGraduationDetailSuccess({required this.athleteGraduation});
  final AthleteGraduation athleteGraduation;
  @override
  List<Object> get props => [athleteGraduation];
}

class AthleteGraduationDetailError extends AthleteGraduationDetailState {}
