import 'package:encafeinados/features/products/data/repositories/products_repository.dart';


class UpdateProductUseCase {
  final ProductsRepository repository;

  UpdateProductUseCase(this.repository);

  Future<void> call(int id, Map<String, dynamic> updatedData) async {
    await repository.updateProduct(id, updatedData);
  }
}
