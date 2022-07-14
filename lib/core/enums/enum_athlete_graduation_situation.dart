import 'package:flutter/material.dart';

enum EnumAthleteGraduationSituation {
  registered,
  missing,
  approved,
  disapproved;
}

extension EnumAthleteGraduationSituationExtesion on EnumAthleteGraduationSituation {
  String get name {
    switch (this) {
      case EnumAthleteGraduationSituation.registered:
        return 'Inscrito';
      case EnumAthleteGraduationSituation.missing:
        return 'Faltante';
      case EnumAthleteGraduationSituation.approved:
        return 'Aprovado';
      case EnumAthleteGraduationSituation.disapproved:
        return 'Reprovado';
      default:
        return 'Something Went Wrong.';
    }
  }

  Color get color {
    switch (this) {
      case EnumAthleteGraduationSituation.registered:
        return Colors.blue.shade200;
      case EnumAthleteGraduationSituation.approved:
        return Colors.green;
      case EnumAthleteGraduationSituation.missing:
        return Colors.orange.shade300;
      case EnumAthleteGraduationSituation.disapproved:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (this) {
      case EnumAthleteGraduationSituation.missing:
      case EnumAthleteGraduationSituation.registered:
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case EnumAthleteGraduationSituation.registered:
        return Icons.edit_rounded;
      case EnumAthleteGraduationSituation.missing:
        return Icons.lock_open_rounded;
      case EnumAthleteGraduationSituation.approved:
        return Icons.lock_rounded;
      case EnumAthleteGraduationSituation.disapproved:
        return Icons.check_rounded;
      default:
        return Icons.close_rounded;
    }
  }
}
