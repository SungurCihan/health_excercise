// ignore_for_file: public_member_api_docs

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/feature/auth/model/user.dart';
import 'package:health_excercise/feature/auth/viewmodel/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(super.initialState);

  void setUser(User user) {
    emit(state.copyWith(user: user));
  }

  void updateUser(String age, int weight, int height) {
    final newUser = User(
      name: state.user?.name ?? '',
      surname: state.user?.surname ?? '',
      password: state.user?.password ?? '',
      email: state.user?.email ?? '',
      generalAnlysisRegion: state.user?.generalAnlysisRegion ?? '',
      age: age,
      weight: weight,
      height: height,
    );
    emit(state.copyWith(user: newUser));
  }

  User? getUser() {
    return state.user;
  }
}
