import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/graduation/dto/graduatin_list_input.dart';
import '../../dio_client.dart';
import 'package:dio/dio.dart';

import '../../../models/pageable/pageable.dart';
import '../../../models/graduation/graduation.dart';
import '../graduation_repository.dart';

class GraduationRepository implements IGraduationRepository {
  const GraduationRepository({required DioClient dioClient}) : _dio = dioClient;
  final DioClient _dio;

  @override
  Future<Pageable<Graduation>> list({required GraduationListInput pageableInput}) async {
    final Response response = await _dio.get(
      'graduation/list',
      queryParameters: pageableInput.toMap,
    );

    return Pageable<Graduation>(
      totalRecords: response.data['totalRecords'],
      records: (response.data['records'] as List<dynamic>).map((grad) => Graduation.fromMap(grad)).toList(),
    );
  }

  @override
  Future downloadAthleteGraduationFile({required int athleteCode, required int graduationCode, ProgressCallback? progressCallback}) async {
    await _checkPermission();
    final downloadDir = await getApplicationDocumentsDirectory();
    await _dio.downloadFile(
      'graduation/downloadAthleteGraduationFile?athleteCode=$athleteCode&graduationCode=$graduationCode',
      '${downloadDir.path}/receipts/$athleteCode/$graduationCode',
      onReceiveProgress: progressCallback,
    );
  }

  @override
  Future<List<FileSystemEntity>> listDownloadedFiles({int? athleteCode, int? graduationCode}) async {
    final downloadDir = await getApplicationDocumentsDirectory();

    final files = downloadDir.listSync(recursive: true, followLinks: false);
    return files.where(
      (element) {
        bool output = element.path.contains('/receipts/');
        if (athleteCode != null) {
          output = element.path.contains('/receipts/$athleteCode');

          if (graduationCode != null) {
            output = element.path.contains('/receipts/$athleteCode/$graduationCode/');
          }
        }

        output &= element.path.contains('.pdf');
        return output;
      },
    ).toList();
  }

  @override
  Future<void> uploadAthleteGraduationFile({required File file}) async {
    // TODO Ajustar e colocar o tipo PDF.
    final multipartFile = await MultipartFile.fromFile(
      file.path,
    );
    final payload = FormData.fromMap({
      'athleteCode': 2,
      'graduationCode': 4,
      'file': multipartFile,
    });

    await _dio.post('graduation/uploadAthleteGraduationFile', data: payload);
  }

  Future<void> _checkPermission({bool throwError = false}) async {
    final status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      if (throwError) {
        throw ErrorDescription('Must grant storage permission.');
      }

      await Permission.storage.request();
      _checkPermission(throwError: true);
      return;
    } else if (status == PermissionStatus.granted) {
      return;
    }

    throw ErrorDescription('Something else.');
  }
}
