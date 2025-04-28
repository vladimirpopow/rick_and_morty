import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_test/core/error/failure.dart';
import 'package:rick_and_morty_test/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/feature/domain/repositories/person_repositories.dart';

class SearchPersons {
  final PersonRepositories personRepository;

  SearchPersons(this.personRepository);

  Future<Either<Failure, List<PersonEntity>>> call(String query) async {
    return await personRepository.searchPerson(query);
  }
}

class SearchPersonsParams extends Equatable {
  final String query;
  const SearchPersonsParams({required this.query});
  @override
  List<Object?> get props => [query];
}
