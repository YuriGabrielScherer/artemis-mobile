part of 'athlete_graduation_documents_download_bloc.dart';

abstract class AthleteGraduationDocumentsDownloadEvent extends Equatable {
  const AthleteGraduationDocumentsDownloadEvent();

  @override
  List<Object> get props => [];
}

class AthleteGraduationDocumentsDownloadRequestEvent extends AthleteGraduationDocumentsDownloadEvent {
  final int graduationCode;
  final int athleteCode;
  const AthleteGraduationDocumentsDownloadRequestEvent({required this.graduationCode, required this.athleteCode});
  @override
  List<Object> get props => [graduationCode, athleteCode];
}

class AthleteGraduationDocumentsDownloadProgressEvent extends AthleteGraduationDocumentsDownloadEvent {
  final int progress;
  const AthleteGraduationDocumentsDownloadProgressEvent({
    this.progress = 0,
  });
  @override
  List<Object> get props => [progress];
}
