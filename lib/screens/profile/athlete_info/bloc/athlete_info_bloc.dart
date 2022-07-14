import 'package:artemis_mobile/models/athlete/athlete.dart';
import 'package:artemis_mobile/providers/repositories/athlete_repository.dart';
import 'package:artemis_mobile/providers/repositories/impl/athlete_repository_impl.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_info_event.dart';
part 'athlete_info_state.dart';

class AthleteInfoBloc extends Bloc<AthleteInfoEvent, AthleteInfoState> {
  AthleteInfoBloc(IAthleteRepository repository)
      : _repository = repository,
        super(AthleteInfoInitial()) {
    on<AthleteInfoRequest>(_onAthleteInfoRequest);
  }

  final IAthleteRepository _repository;

  void _onAthleteInfoRequest(AthleteInfoRequest event, Emitter<AthleteInfoState> emit) async {
    try {
      emit(AthleteInfoLoading());
      final Athlete athlete = await _repository.getAthlete(event.athleteCode);
      emit(AthleteInfoSuccess(athlete: athlete));
    } catch (error) {
      print('Error: $error');
      emit(AthleteInfoError());
    }
  }
}
