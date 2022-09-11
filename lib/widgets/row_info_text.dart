import 'package:flutter/material.dart';

class RowInfoTextWidget extends StatelessWidget {
  const RowInfoTextWidget({
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                data,
                maxLines: 2,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
