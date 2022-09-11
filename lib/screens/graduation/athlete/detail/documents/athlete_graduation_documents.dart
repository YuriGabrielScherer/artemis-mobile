import 'dart:io';

import 'package:artemis_mobile/core/auth/bloc/auth_bloc.dart';
import 'package:artemis_mobile/core/getit.dart';
import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/providers/repositories/impl/graduation_repository_impl.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/documents/bloc/athlete_graduation_documents_bloc.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/documents/download/athlete_graduation_documents_download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';

class AthleteGraduationDocuments extends StatelessWidget {
  const AthleteGraduationDocuments({required this.athleteGraduation, Key? key}) : super(key: key);

  final AthleteGraduation athleteGraduation;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AthleteGraduationDocumentsBloc(graduationRepository: getIt.get<GraduationRepository>())
        ..add(AthleteGraduationDocumentsListEvent(
          athleteCode: context.read<AuthBloc>().state.person!.code,
          graduationCode: athleteGraduation.graduation!.code,
        )),
      child: BlocBuilder<AthleteGraduationDocumentsBloc, AthleteGraduationDocumentsState>(
        builder: (context, state) {
          if (state is AthleteGraduationDocumentsInitial || state is AthleteGraduationDocumentsLoading) {
            return const CircularProgressIndicator();
          }

          if (state is AthleteGraduationDocumentsSuccess) {
            if (state.files.isEmpty) {
              return AthleteGraduationDocumentsDownloadWidget(
                athleteGraduation: athleteGraduation,
                onDownloadSuccess: () {
                  context.read<AthleteGraduationDocumentsBloc>().add(
                        AthleteGraduationDocumentsListEvent(
                          athleteCode: context.read<AuthBloc>().state.person!.code,
                          graduationCode: athleteGraduation.graduation!.code,
                        ),
                      );
                },
              );
            }

            return ListFileWidget(
              athleteGraduation: athleteGraduation,
              files: state.files,
            );
          }

          return const Text('Failure');
        },
      ),
    );
  }
}

@visibleForTesting
class ListFileWidget extends StatelessWidget {
  const ListFileWidget({
    required this.athleteGraduation,
    required this.files,
    Key? key,
  }) : super(key: key);

  final AthleteGraduation athleteGraduation;
  final List<File> files;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: files
          .map(
            (file) => Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    file.path.split('/').last,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () => OpenFile.open(file.path),
                  borderRadius: BorderRadius.circular(60),
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      Icons.open_in_full_rounded,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                DeleteButton(
                  file: file,
                  onDelete: () => context.read<AthleteGraduationDocumentsBloc>().add(
                        AthleteGraduationDocumentsRemoveEvent(
                          file: file,
                          athleteCode: context.read<AuthBloc>().state.person!.code,
                          graduationCode: athleteGraduation.graduation!.code,
                        ),
                      ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

@visibleForTesting
class DeleteButton extends StatelessWidget {
  const DeleteButton({required this.file, required this.onDelete, Key? key}) : super(key: key);
  final File file;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: const Text('Excluir documento'),
                content: const Text('Essa ação não pode ser revertida. Deseja continuar?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      onDelete();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Sim'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(primary: Colors.red),
                    child: const Text('Não'),
                  ),
                ],
              );
            });
      },
      borderRadius: BorderRadius.circular(60),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.delete_rounded,
          size: 22,
        ),
      ),
    );
  }
}
