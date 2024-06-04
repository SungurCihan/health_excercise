import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// The product state class
final class ProductState extends Equatable {
  /// The product state constructor
  const ProductState({this.themeMode = ThemeMode.light});

  /// The theme mode
  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];

  /// Copy method to create a new instance of the ProductState
  ProductState copyWith({
    ThemeMode? themeMode,
  }) {
    return ProductState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
