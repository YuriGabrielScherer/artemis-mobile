import 'package:artemis_mobile/screens/graduation/list/detail/graduation_detail.dart';

import '../../../core/auth/bloc/auth_bloc.dart';
import '../../../core/getit.dart';
import '../../../models/person/person.dart';

import '../../../core/enums/enum_sort.dart';
import '../../../models/graduation/graduation.dart';
import '../../../providers/repositories/impl/graduation_repository_impl.dart';
import 'bloc/graduation_list_bloc.dart';
import '../../../widgets/graduation_situation_badge.dart';
import '../../../widgets/list_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class GraduationListPage extends StatelessWidget {
  const GraduationListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exames de Graduação'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_rounded),
          )
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          Person person = state.person!;
          return Padding(
            padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
            child: BlocProvider<GraduationListBloc>(
              create: (context) => GraduationListBloc(getIt.get<GraduationRepository>())..add(GraduationListRequest(athleteCode: person.code)),
              child: BlocBuilder<GraduationListBloc, GraduationListState>(
                builder: (context, state) {
                  if (state.status == EnumGraduationListStatus.success) {
                    if (state.graduations.isEmpty) {
                      return const Text('Nenhuma graduação encontrada');
                    }

                    return _GraduationListView(
                      graduations: state.graduations,
                      totalRecords: state.totalRecords,
                      person: person,
                    );
                  }

                  if (state.status == EnumGraduationListStatus.error) {
                    return TextButton(
                      child: const Text('Erro!'),
                      onPressed: () {
                        context.read<GraduationListBloc>().add(GraduationListRequest(athleteCode: person.code));
                      },
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _GraduationListView extends StatelessWidget {
  const _GraduationListView({
    required this.graduations,
    required this.totalRecords,
    required this.person,
    Key? key,
  }) : super(key: key);

  final List<Graduation> graduations;
  final int totalRecords;
  final Person person;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListHeader(
          totalRecords: totalRecords,
          sort: EnumSort.asc,
          onSort: (_) {},
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _ListDataWidget(
              graduations: graduations,
              hasReachedMax: graduations.length == totalRecords,
              person: person,
            ),
          ),
        ),
      ],
    );
  }
}

class _ListDataWidget extends StatefulWidget {
  const _ListDataWidget({
    required this.graduations,
    required this.hasReachedMax,
    required this.person,
    Key? key,
  }) : super(key: key);

  final List<Graduation> graduations;
  final bool hasReachedMax;
  final Person person;

  @override
  State<_ListDataWidget> createState() => _ListDataWidgetState();
}

class _ListDataWidgetState extends State<_ListDataWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<GraduationListBloc>().add(GraduationListRequest(athleteCode: widget.person.code));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.hasReachedMax ? widget.graduations.length : widget.graduations.length + 1,
      controller: _scrollController,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index >= widget.graduations.length) {
          return const Center(
            child: SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          );
        }
        final graduation = widget.graduations[index];
        return Center(
          child: Material(
            elevation: 2,
            color: Colors.grey.shade100,
            shadowColor: Colors.grey.withOpacity(0.5),
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => GraduationDetailPage(graduation: graduation),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(4),
              child: _GraduationCard(graduation),
            ),
          ),
        );
      },
    );
  }
}

class _GraduationCard extends StatelessWidget {
  const _GraduationCard(this.graduation, {Key? key}) : super(key: key);

  final Graduation graduation;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GraduationSituationBadgeWidget(situation: graduation.situation),
              const Spacer(),
              const Icon(Icons.calendar_month_rounded, size: 16),
              const SizedBox(width: 4),
              Text(
                DateFormat('dd/MM/yyyy').format(graduation.date),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      graduation.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (graduation.description != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        graduation.description!,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (graduation.place != null)
                      Text(
                        graduation.place!,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ],
      ),
    );
  }
}
