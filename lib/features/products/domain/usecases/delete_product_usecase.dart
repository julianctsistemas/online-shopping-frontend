
import 'package:encafeinados/features/products/data/repositories/products_repository.dart';

class DeleteProductUseCase {
  final ProductsRepository repository;

  DeleteProductUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.deleteProduct(id);
  }
}
