import 'package:artemis_mobile/core/getit.dart';

import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:intl/date_symbol_data_local.dart';

import 'package:artemis_mobile/screens/app/app.dart';

void main() {
  setupGetIt();
  // Intl.defaultLocale = 'pt_BR';
  // initializeDateFormatting('de_DE', null).then(formatDates);
  runApp(const App());
}
