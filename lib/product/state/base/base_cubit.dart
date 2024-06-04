import 'package:flutter_bloc/flutter_bloc.dart';

/// The base cubit class
abstract class BaseCubit<T extends Object> extends Cubit<T> {
  /// The base cubit constructor
  BaseCubit(super.initialState);

  @override
  void emit(T state) {
    if (isClosed) return;
    super.emit(state);
  }
}
