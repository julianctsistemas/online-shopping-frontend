
import 'package:encafeinados/features/products/data/repositories/products_repository.dart';
import 'package:encafeinados/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:encafeinados/features/products/domain/usecases/update_product_usecase.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:encafeinados/features/landing/presentation/pages/landing_page.dart';
import 'package:encafeinados/features/products/presentation/pages/product_page.dart';
import 'package:encafeinados/features/products/domain/usecases/get_products_usecase.dart';
import 'package:encafeinados/features/products/domain/usecases/create_product_usecase.dart';

void main() {
  // Configuración de repositorios y casos de uso
  final productsRepository = ProductsRepository(baseUrl: "http://localhost:8080");
  final getProductsUseCase = GetProductsUseCase(productsRepository);
  final createProductUseCase = CreateProductUseCase(productsRepository);
  final deleteProductUseCase = DeleteProductUseCase(productsRepository);
  final updateProductUseCase = UpdateProductUseCase(productsRepository);

  // Pasar casos de uso a las rutas
  final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => ProductsPage(
          getProductsUseCase: getProductsUseCase,
          createProductUseCase: createProductUseCase,
          deleteProductUseCase: deleteProductUseCase,
          updateProductUseCase: updateProductUseCase,
        ),
      ),
      // Ruta comentada por ahora si no existe la página CategoriesPage
      // GoRoute(
      //   path: '/categories',
      //   builder: (context, state) => const CategoriesPage(),
      // ),
    ],
  );

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({required this.router, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
