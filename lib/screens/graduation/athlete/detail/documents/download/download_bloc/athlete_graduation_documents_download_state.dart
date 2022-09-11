part of 'athlete_graduation_documents_download_bloc.dart';

abstract class AthleteGraduationDocumentsDownloadState extends Equatable {
  const AthleteGraduationDocumentsDownloadState();

  @override
  List<Object> get props => [];
}

class AthleteGraduationDocumentsDownloadInitial extends AthleteGraduationDocumentsDownloadState {}

class AthleteGraduationDocumentsDownloadSuccess extends AthleteGraduationDocumentsDownloadState {}

class AthleteGraduationDocumentsDownloadProgress extends AthleteGraduationDocumentsDownloadState {
  final int progress;
  const AthleteGraduationDocumentsDownloadProgress({
    required this.progress,
  });

  @override
  List<Object> get props => [progress];
}

class AthleteGraduationDocumentsDownloadError extends AthleteGraduationDocumentsDownloadState {}
