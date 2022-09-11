import 'dart:io';

import 'package:artemis_mobile/providers/repositories/graduation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_graduation_documents_event.dart';
part 'athlete_graduation_documents_state.dart';

class AthleteGraduationDocumentsBloc extends Bloc<AthleteGraduationDocumentsEvent, AthleteGraduationDocumentsState> {
  AthleteGraduationDocumentsBloc({
    required IGraduationRepository graduationRepository,
  })  : _graduationRepository = graduationRepository,
        super(AthleteGraduationDocumentsInitial()) {
    on<AthleteGraduationDocumentsListEvent>(_athleteGraduationDocumentsListDownloadEvent);
    on<AthleteGraduationDocumentsRemoveEvent>(_athleteGraduationDocumentsRemoveEvent);
  }

  final IGraduationRepository _graduationRepository;

  void _athleteGraduationDocumentsListDownloadEvent(AthleteGraduationDocumentsListEvent event, Emitter emit) async {
    emit(AthleteGraduationDocumentsLoading());
    try {
      final files = (await _graduationRepository.listDownloadedFiles(
        athleteCode: event.athleteCode,
        graduationCode: event.graduationCode,
      ))
          .map((e) => File(e.path))
          .toList();
      emit(AthleteGraduationDocumentsSuccess(files: files));
    } catch (e) {
      print('Error: $e');
      emit(const AthleteGraduationDocumentsError());
    }
  }

  void _athleteGraduationDocumentsRemoveEvent(AthleteGraduationDocumentsRemoveEvent event, Emitter emit) async {
    emit(AthleteGraduationDocumentsLoading());
    try {
      await event.file.delete();
      add(AthleteGraduationDocumentsListEvent(
        athleteCode: event.athleteCode,
        graduationCode: event.graduationCode,
      ));
    } catch (e) {
      print('RemoveFailed: $e');
      emit(const AthleteGraduationDocumentsError(error: EnumAthleteGraduationDocumentsError.delete));
    }
  }
}
