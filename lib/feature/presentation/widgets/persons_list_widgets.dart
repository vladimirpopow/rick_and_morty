import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_test/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty_test/feature/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:rick_and_morty_test/feature/presentation/widgets/person_card_widget.dart';

class PersonsList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupscrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PersonListCubit>(context).loadPerson();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupscrollController(context);
    return BlocBuilder<PersonListCubit, PersonState>(builder: (context, state) {
      List<PersonEntity> persons = [];
      if (state is PersonLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is PersonLoaded) {
        persons = state.personList;
      } else if (state is PersonError) {
        return Text(
          state.message,
          style: TextStyle(color: Colors.white, fontSize: 25),
        );
      }

      return ListView.separated(
          itemBuilder: (context, index) {
            return PersonCard(person: persons[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: persons.length);
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
