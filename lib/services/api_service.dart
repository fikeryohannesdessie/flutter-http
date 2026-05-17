import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?limit=100'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> productsJson = data['products'] as List<dynamic>;
        return productsJson
            .map((p) => Product.fromJson(p as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Product> fetchProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to fetch product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  Future<Product> createProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'stock': product.stock,
          'category': product.category,
          'rating': product.rating,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  Future<Product> updateProduct(int id, Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'stock': product.stock,
          'category': product.category,
          'rating': product.rating,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}
