import 'package:flutter/material.dart';

class InfoTextWidget extends StatelessWidget {
  const InfoTextWidget({
    required this.title,
    required this.data,
    this.columnReverse = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final String data;
  final bool columnReverse;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: columnReverse ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        const SizedBox(width: 8),
        Text(
          data,
          maxLines: 2,
          textAlign: TextAlign.end,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
