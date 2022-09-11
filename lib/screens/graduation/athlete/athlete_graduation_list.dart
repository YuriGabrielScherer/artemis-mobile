import 'package:artemis_mobile/screens/graduation/athlete/detail/athlete_graduation_detail.dart';

import '../../../core/auth/bloc/auth_bloc.dart';
import '../../../core/enums/enum_belt.dart';
import '../../../core/getit.dart';
import '../../../providers/repositories/impl/athlete_repository_impl.dart';
import 'bloc/athlete_graduation_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/enum_sort.dart';
import '../../../models/graduation/athlete/athlete_graduation.dart';
import '../../../widgets/athlete_graduation_situation_badge.dart';
import '../../../widgets/list_header.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AthleteGraduationListPage extends StatelessWidget {
  const AthleteGraduationListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final person = context.read<AuthBloc>().state.person!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Graduações'),
      ),
      body: BlocProvider(
        create: (context) => AthleteGraduationListBloc(getIt.get<AthleteRepository>())..add(AthleteGraduationListRequest(athleteCode: person.code)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: BlocBuilder<AthleteGraduationListBloc, AthleteGraduationListState>(
            builder: (context, state) {
              if (state is AthleteGraduationListLoading || state is AthleteGraduationListInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is AthleteGraduationListError) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<AthleteGraduationListBloc>().add(AthleteGraduationListRequest(athleteCode: person.code));
                  },
                  child: const Text('Tentar novamente'),
                );
              }

              final List<AthleteGraduation> graduations = (state as AthleteGraduationListSuccess).athleteGraduations;

              if (graduations.isEmpty) {
                return const Center(
                  child: Text('Nenhuma graduação encontrada.'),
                );
              }

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

@visibleForTesting
class GraduationList extends StatelessWidget {
  const GraduationList({required this.graduations, Key? key}) : super(key: key);

  final List<AthleteGraduation> graduations;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: graduations.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final athleteGraduation = graduations[index];
        return Card(athleteGraduation: athleteGraduation);
      },
    );
  }
}

@visibleForTesting
class Card extends StatelessWidget {
  const Card({required this.athleteGraduation, Key? key}) : super(key: key);

  final AthleteGraduation athleteGraduation;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.grey.shade100,
      shadowColor: Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => AthleteGraduationDetailPage(
                athleteGraduation: athleteGraduation,
                onUpdateAthleteGraduation: () {
                  final athleteCode = context.read<AuthBloc>().state.person!.code;
                  context.read<AthleteGraduationListBloc>().add(AthleteGraduationListRequest(athleteCode: athleteCode));
                },
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(4),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
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
                      if (athleteGraduation.graduation != null) ...[
                        Text(
                          athleteGraduation.graduation!.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (athleteGraduation.graduation!.description != null)
                          Text(
                            athleteGraduation.graduation!.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
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
                  const Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
