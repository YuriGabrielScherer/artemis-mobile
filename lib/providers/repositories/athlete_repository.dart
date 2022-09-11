import '../../models/athlete/athlete.dart';
import '../../models/graduation/athlete/athlete_graduation.dart';
import '../../models/graduation/graduation.dart';

abstract class IAthleteRepository {
  Future<Graduation> getGraduation(int athleteCode);
  Future<Athlete> getAthlete(int athleteCode);
  Future<AthleteGraduation> getAthleteGraduation({required int athleteCode, required int graduationCode});
  Future<List<AthleteGraduation>> listGraduations(int athleteCode);
}
