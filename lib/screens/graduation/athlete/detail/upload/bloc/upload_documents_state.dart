part of 'upload_documents_bloc.dart';

abstract class UploadDocumentsState extends Equatable {
  const UploadDocumentsState();

  @override
  List<Object> get props => [];
}

class UploadDocumentsInitial extends UploadDocumentsState {}

class UploadDocumentsLoading extends UploadDocumentsState {}

class UploadDocumentsSuccess extends UploadDocumentsState {}

class UploadDocumentsError extends UploadDocumentsState {}
