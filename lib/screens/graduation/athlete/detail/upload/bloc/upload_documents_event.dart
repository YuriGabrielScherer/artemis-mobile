part of 'upload_documents_bloc.dart';

class UploadDocumentsEvent extends Equatable {
  const UploadDocumentsEvent({
    required this.file,
  });

  final File file;

  @override
  List<Object> get props => [file];
}
