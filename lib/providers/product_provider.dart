import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  Product? _selectedProduct;

  // Getters
  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Product? get selectedProduct => _selectedProduct;

  // Fetch all products
  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _products = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch single product by ID
  Future<void> fetchProductById(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedProduct = await _apiService.fetchProductById(id);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _selectedProduct = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create new product
  Future<bool> createProduct(Product product) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newProduct = await _apiService.createProduct(product);
      _products.add(newProduct);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update product
  Future<bool> updateProduct(int id, Product product) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedProduct = await _apiService.updateProduct(id, product);
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
      }
      if (_selectedProduct?.id == id) {
        _selectedProduct = updatedProduct;
      }
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete product
  Future<bool> deleteProduct(int id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _apiService.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      if (_selectedProduct?.id == id) {
        _selectedProduct = null;
      }
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Search products
  List<Product> searchProducts(String query) {
    if (query.isEmpty) {
      return _products;
    }
    return _products
        .where((p) =>
            p.title.toLowerCase().contains(query.toLowerCase()) ||
            p.category.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
