import 'package:artemis_mobile/screens/graduation/list/detail/graduation_detail.dart';

import '../../../core/getit.dart';
import '../../../providers/repositories/impl/athlete_repository_impl.dart';
import 'bloc/graduation_card_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/graduation/graduation.dart';
import '../../../models/person/person.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GraduationCardWidget extends StatelessWidget {
  const GraduationCardWidget({required this.person, Key? key}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GraduationCardBloc(repository: getIt.get<AthleteRepository>())
        ..add(
          GraduationCardRequest(person.code),
        ),
      child: Column(
        children: [
          const _CardHeader(),
          const SizedBox(height: 8),
          BlocBuilder<GraduationCardBloc, GraduationCardState>(
            builder: (context, state) {
              if (state is GraduationCardLoading || state is GraduationCardInitial) {
                return const CircularProgressIndicator();
              }

              if (state is GraduationCardEmpty) {
                return const _EmptyBody();
              }

              if (state is GraduationCardError) {
                return const Text('Error');
              }

              return _CardBody(graduation: (state as GraduationCardSuccess).graduation);
            },
          )
        ],
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_month_outlined, color: Colors.green.shade800),
        const SizedBox(width: 12),
        const Text(
          'Exame de Graduação',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: 'OpenSans',
          ),
        ),
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({required this.graduation, Key? key}) : super(key: key);

  final Graduation graduation;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => GraduationDetailPage(graduation: graduation),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      graduation.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.calendar_today, size: 16),
                  const SizedBox(width: 4),
                  Text(DateFormat('dd/MM/yyyy').format(graduation.date)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (graduation.description != null) ...[
                        Text(
                          graduation.description!,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 8),
                      ],
                      if (graduation.place != null)
                        Text(
                          graduation.place!,
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.outbox_rounded,
            color: Colors.green.shade800,
            size: 36,
          ),
          const SizedBox(height: 12),
          const Text(
            'Você não está registrado em nenhum exame de graduação!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
            ),
          ),
          // const SizedBox(height: 8),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (ctx) => const GraduationList(),
          //       ),
          //     );
          //   },
          //   child: const Text('Registrar'),
          // ),
        ],
      ),
    );
  }
}
