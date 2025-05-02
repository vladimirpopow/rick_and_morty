import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_test/core/error/exceptions.dart';
import 'package:rick_and_morty_test/core/error/failure.dart';
import 'package:rick_and_morty_test/core/platform/network_info.dart';
import 'package:rick_and_morty_test/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty_test/feature/data/datasources/person_remoute_data_source.dart';
import 'package:rick_and_morty_test/feature/data/models/person_model.dart';
import 'package:rick_and_morty_test/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/feature/domain/repositories/person_repositories.dart';

class PersonRepositoryImpl implements PersonRepositories {
  final PersonRemouteDataSource remouteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.remouteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remouteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return remouteDataSource.searchPersons(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personToCache(remotePerson);
        return Right(remotePerson);
      } on ServerExceptions {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonFromCache();
        return Right(localPerson);
      } on CacheExceptions {
        return Left(CacheFailure());
      }
    }
  }
}
