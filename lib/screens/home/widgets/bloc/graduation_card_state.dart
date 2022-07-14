part of 'graduation_card_bloc.dart';

abstract class GraduationCardState extends Equatable {
  const GraduationCardState();

  @override
  List<Object> get props => [];
}

class GraduationCardInitial extends GraduationCardState {}

class GraduationCardLoading extends GraduationCardState {}

class GraduationCardEmpty extends GraduationCardState {}

class GraduationCardSuccess extends GraduationCardState {
  final Graduation graduation;
  const GraduationCardSuccess(this.graduation);

  @override
  List<Object> get props => [graduation];
}

class GraduationCardError extends GraduationCardState {}
