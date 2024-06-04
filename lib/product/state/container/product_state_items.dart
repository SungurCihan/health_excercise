// ignore_for_file: public_member_api_docs

import 'package:health_excercise/product/service/manager/index.dart';
import 'package:health_excercise/product/state/container/product_state_container.dart';
import 'package:health_excercise/product/state/view_model/product_view_model.dart';

final class ProductStateItems {
  const ProductStateItems._();

  static ProductNetworkManager get productNetworkManager =>
      ProductContainer.read<ProductNetworkManager>();

  static ProductViewModel get productViewModel =>
      ProductContainer.read<ProductViewModel>();
}
