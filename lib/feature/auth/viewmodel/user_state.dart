// ignore_for_file: public_member_api_docs

import 'package:equatable/equatable.dart';
import 'package:health_excercise/feature/auth/model/user.dart';

class UserState extends Equatable {
  const UserState({this.user});

  final User? user;

  @override
  List<Object?> get props => [user];

  UserState copyWith({User? user}) {
    return UserState(
      user: user ?? this.user,
    );
  }
}
