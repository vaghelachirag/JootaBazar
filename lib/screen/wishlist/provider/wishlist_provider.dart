import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../model/product_model.dart';

class WishlistNotifier extends StateNotifier<List<Product>> {
  WishlistNotifier() : super([]);

  void addToWishlist(Product product) {
    if (!state.contains(product)) {
      state = [...state, product];
    }
  }

  void removeFromWishlist(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product)) {
      removeFromWishlist(product);
    } else {
      addToWishlist(product);
    }
  }

  bool isInWishlist(Product product) {
    return state.any((item) => item.id == product.id);
  }

  void clearWishlist() {
    state = [];
  }

  int get itemCount => state.length;
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<Product>>((ref) {
  return WishlistNotifier();
});

final wishlistCountProvider = Provider<int>((ref) {
  final wishlist = ref.watch(wishlistProvider);
  return wishlist.length;
});

final isInWishlistProvider = Provider.family<bool, String>((ref, productId) {
  final wishlist = ref.watch(wishlistProvider);
  return wishlist.any((product) => product.id == productId);
});






