import 'package:artemis_mobile/core/auth/bloc/auth_bloc.dart';
import 'package:artemis_mobile/core/getit.dart';
import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/providers/repositories/impl/graduation_repository_impl.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/documents/download/download_bloc/athlete_graduation_documents_download_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AthleteGraduationDocumentsDownloadWidget extends StatelessWidget {
  const AthleteGraduationDocumentsDownloadWidget({
    required this.athleteGraduation,
    this.onDownloadSuccess,
    this.onDownloadError,
    Key? key,
  }) : super(key: key);

  final AthleteGraduation athleteGraduation;
  final VoidCallback? onDownloadSuccess;
  final VoidCallback? onDownloadError;

  @override
  Widget build(BuildContext context) {
    if (athleteGraduation.file == null) {
      return const Text('Comprovante de pagamento pendente.');
    }

    return BlocProvider(
      create: (context) => AthleteGraduationDocumentsDownloadBloc(graduationRepository: getIt.get<GraduationRepository>()),
      child: BlocConsumer<AthleteGraduationDocumentsDownloadBloc, AthleteGraduationDocumentsDownloadState>(
        listener: (context, state) {
          if (state is AthleteGraduationDocumentsDownloadSuccess && onDownloadSuccess != null) {
            onDownloadSuccess!();
          }
          if (state is AthleteGraduationDocumentsDownloadError && onDownloadError != null) {
            onDownloadError!();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        athleteGraduation.file!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Data de envio: ${DateFormat('dd/MM/yyyy').format(athleteGraduation.file!.lastModifiedDate)}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (state is AthleteGraduationDocumentsDownloadInitial)
                    CustomButton(
                      icon: Icons.download_rounded,
                      onTap: () => context.read<AthleteGraduationDocumentsDownloadBloc>().add(
                            AthleteGraduationDocumentsDownloadRequestEvent(
                              graduationCode: athleteGraduation.graduation!.code,
                              athleteCode: context.read<AuthBloc>().state.person!.code,
                            ),
                          ),
                    ),
                ],
              ),
              if (state is AthleteGraduationDocumentsDownloadProgress) LinearProgressIndicator(value: state.progress / 100),
            ],
          );
        },
      ),
    );
  }
}

@visibleForTesting
class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    required this.icon,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(60),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(icon),
      ),
    );
  }
}
