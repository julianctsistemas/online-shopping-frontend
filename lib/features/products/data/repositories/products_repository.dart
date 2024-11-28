import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductsRepository {
  final String baseUrl;

  ProductsRepository({required this.baseUrl});

  Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener productos');
    }
  }

 Future<void> createProduct(Map<String, dynamic> productData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(productData),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el producto');
    }
  }


  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode != 204) {
      throw Exception('Error al eliminar producto');
    }
  }

  Future<void> updateProduct(int id, Map<String, dynamic> product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/products/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(product),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar producto');
    }
  }
}
