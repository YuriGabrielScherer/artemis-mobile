import 'package:artemis_mobile/core/enums/enum_graduation_situation.dart';
import 'package:artemis_mobile/models/graduation/history/graduation_history.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class GraduationDetailTimeline extends StatelessWidget {
  const GraduationDetailTimeline({required this.history, Key? key}) : super(key: key);
  final List<GraduationHistory> history;

  Color getColor({required EnumGraduationSituation situation, required bool isCanceled, GraduationHistory? history}) {
    if (isCanceled == true) {
      if (situation == EnumGraduationSituation.canceled) {
        return Colors.red;
      }

      return Colors.grey;
    }

    if (history == null) {
      return Colors.grey;
    }

    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    final isCanceled = history.any((h) => h.situation == EnumGraduationSituation.canceled);
    return FixedTimeline(
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: const ConnectorThemeData(
          thickness: 3.0,
          color: Color(0xffd3d3d3),
        ),
        indicatorTheme: const IndicatorThemeData(size: 20.0),
      ),
      children: EnumGraduationSituation.values.map((situation) {
        final int currentHistoryIndex = history.indexWhere((his) => his.situation == situation);
        final GraduationHistory? currentHistory = currentHistoryIndex == -1 ? null : history[currentHistoryIndex];

        return TimelineTile(
          contents: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: TimelineItem(
              situation: situation,
              history: currentHistory,
            ),
          ),
          node: TimelineNode(
            indicator: _CustomDotIndicator(
              icon: situation.icon,
              backgroundColor: getColor(situation: situation, isCanceled: isCanceled, history: currentHistory),
              iconColor: Colors.white,
            ),
            startConnector: SolidLineConnector(
              color: getColor(situation: situation, isCanceled: isCanceled, history: currentHistory),
            ),
            endConnector: SolidLineConnector(
              color: getColor(situation: situation, isCanceled: isCanceled, history: currentHistory),
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

  final GraduationHistory? history;
  final EnumGraduationSituation situation;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          history?.situation.name ?? situation.name,
          style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 4),
        history != null
            ? Text(
                DateFormat('dd/MM/yyyy').format(history!.date),
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            : const Text(
                'Pendente',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
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
