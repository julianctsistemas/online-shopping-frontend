import 'package:encafeinados/features/products/data/repositories/products_repository.dart';

class GetProductsUseCase {
  final ProductsRepository repository;

  GetProductsUseCase(this.repository);

  Future<List<dynamic>> call() async {
    return repository.fetchProducts();
  }
}
