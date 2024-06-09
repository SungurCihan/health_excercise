// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  User({
    required this.name,
    required this.surname,
    required this.password,
    required this.email,
    required this.generalAnlysisRegion,
    required this.age,
    required this.weight,
    required this.height,
  });

  // JSON'dan dönüştürme
  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        surname: json['surname'] as String,
        password: json['password'] as String,
        email: json['email'] as String,
        generalAnlysisRegion: json['generalAnlysisRegion'] as String,
        age: json['age'] as String,
        weight: json['weight'] as int,
        height: json['height'] as int,
      );

  final String name;
  final String surname;
  final String password;
  final String email;
  final String generalAnlysisRegion;
  final String age;
  final int weight;
  final int height;

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() => {
        'name': name,
        'surname': surname,
        'password': password,
        'email': email,
        'generalAnlysisRegion': generalAnlysisRegion,
        'age': age,
        'weight': weight,
        'height': height,
      };

  @override
  List<Object?> get props => [
        name,
        surname,
        password,
        email,
        generalAnlysisRegion,
        age,
        weight,
        height,
      ];
}
