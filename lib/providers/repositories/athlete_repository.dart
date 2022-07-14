import 'package:artemis_mobile/models/athlete/athlete.dart';
import 'package:artemis_mobile/models/graduation/athlete/athlete_graduation.dart';
import 'package:artemis_mobile/models/graduation/graduation.dart';

abstract class IAthleteRepository {
  Future<Graduation> getGraduation(int athleteCode);
  Future<Athlete> getAthlete(int athleteCode);
  Future<List<AthleteGraduation>> listGraduations(int athleteCode);
}
