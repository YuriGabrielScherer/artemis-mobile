import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/providers/repositories/athlete_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_graduation_detail_event.dart';
part 'athlete_graduation_detail_state.dart';

class AthleteGraduationDetailBloc extends Bloc<AthleteGraduationDetailEvent, AthleteGraduationDetailState> {
  AthleteGraduationDetailBloc({required IAthleteRepository repository})
      : _repository = repository,
        super(AthleteGraduationDetailInitial()) {
    on<AthleteGraduationDetailSearch>(_onSearch);
  }

  final IAthleteRepository _repository;

  void _onSearch(AthleteGraduationDetailSearch event, Emitter emit) async {
    if (event.athleteGraduation != null) {
      emit(AthleteGraduationDetailSuccess(athleteGraduation: event.athleteGraduation!));
      return;
    }

    emit(AthleteGraduationDetailLoading());

    try {
      final AthleteGraduation athleteGraduation = await _repository.getAthleteGraduation(
        athleteCode: event.athleteCode!,
        graduationCode: event.graduationCode!,
      );
      emit(AthleteGraduationDetailSuccess(athleteGraduation: athleteGraduation));
    } catch (e) {
      print('Erro ao obter os detalhes do athleteGraduation: $e');
      emit(AthleteGraduationDetailError());
    }
  }
}
