part of 'graduation_list_bloc.dart';

enum EnumGraduationListStatus { initial, success, loading, error }

class GraduationListState extends Equatable {
  const GraduationListState({
    this.graduations = const [],
    this.status = EnumGraduationListStatus.initial,
    this.hasReachedMax = false,
    this.totalRecords = 0,
    this.size = 10,
  });

  final List<Graduation> graduations;
  final EnumGraduationListStatus status;
  final bool hasReachedMax;
  final int totalRecords;
  final int size;

  @override
  List<Object> get props => [graduations, status, hasReachedMax, totalRecords, size];

  GraduationListState copyWith({
    List<Graduation>? graduations,
    EnumGraduationListStatus? status,
    bool? hasReachedMax,
    int? totalRecords,
    int? size,
  }) {
    return GraduationListState(
      graduations: graduations ?? this.graduations,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalRecords: totalRecords ?? this.totalRecords,
      size: size ?? this.size,
    );
  }
}
