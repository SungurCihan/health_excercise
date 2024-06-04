import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gen/gen.dart';
import 'package:health_excercise/product/init/config/app_enviroment.dart';
import 'package:health_excercise/product/service/manager/product_service_manager.dart';
import 'package:health_excercise/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

void main() {
  late final ProductNetworkManager manager;
  setUp(() {
    AppEnviorment.general();
    manager = ProductNetworkManager.base();
  });
  test('get users items from api', () async {
    final response = await manager.send<User, List<User>>(
      ProductServicePath.posts.value,
      parseModel: User(),
      method: RequestType.GET,
    );

    expect(response.data, isNotNull);
  });

  test('get users items from api with error', () async {
    manager.listenErrorState(
      onErrorStatus: (value) {
        if (value == HttpStatus.unauthorized) {}
        expect(value, isNotNull);
      },
    );
    final response = await manager.send<User, List<User>>(
      ProductServicePath.userV1.value,
      parseModel: User(),
      method: RequestType.GET,
    );

    expect(response.data, null);
  });
}
