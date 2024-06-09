// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';

class Excercise with EquatableMixin {
  Excercise({required this.excerciseDate, required this.doneExercise});

  // JSON'dan dönüştürme
  factory Excercise.fromJson(Map<String, dynamic> json) => Excercise(
        excerciseDate: json['exerciseDate'] as String,
        doneExercise: json['doneExercise'] as bool,
      );

  final String excerciseDate;
  final bool doneExercise;

  // JSON'a dönüştürme
  Map<String, dynamic> toJson() => {
        'exerciseDate': excerciseDate,
        'doneExercise': doneExercise,
      };

  @override
  List<Object?> get props => [
        excerciseDate,
        doneExercise,
      ];
}
