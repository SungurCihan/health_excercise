import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_excercise/product/init/config/app_enviroment.dart';
import 'package:vexana/vexana.dart';

/// This is the network manager for the product service.
final class ProductNetworkManager extends NetworkManager<EmptyModel> {
  /// This is the network manager for the product service.
  ProductNetworkManager.base()
      : super(
          options: BaseOptions(
            baseUrl: AppEnviormentItem.baseUrl.value,
          ),
        );

  /// Handle error
  /// [onErrorStatus] is error status code [HttStatus]
  void listenErrorState({required ValueChanged<int> onErrorStatus}) {
    interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) {
          onErrorStatus(e.response?.statusCode ?? HttpStatus.notFound);
          return handler.next(e);
        },
      ),
    );
  }
}
