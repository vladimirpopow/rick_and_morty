import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/core/error/failure.dart';
import 'package:rick_and_morty_test/feature/domain/usercases/search_person.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

  Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonToStateEvent(event.personQuery);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonToStateEvent(
      String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
