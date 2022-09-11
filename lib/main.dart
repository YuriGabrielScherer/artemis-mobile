import 'package:artemis_mobile/core/bloc_observer.dart';
import 'package:bloc/bloc.dart';

import 'core/getit.dart';

import 'package:flutter/material.dart';

import 'package:artemis_mobile/screens/app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  Bloc.observer = MyBlocObserver();

  runApp(const App());
}
