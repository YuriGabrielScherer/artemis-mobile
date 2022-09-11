import '../../../core/enums/enum_belt.dart';
import '../../../core/getit.dart';
import '../../../models/athlete/athlete.dart';
import '../../../models/person/person.dart';
import '../../../providers/repositories/impl/athlete_repository_impl.dart';
import 'bloc/athlete_info_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/info_text_widget.dart';

class ProfileAthleteInfo extends StatelessWidget {
  const ProfileAthleteInfo({required this.person, Key? key}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AthleteInfoBloc(getIt.get<AthleteRepository>())..add(AthleteInfoRequest(athleteCode: person.code)),
      child: BlocBuilder<AthleteInfoBloc, AthleteInfoState>(
        builder: (context, state) {
          if (state is AthleteInfoLoading || state is AthleteInfoInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AthleteInfoError) {
            return ElevatedButton(
              onPressed: () {
                context.read<AthleteInfoBloc>().add(AthleteInfoRequest(athleteCode: person.code));
              },
              child: const Text('Tentar novamente'),
            );
          }

          final Athlete athlete = (state as AthleteInfoSuccess).athlete;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: Colors.grey),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoTextWidget(title: 'Graduação', data: athlete.currentBelt.name),
                  const InfoTextWidget(
                    title: 'Nesta graduação há',
                    data: '3 meses', // Ajustar para calcular corretamente
                    columnReverse: true,
                  ),
                ],
              ),
              InfoTextWidget(title: 'Atleta desde', data: DateFormat('dd/MM/yyyy').format(athlete.since)),
            ],
          );
        },
      ),
    );
  }
}
