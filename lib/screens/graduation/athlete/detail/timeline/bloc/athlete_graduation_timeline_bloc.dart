import 'package:artemis_mobile/providers/repositories/graduation_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'athlete_graduation_timeline_event.dart';
part 'athlete_graduation_timeline_state.dart';

class AthleteGraduationTimelineBloc extends Bloc<AthleteGraduationTimelineEvent, AthleteGraduationTimelineState> {
  AthleteGraduationTimelineBloc({required IGraduationRepository graduationRepository})
      : _graduationRepository = graduationRepository,
        super(AthleteGraduationTimelineInitial()) {
    on<AthleteGraduationTimelineDownload>(_athleteGraduationTimelineDownload);
  }

  final IGraduationRepository _graduationRepository;

  void _athleteGraduationTimelineDownload(AthleteGraduationTimelineDownload event, Emitter emit) async {
    emit(AthleteGraduationTimelineLoading());
  }
}
