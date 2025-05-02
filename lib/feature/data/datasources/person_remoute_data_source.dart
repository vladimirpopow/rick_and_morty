import 'dart:convert';

import 'package:rick_and_morty_test/core/error/exceptions.dart';
import 'package:rick_and_morty_test/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemouteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPersons(String query);
}

class PersonRemouteDataSourceimpl implements PersonRemouteDataSource {
  final http.Client client;

  PersonRemouteDataSourceimpl({required this.client});

  @override
  Future<List<PersonModel>> getAllPersons(int page) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?page=$page');

  @override
  Future<List<PersonModel>> searchPersons(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      print(response);
      final person = json.decode(response.body);
      return (person['results'] as List)
          .map((person) => PersonModel.fromJson(person))
          .toList();
    } else {
      throw ServerExceptions();
    }
  }
}
