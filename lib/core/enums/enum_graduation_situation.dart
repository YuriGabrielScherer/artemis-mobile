import 'package:flutter/material.dart';

enum EnumGraduationSituation {
  created,
  openSubscription,
  closeSubscription,
  finished,
  canceled;
}

extension EnumGraduationSituationExtension on EnumGraduationSituation {
  static EnumGraduationSituation fromName(String name) {
    switch (name) {
      case 'OPEN_SUBSCRIPTION':
        return EnumGraduationSituation.openSubscription;
      case 'CLOSE_SUBSCRIPTION':
        return EnumGraduationSituation.closeSubscription;
      case 'CANCELED':
        return EnumGraduationSituation.canceled;
      case 'FINISHED':
        return EnumGraduationSituation.finished;
      case ' CREATED':
      default:
        return EnumGraduationSituation.created;
    }
  }

  String get name {
    switch (this) {
      case EnumGraduationSituation.created:
        return 'Criado';
      case EnumGraduationSituation.openSubscription:
        return 'Inscrições abertas';
      case EnumGraduationSituation.closeSubscription:
        return 'Inscrições encerradas';
      case EnumGraduationSituation.finished:
        return 'Finalizado';
      case EnumGraduationSituation.canceled:
        return 'Cancelado';
      default:
        return 'Something Went Wrong.';
    }
  }

  Color get color {
    switch (this) {
      case EnumGraduationSituation.created:
      case EnumGraduationSituation.closeSubscription:
        return Colors.grey.shade600;
      // return Colors.green.shade300;
      case EnumGraduationSituation.openSubscription:
        return Colors.yellowAccent;
      case EnumGraduationSituation.finished:
        return Colors.green;
      case EnumGraduationSituation.canceled:
        return Colors.red.shade400;
      default:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (this) {
      case EnumGraduationSituation.openSubscription:
        return Colors.black;
      case EnumGraduationSituation.closeSubscription:
      case EnumGraduationSituation.created:
      case EnumGraduationSituation.canceled:
      default:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case EnumGraduationSituation.created:
        return Icons.edit_rounded;
      case EnumGraduationSituation.openSubscription:
        return Icons.lock_open_rounded;
      case EnumGraduationSituation.closeSubscription:
        return Icons.lock_rounded;
      case EnumGraduationSituation.finished:
        return Icons.check_rounded;
      case EnumGraduationSituation.canceled:
      default:
        return Icons.close_rounded;
    }
  }
}
