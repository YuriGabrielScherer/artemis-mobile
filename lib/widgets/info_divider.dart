import 'package:flutter/material.dart';

class InfoDivider extends StatelessWidget {
  const InfoDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      SizedBox(height: 4),
      Divider(color: Colors.black),
      SizedBox(height: 12),
    ]);
  }
}
