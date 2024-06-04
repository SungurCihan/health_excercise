import 'package:flutter/material.dart';
import 'package:health_excercise/product/state/base/base_cubit.dart';
import 'package:health_excercise/product/state/view_model/product_state.dart';

/// The product view model
final class ProductViewModel extends BaseCubit<ProductState> {
  /// The product view model constructor
  ProductViewModel() : super(const ProductState());

  /// Change theme mode
  /// [themeMode] is [ThemeMode.light] or [ThemeMode.dark]
  void changeThemeMode(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
  }
}
