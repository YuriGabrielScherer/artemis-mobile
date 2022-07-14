import '../../../core/enums/enum_graduation_situation.dart';
import '../../../models/graduation/graduation.dart';
import 'timeline/graduation_detail_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraduationDetailPage extends StatelessWidget {
  const GraduationDetailPage({required this.graduation, Key? key}) : super(key: key);

  final Graduation graduation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              graduation.title,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                  ),
            ),
            const SizedBox(height: 12),
            InfoTextWidget(title: 'Situação', data: graduation.situation.name),
            if (graduation.place != null) InfoTextWidget(title: 'Local', data: graduation.place!),
            InfoTextWidget(title: 'Data', data: DateFormat('dd/MM/yyyy').format(graduation.date)),
            if (graduation.description != null) ...[
              Text('Descrição', style: Theme.of(context).textTheme.caption),
              Text(graduation.description!),
              const SizedBox(height: 8),
            ],
            const InfoDivider(),
            const InfoTextWidget(title: 'Professor vinculados', data: '8'),
            const InfoTextWidget(title: 'Atletas participantes', data: '18'),
            const InfoDivider(),
            Text('Histórico', style: Theme.of(context).textTheme.caption),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: GraduationDetailTimeline(
                  history: graduation.history,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: graduation.situation == EnumGraduationSituation.openSubscription
          ? BottomSheetWidget(graduation: graduation)
          : null,
    );
  }
}

class InfoTextWidget extends StatelessWidget {
  const InfoTextWidget({
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

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({required this.graduation, Key? key}) : super(key: key);

  final Graduation graduation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Inscrevido!'),
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          child: const Text('Inscreva-se!'),
        ),
      ),
    );
  }
}
