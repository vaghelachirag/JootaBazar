import 'product_model.dart';

class CartItem {
  final Product product;
  final int quantity;
  final String size;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.size = '8',
  });

  double get totalPrice => product.price * quantity;

  CartItem copyWith({
    Product? product,
    int? quantity,
    String? size,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItem &&
        other.product.id == product.id &&
        other.size == size;
  }

  @override
  int get hashCode => product.id.hashCode ^ size.hashCode;
}

