import 'package:get_it/get_it.dart';
import 'package:health_excercise/product/service/manager/index.dart';
import 'package:health_excercise/product/state/view_model/product_view_model.dart';

/// The container for the product state.
final class ProductContainer {
  const ProductContainer._();

  static final _getIt = GetIt.I;

  /// Setup the container with the required dependencies.
  static void setup() {
    _getIt
      ..registerSingleton<ProductNetworkManager>(ProductNetworkManager.base())
      ..registerLazySingleton<ProductViewModel>(
        ProductViewModel.new,
      );
  }

  /// Read the instance of the given type [T] from the container.
  static T read<T extends Object>() => _getIt<T>();
}
