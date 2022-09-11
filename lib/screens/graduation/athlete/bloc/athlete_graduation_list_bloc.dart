import '../../../../models/graduation/athlete/athlete_graduation.dart';
import '../../../../providers/repositories/athlete_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_graduation_list_event.dart';
part 'athlete_graduation_list_state.dart';

class AthleteGraduationListBloc extends Bloc<AthleteGraduationListEvent, AthleteGraduationListState> {
  AthleteGraduationListBloc(IAthleteRepository repository)
      : _repository = repository,
        super(AthleteGraduationListInitial()) {
    on<AthleteGraduationListRequest>(_onAthleteGraduationListRequest);
  }
  final IAthleteRepository _repository;

  void _onAthleteGraduationListRequest(AthleteGraduationListRequest event, Emitter emit) async {
    try {
      emit(AthleteGraduationListLoading());
      final List<AthleteGraduation> graduations = await _repository.listGraduations(event.athleteCode);
      emit(AthleteGraduationListSuccess(athleteGraduations: graduations));
    } catch (error) {
      print('Error: $error');
      emit(AthleteGraduationListError());
    }
  }
}
