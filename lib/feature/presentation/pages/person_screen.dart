import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rick_and_morty_test/feature/presentation/widgets/persons_list_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Персонажи'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          )
        ],
      ),
      body: PersonsList(),
    );
  }
}
