import 'dart:math';

import 'package:artemis_mobile/models/graduation/graduation.dart';
import 'package:artemis_mobile/providers/repositories/athlete_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'graduation_card_event.dart';
part 'graduation_card_state.dart';

class GraduationCardBloc extends Bloc<GraduationCardEvent, GraduationCardState> {
  GraduationCardBloc({required IAthleteRepository repository})
      : _repository = repository,
        super(GraduationCardInitial()) {
    on<GraduationCardRequest>(_onRequest);
  }

  final IAthleteRepository _repository;

  void _onRequest(GraduationCardRequest event, Emitter<GraduationCardState> emit) async {
    emit(GraduationCardLoading());

    await Future<void>.delayed(const Duration(seconds: 2));

    try {
      if (Random().nextBool()) {
        final graduation = await _repository.getGraduation(event.athleteCode);
        emit(
          GraduationCardSuccess(graduation),
        );
      } else {
        emit(GraduationCardEmpty());
      }
    } catch (_) {
      emit(GraduationCardError());
    }
  }
}
