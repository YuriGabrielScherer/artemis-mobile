import 'package:artemis_mobile/providers/repositories/graduation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_graduation_documents_download_event.dart';
part 'athlete_graduation_documents_download_state.dart';

class AthleteGraduationDocumentsDownloadBloc extends Bloc<AthleteGraduationDocumentsDownloadEvent, AthleteGraduationDocumentsDownloadState> {
  AthleteGraduationDocumentsDownloadBloc({
    required IGraduationRepository graduationRepository,
  })  : _graduationRepository = graduationRepository,
        super(AthleteGraduationDocumentsDownloadInitial()) {
    on<AthleteGraduationDocumentsDownloadRequestEvent>(_athleteGraduationDocumentsRequestDownload);
    on<AthleteGraduationDocumentsDownloadProgressEvent>(_athleteGraduationDocumentsDownloadProgressEvent);
  }

  final IGraduationRepository _graduationRepository;

  void _athleteGraduationDocumentsRequestDownload(AthleteGraduationDocumentsDownloadRequestEvent event, Emitter emit) async {
    emit(const AthleteGraduationDocumentsDownloadProgress(progress: 0));
    try {
      await _graduationRepository.downloadAthleteGraduationFile(
        graduationCode: event.graduationCode,
        athleteCode: event.athleteCode,
        progressCallback: (count, total) {
          final progress = count * 100 ~/ total;
          add(AthleteGraduationDocumentsDownloadProgressEvent(progress: progress));
        },
      );
    } catch (e) {
      print('Error: $e');
      emit(AthleteGraduationDocumentsDownloadError());
    }
  }

  void _athleteGraduationDocumentsDownloadProgressEvent(AthleteGraduationDocumentsDownloadProgressEvent event, Emitter emit) async {
    if (event.progress == 100) {
      emit(AthleteGraduationDocumentsDownloadSuccess());
    } else {
      emit(AthleteGraduationDocumentsDownloadProgress(progress: event.progress));
    }
  }
}
