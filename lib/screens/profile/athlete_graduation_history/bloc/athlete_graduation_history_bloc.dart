import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/providers/repositories/athlete_repository.dart';
import 'package:artemis_mobile/providers/repositories/impl/athlete_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_graduation_history_event.dart';
part 'athlete_graduation_history_state.dart';

class AthleteGraduationHistoryBloc extends Bloc<AthleteGraduationHistoryEvent, AthleteGraduationHistoryState> {
  AthleteGraduationHistoryBloc(AthleteRepository repository)
      : _repository = repository,
        super(AthleteGraduationHistoryInitial()) {
    on<AthleteGraduationHistoryRequest>(_onAthleteGraduationHistoryRequest);
  }

  final IAthleteRepository _repository;

  void _onAthleteGraduationHistoryRequest(AthleteGraduationHistoryRequest event, Emitter emit) async {
    try {
      emit(AthleteGraduationHistoryLoading());
      final List<AthleteGraduation> graduations = await _repository.listGraduations(event.athleteCode);
      emit(AthleteGraduationHistorySuccess(athleteGraduations: graduations));
    } catch (error) {
      emit(AthleteGraduationHistoryError());
    }
  }
}
