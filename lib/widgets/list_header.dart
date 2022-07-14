import '../core/enums/enum_sort.dart';
import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    required this.totalRecords,
    required this.onSort,
    required this.sort,
    Key? key,
  }) : super(key: key);

  final int totalRecords;
  final Function(EnumSort) onSort;
  final EnumSort sort;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            if (sort == EnumSort.asc) {
              onSort(EnumSort.desc);
            } else {
              onSort(EnumSort.asc);
            }
          },
          child: Row(
            children: const [
              Icon(Icons.sort_rounded),
              SizedBox(width: 4),
              Text('Ordenar'),
            ],
          ),
        ),
        const Spacer(),
        Text('$totalRecords registros encontrados'),
      ],
    );
  }
}
