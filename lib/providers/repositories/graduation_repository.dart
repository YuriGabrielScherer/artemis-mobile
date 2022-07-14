import 'package:artemis_mobile/models/pageable/pageable_input.dart';

import '../../models/graduation/graduation.dart';
import '../../models/pageable/pageable.dart';

abstract class IGraduationRepository {
  Future<Pageable<Graduation>> list({required PageableInput pageableInput});
}
