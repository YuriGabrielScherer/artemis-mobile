import 'package:artemis_mobile/core/enums/enum_belt.dart';
import 'package:artemis_mobile/core/getit.dart';
import 'package:artemis_mobile/models/athlete/athlete.dart';
import 'package:artemis_mobile/models/person/person.dart';
import 'package:artemis_mobile/providers/repositories/impl/athlete_repository_impl.dart';
import 'package:artemis_mobile/screens/profile/athlete_graduation_history/athlete_graduation_history.dart'
    show AthleteGraduationHistory;
import 'package:artemis_mobile/screens/profile/athlete_info/bloc/athlete_info_bloc.dart';
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
              Material(
                borderRadius: BorderRadius.circular(4),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => AthleteGraduationHistory(person: person),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Exames de Graduação', style: Theme.of(context).textTheme.caption),
                        const Icon(Icons.chevron_right_rounded),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
