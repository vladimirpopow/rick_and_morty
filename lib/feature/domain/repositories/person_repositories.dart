import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_test/core/error/failure.dart';
import 'package:rick_and_morty_test/feature/domain/entities/person_entity.dart';

abstract class PersonRepositories {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
