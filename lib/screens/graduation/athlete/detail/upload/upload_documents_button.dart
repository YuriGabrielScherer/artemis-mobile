import 'dart:io';

import 'package:artemis_mobile/core/getit.dart';
import 'package:artemis_mobile/providers/repositories/impl/graduation_repository_impl.dart';
import 'package:artemis_mobile/screens/graduation/athlete/detail/upload/bloc/upload_documents_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadDocumentsButton extends StatelessWidget {
  const UploadDocumentsButton({this.onUploadFile, Key? key}) : super(key: key);
  final VoidCallback? onUploadFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: BlocProvider(
        create: (context) => UploadDocumentsBloc(repository: getIt.get<GraduationRepository>()),
        child: BlocConsumer<UploadDocumentsBloc, UploadDocumentsState>(
          listener: (context, state) {
            if (state is UploadDocumentsSuccess && onUploadFile != null) {
              onUploadFile!();
            }
            if (state is UploadDocumentsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ocorreu um erro ao carregar o arquivo!'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is UploadDocumentsLoading) {
              return const CircularProgressIndicator();
            }
            if (state is UploadDocumentsSuccess) {
              return const SizedBox();
            }

            return SizedBox(
              width: double.infinity,
              child: UploadButton(
                onUpload: (file) => context.read<UploadDocumentsBloc>().add(UploadDocumentsEvent(file: file)),
              ),
            );
          },
        ),
      ),
    );
  }
}

@visibleForTesting
class UploadButton extends StatelessWidget {
  const UploadButton({required this.onUpload, Key? key}) : super(key: key);
  final Function(File) onUpload;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final filePicker = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (filePicker != null) {
          File file = File(filePicker.files.single.path!);
          onUpload(file);
        }
      },
      child: const Text('Enviar comprovante de pagamento'),
    );
  }
}
