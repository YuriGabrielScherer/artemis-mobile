import 'package:artemis_mobile/core/enums/enum_athlete_graduation_situation.dart';
import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/models/graduation/athlete/history/athlete_graduation_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class AthleteGraduationTimeline extends StatelessWidget {
  const AthleteGraduationTimeline({required this.graduation, required this.history, Key? key}) : super(key: key);

  final AthleteGraduation graduation;
  final List<AthleteGraduationHistory> history;

  Color getColor({required EnumAthleteGraduationSituation situation, AthleteGraduationHistory? history}) {
    if (history == null) {
      return Colors.grey;
    }

    if (situation == EnumAthleteGraduationSituation.disapproved || situation == EnumAthleteGraduationSituation.disapprovedPaymentNotFound) {
      return Colors.red;
    }

    if (situation == EnumAthleteGraduationSituation.paymentDisapproved) {
      return Colors.orange;
    }

    return Colors.green;
  }

  List<EnumAthleteGraduationSituation> get timelineSituations {
    final output = List<EnumAthleteGraduationSituation>.of([
      EnumAthleteGraduationSituation.registered,
      EnumAthleteGraduationSituation.waitingPaymentApproval,
    ], growable: true);

    switch (graduation.situation) {
      case EnumAthleteGraduationSituation.registered:
      case EnumAthleteGraduationSituation.waitingPaymentApproval:
      case EnumAthleteGraduationSituation.paymentApproved:
      case EnumAthleteGraduationSituation.approved:
        output.addAll([
          EnumAthleteGraduationSituation.paymentApproved,
          EnumAthleteGraduationSituation.approved,
        ]);
        break;
      case EnumAthleteGraduationSituation.disapproved:
        output.addAll([
          EnumAthleteGraduationSituation.paymentApproved,
          EnumAthleteGraduationSituation.disapproved,
        ]);
        break;
      case EnumAthleteGraduationSituation.missing:
        output.addAll([
          EnumAthleteGraduationSituation.paymentApproved,
          EnumAthleteGraduationSituation.missing,
        ]);
        break;
      default:
        output.add(graduation.situation);
    }

    return output;
  }

  @override
  Widget build(BuildContext context) {
    return FixedTimeline(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: const ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xffd3d3d3),
        ),
        indicatorTheme: const IndicatorThemeData(size: 20.0),
      ),
      children: timelineSituations.map((situation) {
        final int currentHistoryIndex = history.indexWhere((his) => his.situation == situation);
        final AthleteGraduationHistory? currentHistory = currentHistoryIndex == -1 ? null : history[currentHistoryIndex];

        final Color connectColor = getColor(situation: situation, history: currentHistory);

        return TimelineTile(
          contents: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: TimelineItem(
              situation: situation,
              history: currentHistory,
            ),
          ),
          node: TimelineNode(
            startConnector: SolidLineConnector(color: connectColor),
            endConnector: SolidLineConnector(color: connectColor),
            indicator: _CustomDotIndicator(
              icon: situation.icon,
              backgroundColor: connectColor,
              iconColor: Colors.white,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class TimelineItem extends StatelessWidget {
  const TimelineItem({
    this.history,
    required this.situation,
    Key? key,
  }) : super(key: key);

  final AthleteGraduationHistory? history;
  final EnumAthleteGraduationSituation situation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history?.situation.name ?? situation.name,
              style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black),
            ),
            const SizedBox(height: 4),
            history != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (history!.situation == EnumAthleteGraduationSituation.paymentApproved || history!.situation == EnumAthleteGraduationSituation.paymentDisapproved) ...[
                        Text(
                          'Responsável: ${history!.createdBy}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 0),
                      ],
                      Text(
                        DateFormat('dd/MM/yyyy').format(history!.createdDate),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                : const Text(
                    'Pendente',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}

class _CustomDotIndicator extends StatelessWidget {
  const _CustomDotIndicator({
    required this.icon,
    required this.iconColor,
    this.backgroundColor = Colors.grey,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DotIndicator(
      color: backgroundColor,
      child: Icon(
        icon,
        size: 12,
        color: iconColor,
      ),
    );
  }
}
