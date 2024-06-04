import 'package:flutter/material.dart';
import 'package:health_excercise/feature/home/view/home2_view.dart';
import 'package:health_excercise/product/service/login_service.dart';
import 'package:health_excercise/product/service/manager/index.dart';
import 'package:health_excercise/product/state/container/product_state_items.dart';

/// Home view mixin
mixin HomeViewMixin on State<HomeView> {
  /// Login service
  late final LoginService loginService;

  /// Product network error manager
  late final ProductNetworkErrorManager productNetworkErrorManager;

  @override
  void initState() {
    super.initState();

    loginService = LoginService(ProductStateItems.productNetworkManager);
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
  }
}
