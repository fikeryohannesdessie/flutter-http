import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _categoryController;
  late TextEditingController _ratingController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.product?.title ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    _priceController = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
    _stockController = TextEditingController(
      text: widget.product?.stock.toString() ?? '',
    );
    _categoryController = TextEditingController(
      text: widget.product?.category ?? '',
    );
    _ratingController = TextEditingController(
      text: widget.product?.rating.toString() ?? '5.0',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _categoryController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Product' : 'Add New Product',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    controller: _titleController,
                    label: 'Product Title',
                    hint: 'Enter product title',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Title is required' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    hint: 'Enter product description',
                    maxLines: 4,
                    validator: (value) => value?.isEmpty ?? true
                        ? 'Description is required'
                        : null,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _categoryController,
                    label: 'Category',
                    hint: 'e.g., electronics, clothing',
                    validator: (value) =>
                        value?.isEmpty ?? true ? 'Category is required' : null,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _priceController,
                          label: 'Price',
                          hint: '0.00',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Price is required';
                            }
                            if (double.tryParse(value!) == null) {
                              return 'Invalid price';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(
                          controller: _stockController,
                          label: 'Stock',
                          hint: '0',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Stock is required';
                            }
                            if (int.tryParse(value!) == null) {
                              return 'Invalid stock';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _ratingController,
                    label: 'Rating (0-5)',
                    hint: '5.0',
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Rating is required';
                      }
                      final rating = double.tryParse(value!);
                      if (rating == null || rating < 0 || rating > 5) {
                        return 'Rating must be between 0 and 5';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              isEditing ? 'Update Product' : 'Create Product',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Color(0xFF2563EB),
                          width: 2,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Color(0xFF1E40AF),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE0E7FF),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFFE0E7FF),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF2563EB),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  void _submitForm() async {
    if (_validateForm()) {
      setState(() {
        _isLoading = true;
      });

      final product = Product(
        id: widget.product?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        category: _categoryController.text.trim(),
        rating: double.parse(_ratingController.text),
      );

      final provider = context.read<ProductProvider>();
      bool success;

      if (widget.product != null) {
        success = await provider.updateProduct(widget.product!.id, product);
      } else {
        success = await provider.createProduct(product);
      }

      setState(() {
        _isLoading = false;
      });

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.product != null
                    ? 'Product updated successfully'
                    : 'Product created successfully',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                provider.errorMessage ?? 'An error occurred',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  bool _validateForm() {
    if (_titleController.text.isEmpty) {
      _showError('Title is required');
      return false;
    }
    if (_descriptionController.text.isEmpty) {
      _showError('Description is required');
      return false;
    }
    if (_categoryController.text.isEmpty) {
      _showError('Category is required');
      return false;
    }
    if (_priceController.text.isEmpty) {
      _showError('Price is required');
      return false;
    }
    if (double.tryParse(_priceController.text) == null) {
      _showError('Please enter a valid price');
      return false;
    }
    if (_stockController.text.isEmpty) {
      _showError('Stock is required');
      return false;
    }
    if (int.tryParse(_stockController.text) == null) {
      _showError('Please enter a valid stock amount');
      return false;
    }
    if (_ratingController.text.isEmpty) {
      _showError('Rating is required');
      return false;
    }
    final rating = double.tryParse(_ratingController.text);
    if (rating == null || rating < 0 || rating > 5) {
      _showError('Rating must be between 0 and 5');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
