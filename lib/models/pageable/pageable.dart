class Pageable<T> {
  const Pageable({
    required this.totalRecords,
    required this.records,
  });

  final int totalRecords;
  final List<T> records;
}
