part of 'graduation_card_bloc.dart';

abstract class GraduationCardEvent extends Equatable {
  const GraduationCardEvent();

  @override
  List<Object> get props => [];
}

class GraduationCardRequest extends GraduationCardEvent {
  final int athleteCode;
  const GraduationCardRequest(this.athleteCode);

  @override
  List<Object> get props => [athleteCode];
}
