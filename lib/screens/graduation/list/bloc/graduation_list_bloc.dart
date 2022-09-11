import '../../../../core/enums/enum_sort.dart';
import '../../../../models/graduation/dto/graduatin_list_input.dart';
import '../../../../models/pageable/pageable_input.dart';
import '../../../../models/pageable/sort_fields_input.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import '../../../../models/graduation/graduation.dart';
import '../../../../providers/repositories/graduation_repository.dart';
part 'graduation_list_event.dart';
part 'graduation_list_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class GraduationListBloc extends Bloc<GraduationListEvent, GraduationListState> {
  GraduationListBloc(this.repository) : super(const GraduationListState()) {
    on<GraduationListRequest>(_onGraduationListRequest, transformer: throttleDroppable(throttleDuration));
  }

  final IGraduationRepository repository;

  void _onGraduationListRequest(GraduationListRequest event, Emitter<GraduationListState> emit) async {
    if (state.hasReachedMax) return;

    int page = (state.graduations.length / state.size).round();
    // PageableInput pageable = PageableInput(size: state.size, page: page, sortFields: [
    PageableInput pageable = PageableInput(size: 2, page: page, sortFields: [
      const SortField(
        property: 'date',
        direction: EnumSort.desc,
      )
    ]);
    GraduationListInput input = GraduationListInput(pageable: pageable, athletesCode: [event.athleteCode]);

    try {
      if (state.status == EnumGraduationListStatus.initial || state.status == EnumGraduationListStatus.error) {
        emit(state.copyWith(status: EnumGraduationListStatus.loading));
        final posts = await repository.list(pageableInput: input);
        return emit(state.copyWith(
          status: EnumGraduationListStatus.success,
          graduations: posts.records,
          hasReachedMax: posts.records.length == posts.totalRecords,
          totalRecords: posts.totalRecords,
        ));
      }

      final posts = await repository.list(pageableInput: input);
      emit(posts.records.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: EnumGraduationListStatus.success,
              graduations: List.of(state.graduations)..addAll(posts.records),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: EnumGraduationListStatus.error));
    }
  }
}
