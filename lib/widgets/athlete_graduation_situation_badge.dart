import '../core/enums/enum_athlete_graduation_situation.dart';
import 'package:flutter/material.dart';

class AthleteGraduationSituationBadge extends StatelessWidget {
  const AthleteGraduationSituationBadge({required this.situation, Key? key}) : super(key: key);

  final EnumAthleteGraduationSituation situation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: situation.color,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        situation.name,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: situation.textColor,
        ),
      ),
    );
  }
}
