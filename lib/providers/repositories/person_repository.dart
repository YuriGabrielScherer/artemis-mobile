import '../../models/person/person.dart';

abstract class IPersonRepository {
  Future<Person?> getPerson(int code);
}
