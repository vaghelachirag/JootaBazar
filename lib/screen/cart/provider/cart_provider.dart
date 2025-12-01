import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/cart_item_model.dart';
import '../../../model/product_model.dart';

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addToCart(Product product, {String size = '8'}) {
    final existingItemIndex = state.indexWhere(
      (item) => item.product.id == product.id && item.size == size,
    );

    if (existingItemIndex >= 0) {
      // Item already exists, increase quantity
      final updatedItems = List<CartItem>.from(state);
      updatedItems[existingItemIndex] = updatedItems[existingItemIndex]
          .copyWith(quantity: updatedItems[existingItemIndex].quantity + 1);
      state = updatedItems;
    } else {
      // New item, add to cart
      state = [...state, CartItem(product: product, size: size)];
    }
  }

  void removeFromCart(CartItem cartItem) {
    state = state.where((item) => item != cartItem).toList();
  }

  void updateQuantity(CartItem cartItem, int quantity) {
    if (quantity <= 0) {
      removeFromCart(cartItem);
      return;
    }

    final index = state.indexWhere((item) => item == cartItem);
    if (index >= 0) {
      final updatedItems = List<CartItem>.from(state);
      updatedItems[index] = updatedItems[index].copyWith(quantity: quantity);
      state = updatedItems;
    }
  }

  void incrementQuantity(CartItem cartItem) {
    updateQuantity(cartItem, cartItem.quantity + 1);
  }

  void decrementQuantity(CartItem cartItem) {
    updateQuantity(cartItem, cartItem.quantity - 1);
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get totalItems {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

final cartTotalProvider = Provider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0.0, (sum, item) => sum + item.totalPrice);
});

final cartItemCountProvider = Provider<int>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.fold(0, (sum, item) => sum + item.quantity);
});

