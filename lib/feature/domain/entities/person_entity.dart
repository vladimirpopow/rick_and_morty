class PersonEntity {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  LocationEntity? originl;
  LocationEntity? location;
  String? image;
  late List<String> episode;
  DateTime? created;
}

class LocationEntity {
  final String? name;
  final String? url;

  LocationEntity({this.name, this.url});
}
