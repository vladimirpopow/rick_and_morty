import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/common/app_colors.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_test/feature/presentation/pages/person_screen.dart';
import 'package:rick_and_morty_test/locator_service.dart';
import 'locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<PersonListCubit>(
              create: (context) => sl<PersonListCubit>()..loadPerson()),
          BlocProvider<PersonSearchBloc>(
              create: (context) => sl<PersonSearchBloc>())
        ],
        child: MaterialApp(
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: AppColors.mainBackground,
            backgroundColor: AppColors.mainBackground,
          ),
          home: const HomePage(),
        ));
  }
}
