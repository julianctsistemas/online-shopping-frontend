import 'package:encafeinados/shared/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:encafeinados/features/products/domain/usecases/get_products_usecase.dart';
import 'package:encafeinados/features/products/domain/usecases/create_product_usecase.dart';
import 'package:encafeinados/features/products/domain/usecases/delete_product_usecase.dart';
import 'package:encafeinados/features/products/domain/usecases/update_product_usecase.dart';

class ProductsPage extends StatefulWidget {
  final GetProductsUseCase getProductsUseCase;
  final CreateProductUseCase createProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final UpdateProductUseCase updateProductUseCase;

  const ProductsPage({
    super.key,
    required this.getProductsUseCase,
    required this.createProductUseCase,
    required this.deleteProductUseCase,
    required this.updateProductUseCase,
  });

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
  try {
    final result = await widget.getProductsUseCase.call();
    setState(() {
      products = result; // Actualiza el estado con los productos
    });
  } catch (e) {
    print('Error fetching products: $e');
  }
}


  Future<void> createProduct(String name, double price) async {
  try {
    await widget.createProductUseCase.call(name, price);
    await fetchProducts(); // Llama a fetchProducts después de crear el producto
  } catch (e) {
    print('Error creating product: $e');
  }
}


  Future<void> deleteProduct(int id) async {
    try {
      await widget.deleteProductUseCase.call(id);
      fetchProducts(); // Refresh list
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  Future<void> updateProduct(int id, String name, double price) async {
    try {
      await widget.updateProductUseCase.call(id, {"name": name, "price": price});
      fetchProducts(); // Refresh list
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: const NavigationBarWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Lista de Productos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildProductGrid(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateProductDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

 Widget _buildProductGrid() {
  if (products.isEmpty) {
    return const Center(
      child: Text(
        'No hay productos disponibles',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Número de columnas
      crossAxisSpacing: 8, // Espacio horizontal entre columnas
      mainAxisSpacing: 8, // Espacio vertical entre filas
      childAspectRatio: 3, // Relación de aspecto (ancho/alto) ajustada
    ),
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      return _buildProductCard(product);
    },
  );
}

Widget _buildProductCard(dynamic product) {
  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.shopping_cart, size: 30, color: Colors.blue),
          Text(
            product['name'],
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            '\$${product['price'].toString()}',
            style: const TextStyle(fontSize: 12, color: Colors.green),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 16, color: Colors.orange),
                onPressed: () {
                  _showEditProductDialog(
                    product['id'],
                    product['name'],
                    product['price'],
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                onPressed: () {
                  deleteProduct(product['id']);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


  void _showCreateProductDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Crear Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                createProduct(
                  nameController.text,
                  double.parse(priceController.text),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProductDialog(int id, String name, double price) {
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController priceController = TextEditingController(text: price.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                updateProduct(
                  id,
                  nameController.text,
                  double.parse(priceController.text),
                );
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
