import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_test/core/platform/network_info.dart';
import 'package:rick_and_morty_test/feature/data/datasources/person_local_data_source.dart';
import 'package:rick_and_morty_test/feature/data/datasources/person_remoute_data_source.dart';
import 'package:rick_and_morty_test/feature/data/repositories/person_repository_impl.dart';
import 'package:rick_and_morty_test/feature/domain/repositories/person_repositories.dart';
import 'package:rick_and_morty_test/feature/domain/usercases/get_all_persons.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/search_bloc/search_event.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(searchPerson: sl()));
  sl.registerLazySingleton(() => GetAllPersons(sl()));
  sl.registerLazySingleton(() => SearchPersons(sl()));
  sl.registerLazySingleton<PersonRepositories>(() => PersonRepositoryImpl(
      remouteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PersonRemouteDataSource>(
      () => PersonRemouteDataSourceimpl(client: http.Client()));
  sl.registerLazySingleton<PersonLocalDataSource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
