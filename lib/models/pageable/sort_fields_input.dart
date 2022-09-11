import '../../core/enums/enum_sort.dart';

class SortField {
  const SortField({
    this.property = 'id',
    this.direction = EnumSort.desc,
  });

  final String property;
  final EnumSort direction;

  @override
  String toString() {
    return '{property: $property, direction: $direction}';
  }

  Map<String, dynamic> get toMap {
    return {
      'property': property,
      'direction': direction.name,
    };
  }
}
