import 'dart:convert';

import 'package:rick_and_morty_test/core/error/exceptions.dart';
import 'package:rick_and_morty_test/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonFromCache();
  Future<void> personToCache(List<PersonModel> person);
}

const CACHED_PERSON_LIST = 'CACHED_PERSON_LIST';

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonList = sharedPreferences.getStringList(CACHED_PERSON_LIST);
    if (jsonPersonList!.isNotEmpty) {
      return Future.value(jsonPersonList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheExceptions();
    }
  }

  @override
  Future<void> personToCache(List<PersonModel> person) {
    final List<String> jsonPersonList =
        person.map((person) => json.encode(person.toJson())).toList();
    sharedPreferences.setStringList(CACHED_PERSON_LIST, jsonPersonList);
    print('Person to write Cache ${jsonPersonList.length}');
    return Future.value(jsonPersonList);
  }
}
