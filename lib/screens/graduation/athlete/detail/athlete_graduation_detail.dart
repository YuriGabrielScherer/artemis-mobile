import 'package:artemis_mobile/core/auth/bloc/auth_bloc.dart';
import 'package:artemis_mobile/core/enums/enum_athlete_graduation_situation.dart';
import 'package:artemis_mobile/core/enums/enum_belt.dart';
import 'package:artemis_mobile/core/getit.dart';
import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/providers/repositories/impl/athlete_repository_impl.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/bloc/athlete_graduation_detail_bloc.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/documents/athlete_graduation_documents.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/timeline/athlete_graduation_timeline.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/upload/upload_documents_button.dart';
import 'package:artemis_mobile/widgets/info_divider.dart';
import 'package:artemis_mobile/widgets/row_info_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AthleteGraduationDetailPage extends StatelessWidget {
  const AthleteGraduationDetailPage({
    required this.athleteGraduation,
    this.onUpdateAthleteGraduation,
    Key? key,
  }) : super(key: key);

  final AthleteGraduation athleteGraduation;
  final VoidCallback? onUpdateAthleteGraduation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AthleteGraduationDetailBloc(repository: getIt.get<AthleteRepository>())..add(AthleteGraduationDetailSearch(athleteGraduation: athleteGraduation)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exame de Graduação'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(12),
          child: AthleteGraduationDetail(),
        ),
        bottomSheet: athleteGraduation.situation == EnumAthleteGraduationSituation.registered
            ? Builder(builder: (context) {
                return UploadDocumentsButton(
                  onUploadFile: () {
                    final athleteCode = context.read<AuthBloc>().state.person!.code;
                    context.read<AthleteGraduationDetailBloc>().add(AthleteGraduationDetailSearch(
                          athleteGraduation: null,
                          athleteCode: athleteCode,
                          graduationCode: athleteGraduation.graduation!.code,
                        ));
                    if (onUpdateAthleteGraduation != null) {
                      onUpdateAthleteGraduation!();
                    }
                  },
                );
              })
            : null,
      ),
    );
  }
}

@visibleForTesting
class AthleteGraduationDetail extends StatelessWidget {
  const AthleteGraduationDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AthleteGraduationDetailBloc, AthleteGraduationDetailState>(
      builder: (context, state) {
        if (state is AthleteGraduationDetailError) {
          return const Text('Ocorreu um erro ao realizar sua requisição');
        }
        if (state is AthleteGraduationDetailSuccess) {
          final AthleteGraduation athleteGraduation = state.athleteGraduation;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (athleteGraduation.graduation != null) ...[
                RowInfoTextWidget(title: 'Graduação', data: athleteGraduation.graduation!.title),
                RowInfoTextWidget(
                  title: 'Data do Exame',
                  data: DateFormat('dd/MM/yyyy').format(athleteGraduation.graduation!.date),
                ),
              ],
              RowInfoTextWidget(title: 'Faixa', data: athleteGraduation.belt.name),
              RowInfoTextWidget(title: 'Situação', data: athleteGraduation.situation.name),
              if (athleteGraduation.situation == EnumAthleteGraduationSituation.approved || athleteGraduation.situation == EnumAthleteGraduationSituation.disapproved)
                RowInfoTextWidget(title: 'Média', data: athleteGraduation.grade.toString()),
              if (athleteGraduation.file != null ||
                  athleteGraduation.situation == EnumAthleteGraduationSituation.registered ||
                  athleteGraduation.situation == EnumAthleteGraduationSituation.waitingPaymentApproval) ...[
                const InfoDivider(),
                Text('Documentos enviados', style: Theme.of(context).textTheme.caption),
                const SizedBox(height: 8),
                AthleteGraduationDocuments(athleteGraduation: athleteGraduation),
              ],
              const InfoDivider(),
              Text('Histórico', style: Theme.of(context).textTheme.caption),
              const SizedBox(height: 8),
              AthleteGraduationTimeline(graduation: athleteGraduation, history: athleteGraduation.history),
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
