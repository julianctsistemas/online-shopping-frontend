import 'package:encafeinados/features/products/data/repositories/products_repository.dart';

class CreateProductUseCase {
  final ProductsRepository repository;

  CreateProductUseCase(this.repository);

  Future<void> call(String name, double price) async {
    await repository.createProduct({'name': name, 'price': price});
  }
}
