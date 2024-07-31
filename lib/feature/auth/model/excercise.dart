// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class Excercise with EquatableMixin {
  Excercise({
    required this.excerciseDate,
    required this.doneExercise,
    required this.id,
    required this.calories,
    required this.testResult,
  });

  // JSON'dan dönüştürme
  factory Excercise.fromJson(Map<String, dynamic> json) => Excercise(
        id: json['id'] as int,
        excerciseDate: json['exerciseDate'] as DateTime,
        doneExercise: json['doneExercise'] as bool,
        calories: json['calories'] as String,
        testResult: json['testResult'] as String,
      );

  final int id;
  final DateTime excerciseDate;
  final bool doneExercise;
  final String calories;
  final String testResult;

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() => {
        'id': id,
        'exerciseDate': excerciseDate,
        'doneExercise': doneExercise,
        'calories': calories,
        'testResult': testResult,
      };

  @override
  List<Object?> get props => [
        id,
        excerciseDate,
        doneExercise,
        calories,
        testResult,
      ];
}
