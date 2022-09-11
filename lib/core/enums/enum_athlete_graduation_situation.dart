import 'package:flutter/material.dart';

enum EnumAthleteGraduationSituation {
  registered,
  waitingPaymentApproval,
  paymentApproved,
  paymentDisapproved,
  missing,
  approved,
  disapproved,
  disapprovedPaymentNotFound;
}

extension EnumAthleteGraduationSituationExtesion on EnumAthleteGraduationSituation {
  static EnumAthleteGraduationSituation fromName(String name) {
    switch (name) {
      case 'WAITING_PAYMENT_APPROVAL':
        return EnumAthleteGraduationSituation.waitingPaymentApproval;
      case 'PAYMENT_APPROVED':
        return EnumAthleteGraduationSituation.paymentApproved;
      case 'PAYMENT_DISAPPROVED':
        return EnumAthleteGraduationSituation.paymentDisapproved;
      case 'MISSING':
        return EnumAthleteGraduationSituation.missing;
      case 'APPROVED':
        return EnumAthleteGraduationSituation.approved;
      case 'DISAPPROVED':
        return EnumAthleteGraduationSituation.disapproved;
      case 'DISAPPROVED_PAYMENT_NOT_FOUND':
        return EnumAthleteGraduationSituation.disapprovedPaymentNotFound;
      case 'REGISTERED':
      default:
        return EnumAthleteGraduationSituation.registered;
    }
  }

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
      case EnumAthleteGraduationSituation.waitingPaymentApproval:
        return 'Pagamento realizado';
      case EnumAthleteGraduationSituation.paymentApproved:
        return 'Pagamento aprovado';
      case EnumAthleteGraduationSituation.paymentDisapproved:
        return 'Pagamento negado';
      case EnumAthleteGraduationSituation.disapprovedPaymentNotFound:
        return 'Reprovado por falta de pagamento';
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
      case EnumAthleteGraduationSituation.paymentDisapproved:
      case EnumAthleteGraduationSituation.waitingPaymentApproval:
        return Colors.orange.shade300;
      case EnumAthleteGraduationSituation.disapproved:
      case EnumAthleteGraduationSituation.disapprovedPaymentNotFound:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Color get textColor {
    switch (this) {
      case EnumAthleteGraduationSituation.missing:
      case EnumAthleteGraduationSituation.waitingPaymentApproval:
      case EnumAthleteGraduationSituation.registered:
      case EnumAthleteGraduationSituation.paymentDisapproved:
        return Colors.black;
      default:
        return Colors.white;
    }
  }

  IconData get icon {
    switch (this) {
      case EnumAthleteGraduationSituation.registered:
        return Icons.edit_rounded;
      case EnumAthleteGraduationSituation.waitingPaymentApproval:
        return Icons.hourglass_empty_rounded;
      case EnumAthleteGraduationSituation.paymentApproved:
        return Icons.paid_outlined;
      case EnumAthleteGraduationSituation.approved:
        return Icons.check_rounded;
      case EnumAthleteGraduationSituation.disapproved:
      case EnumAthleteGraduationSituation.missing:
      default:
        return Icons.close_rounded;
    }
  }
}
