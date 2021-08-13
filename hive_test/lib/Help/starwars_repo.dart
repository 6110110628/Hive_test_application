import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'starwars_repo.g.dart';

@HiveType(typeId: 1)
class People {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? height;
  @HiveField(2)
  String? mass;
  @HiveField(3)
  String? birthYear;
  @HiveField(4)
  String? gender;
  @HiveField(5)
  String? homeworld;
  @HiveField(6)
  String? hairColor;
  @HiveField(7)
  String? skinColor;
  @HiveField(8)
  String? eyeColor;
  @HiveField(9)
  int? no;

  People(
      {@required this.name,
      @required this.height,
      @required this.mass,
      @required this.birthYear,
      @required this.gender,
      @required this.homeworld,
      @required this.hairColor,
      @required this.skinColor,
      @required this.eyeColor,
      @required this.no});

  factory People.fromJson(Map<String, dynamic> json) {
    var box = Hive.box('starwars');
    int peopleNumber = int.parse(json["url"]
        .toString()
        .substring(29, json["url"].toString().length - 1));

    People people = People(
        name: json["name"],
        height: json["height"],
        mass: json["mass"],
        hairColor: json["hair_color"],
        skinColor: json["skin_color"],
        eyeColor: json["eye_color"],
        birthYear: json["birth_year"],
        gender: json["gender"],
        homeworld: json["homeworld"],
        no: peopleNumber);
    box.put(peopleNumber, people);
    return people;
  }
}

class StarwarsRepo {
  Future<List<People>> fetchPeople({int page = 1}) async {
    var response = await Dio().get('https://swapi.dev/api/people/?page=$page');
    List<dynamic> results = response.data['results'];
    return results.map((it) => People.fromJson(it)).toList();
  }
}
