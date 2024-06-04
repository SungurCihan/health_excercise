import 'package:flutter/material.dart';
import 'package:health_excercise/product/service/manager/product_service_manager.dart';
import 'package:health_excercise/product/state/container/product_state_items.dart';
import 'package:health_excercise/product/state/view_model/product_view_model.dart';

/// The base state class
abstract class BaseState<T extends StatefulWidget> extends State<T> {
  /// The product service manager
  ProductNetworkManager get productNetworkManager =>
      ProductStateItems.productNetworkManager;

  /// The product view model
  ProductViewModel get productViewModel => ProductStateItems.productViewModel;
}
