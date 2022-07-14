enum EnumSort {
  asc,
  desc;
}

extension EnumSortExtension on EnumSort {
  String get name {
    switch (this) {
      case EnumSort.asc:
        return 'ASC';
      case EnumSort.desc:
      default:
        return 'DESC';
    }
  }
}
