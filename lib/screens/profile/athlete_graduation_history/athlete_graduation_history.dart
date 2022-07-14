import 'package:artemis_mobile/core/enums/enum_belt.dart';
import 'package:artemis_mobile/core/getit.dart';
import 'package:artemis_mobile/models/person/person.dart';
import 'package:artemis_mobile/providers/repositories/impl/athlete_repository_impl.dart';
import 'package:artemis_mobile/screens/profile/athlete_graduation_history/bloc/athlete_graduation_history_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/enum_sort.dart';
import '../../../models/graduation/athlete/athlete_graduation.dart';
import '../../../models/graduation/professor/graduation_grade.dart';
import '../../../widgets/athlete_graduation_situation_badge.dart';
import '../../../widgets/list_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AthleteGraduationHistory extends StatelessWidget {
  const AthleteGraduationHistory({required this.person, Key? key}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Graduações'),
      ),
      body: BlocProvider(
        create: (context) => AthleteGraduationHistoryBloc(getIt.get<AthleteRepository>())
          ..add(AthleteGraduationHistoryRequest(athleteCode: person.code)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<AthleteGraduationHistoryBloc, AthleteGraduationHistoryState>(
            builder: (context, state) {
              if (state is AthleteGraduationHistoryLoading || state is AthleteGraduationHistoryInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AthleteGraduationHistoryError) {
                return ElevatedButton(
                  onPressed: () {
                    context
                        .read<AthleteGraduationHistoryBloc>()
                        .add(AthleteGraduationHistoryRequest(athleteCode: person.code));
                  },
                  child: const Text('Tentar novamente'),
                );
              }

              final List<AthleteGraduation> graduations = (state as AthleteGraduationHistorySuccess).athleteGraduations;

              return Column(
                children: [
                  ListHeader(
                    totalRecords: graduations.length,
                    sort: EnumSort.asc,
                    onSort: (_) {},
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GraduationList(graduations: graduations),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class GraduationList extends StatelessWidget {
  const GraduationList({required this.graduations, Key? key}) : super(key: key);
  final List<AthleteGraduation> graduations;

  @override
  Widget build(BuildContext context) {
    if (true) {
      return ListView.separated(
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: graduations.length,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          final athleteGraduation = graduations[index];
          return ExpandableNotifier(
            child: Material(
              color: Colors.grey.shade100,
              elevation: 2.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4),
              child: Expandable(
                collapsed: ExpandableButton(
                  child: CardHeader(athleteGraduation: athleteGraduation),
                ),
                expanded: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      ExpandableButton(child: CardHeader(athleteGraduation: athleteGraduation)),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, right: 6, left: 6),
                        child: CardBody(grades: athleteGraduation.gradeDetail),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: ExpandableButton(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Ocultar',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
  }
}

class CardHeader extends StatelessWidget {
  const CardHeader({
    required this.athleteGraduation,
    Key? key,
  }) : super(key: key);

  final AthleteGraduation athleteGraduation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AthleteGraduationSituationBadge(situation: athleteGraduation.situation),
              const Spacer(),
              if (athleteGraduation.graduation != null) ...[
                const Icon(Icons.calendar_month_rounded, size: 16),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd/MM/yyyy').format(athleteGraduation.graduation!.date),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Faixa ${athleteGraduation.belt.name}',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (athleteGraduation.graduation != null)
                    Text(
                      athleteGraduation.graduation!.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (athleteGraduation.grade > 0) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Média: ${athleteGraduation.roundedGrade}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ]
                ],
              ),
              const Icon(Icons.arrow_downward_rounded),
            ],
          ),
        ],
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({
    required this.grades,
    Key? key,
  }) : super(key: key);
  final List<GraduationGrade> grades;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, left: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notas recebidas por professor',
            style: Theme.of(context).textTheme.caption,
          ),
          ListView.separated(
            shrinkWrap: true,
            itemCount: grades.length,
            itemBuilder: (_, __) => const SizedBox(height: 4),
            separatorBuilder: (_, index) {
              final GraduationGrade grade = grades[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _InfoTextWidget(title: 'Professor:', data: grade.professor.name),
                  _InfoTextWidget(title: 'Nota:', data: grade.roundedGrade),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InfoTextWidget extends StatelessWidget {
  const _InfoTextWidget({
    required this.title,
    required this.data,
    Key? key,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
        const Spacer(),
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
