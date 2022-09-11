import 'dart:convert';

import '../../pageable/pageable_input.dart';

class GraduationListInput {
  final List<int>? athletesCode;
  final PageableInput pageable;

  const GraduationListInput({
    this.athletesCode,
    required this.pageable,
  });

  Map<String, dynamic> get toMap {
    return {
      'athletesCode': '[2L]',
      // 'athletesCode': '[${athletesCode?.join(',')}]',
      'pageable': json.encode(pageable.toMap),
    };
  }
}
