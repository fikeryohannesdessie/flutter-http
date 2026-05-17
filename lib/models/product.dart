class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final int stock;
  final String category;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
      category: json['category'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'rating': rating,
    };
  }

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    int? stock,
    String? category,
    double? rating,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }
}
