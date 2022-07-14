import 'package:artemis_mobile/models/pageable/sort_fields_input.dart';

class PageableInput {
  const PageableInput({
    this.page = 0,
    this.size = 10,
    this.sortFields = const [
      SortField(),
    ],
  });

  final int page;
  final int size;
  final List<SortField> sortFields;

  @override
  String toString() {
    return '{page: $page, size: $size, sortFields: ${sortFields.map((e) => e.toString()).toList()}}';
  }

  Map<String, dynamic> get toMap {
    return {
      'page': page.toString(),
      'size': size.toString(),
      'sortFields': sortFields.map((e) => e.toMap).toList(),
    };
  }
}
