part of 'graduation_list_bloc.dart';

abstract class GraduationListEvent extends Equatable {
  const GraduationListEvent();

  @override
  List<Object> get props => [];
}

class GraduationListRequest extends GraduationListEvent {
  final int athleteCode;
  const GraduationListRequest({required this.athleteCode});

  @override
  List<Object> get props => [athleteCode];
}
