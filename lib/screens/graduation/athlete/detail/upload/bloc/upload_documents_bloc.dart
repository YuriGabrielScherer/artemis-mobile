import 'dart:io';

import 'package:artemis_mobile/providers/repositories/graduation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_documents_event.dart';
part 'upload_documents_state.dart';

class UploadDocumentsBloc extends Bloc<UploadDocumentsEvent, UploadDocumentsState> {
  UploadDocumentsBloc({required IGraduationRepository repository})
      : _repository = repository,
        super(UploadDocumentsInitial()) {
    on<UploadDocumentsEvent>(_onUploadEvent);
  }

  final IGraduationRepository _repository;

  void _onUploadEvent(UploadDocumentsEvent event, Emitter emit) async {
    emit(UploadDocumentsLoading());
    try {
      await _repository.uploadAthleteGraduationFile(file: event.file);
      emit(UploadDocumentsSuccess());
    } catch (e) {
      print('erro ao realizar o upload: $e');
      emit(UploadDocumentsError());
    }
  }
}
