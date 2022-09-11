import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/graduation/dto/graduatin_list_input.dart';

import '../../models/graduation/graduation.dart';
import '../../models/pageable/pageable.dart';

abstract class IGraduationRepository {
  Future<Pageable<Graduation>> list({required GraduationListInput pageableInput});
  Future<void> downloadAthleteGraduationFile({required int athleteCode, required int graduationCode, ProgressCallback? progressCallback});
  Future<List<FileSystemEntity>> listDownloadedFiles({int athleteCode, int graduationCode});
  Future<void> uploadAthleteGraduationFile({required File file});
}
