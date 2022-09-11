import 'package:artemis_mobile/widgets/info_divider.dart';
import 'package:artemis_mobile/widgets/row_info_text.dart';

import '../../../../core/enums/enum_graduation_situation.dart';
import '../../../../models/graduation/graduation.dart';

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
            RowInfoTextWidget(title: 'Situação', data: graduation.situation.name),
            if (graduation.place != null) RowInfoTextWidget(title: 'Local', data: graduation.place!),
            RowInfoTextWidget(title: 'Data', data: DateFormat('dd/MM/yyyy').format(graduation.date)),
            if (graduation.description != null) ...[
              Text('Descrição', style: Theme.of(context).textTheme.caption),
              Text(graduation.description!),
              const SizedBox(height: 8),
            ],
            const InfoDivider(),
            const RowInfoTextWidget(title: 'Professor vinculados', data: '8'),
            const RowInfoTextWidget(title: 'Atletas participantes', data: '18'),
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
      bottomSheet: graduation.situation == EnumGraduationSituation.openSubscription ? BottomSheetWidget(graduation: graduation) : null,
    );
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
