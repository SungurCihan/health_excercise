import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_excercise/product/state/container/product_state_items.dart';
import 'package:health_excercise/product/state/view_model/product_view_model.dart';

/// The state initialize
final class StateInit extends StatelessWidget {
  /// The state initialize constructor
  const StateInit({required this.child, super.key});

  /// The child widget
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductViewModel>.value(
          value: ProductStateItems.productViewModel,
        ),
      ],
      child: child,
    );
  }
}
