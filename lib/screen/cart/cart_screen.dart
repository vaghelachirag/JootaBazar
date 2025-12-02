import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/cart_item_model.dart';
import '../checkout/checkout_screen.dart';
import 'provider/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartTotalProvider);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, width, cartItems.length),

              // Cart Content
              Expanded(
                child: cartItems.isEmpty
                    ? _buildEmptyCart(context, width)
                    : _buildCartList(context, ref, cartItems, width),
              ),

              // Bottom Summary (only show if cart has items)
              if (cartItems.isNotEmpty)
                _buildBottomSummary(context, ref, totalPrice, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double width, int itemCount) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width >= 600 ? 24 : 16,
        vertical: width >= 600 ? 20 : 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.grey[900]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: width >= 600 ? 12 : 8),
          Text(
            'Shopping Cart',
            style: TextStyle(
              color: Colors.white,
              fontSize: width >= 1200
                  ? 28
                  : width >= 600
                  ? 24
                  : 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const Spacer(),
          if (itemCount > 0)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width >= 600 ? 12 : 10,
                vertical: width >= 600 ? 6 : 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width >= 600 ? 14 : 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context, double width) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(width >= 600 ? 40 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(width >= 600 ? 40 : 32),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: width >= 600 ? 100 : 80,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: width >= 600 ? 32 : 24),
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: width >= 1200
                    ? 28
                    : width >= 600
                    ? 24
                    : 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: width >= 600 ? 12 : 8),
            Text(
              'Add some products to get started',
              style: TextStyle(
                fontSize: width >= 600 ? 16 : 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width >= 600 ? 40 : 32),
            ElevatedButton(
              onPressed: () {
                // Navigate to home or close
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(
                  horizontal: width >= 600 ? 32 : 24,
                  vertical: width >= 600 ? 16 : 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Continue Shopping',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width >= 600 ? 16 : 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartList(
    BuildContext context,
    WidgetRef ref,
    List<CartItem> cartItems,
    double width,
  ) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: width >= 600 ? 20 : 16,
        vertical: width >= 600 ? 16 : 12,
      ),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return _CartItemCard(
          cartItem: item,
          onRemove: () => ref.read(cartProvider.notifier).removeFromCart(item),
          onIncrement: () =>
              ref.read(cartProvider.notifier).incrementQuantity(item),
          onDecrement: () =>
              ref.read(cartProvider.notifier).decrementQuantity(item),
          width: width,
        );
      },
    );
  }

  Widget _buildBottomSummary(
    BuildContext context,
    WidgetRef ref,
    double totalPrice,
    double width,
  ) {
    return Container(
      padding: EdgeInsets.all(width >= 600 ? 20 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: width >= 600 ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '₹${totalPrice.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: width >= 600 ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: width >= 600 ? 16 : 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CheckoutScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    vertical: width >= 600 ? 16 : 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Proceed to Checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width >= 600 ? 16 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double width;

  const _CartItemCard({
    required this.cartItem,
    required this.onRemove,
    required this.onIncrement,
    required this.onDecrement,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: width >= 600 ? 16 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(width >= 600 ? 16 : 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width >= 600 ? 100 : 80,
                height: width >= 600 ? 100 : 80,
                color: Colors.white,
                child: CachedNetworkImage(
                  imageUrl: cartItem.product.imageUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[400],
                      strokeWidth: 2,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.image_not_supported,
                    color: Colors.grey[400],
                    size: width >= 600 ? 32 : 28,
                  ),
                ),
              ),
            ),
            SizedBox(width: width >= 600 ? 16 : 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: width >= 600 ? 16 : 14,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: width >= 600 ? 6 : 4),
                  Text(
                    cartItem.product.category,
                    style: TextStyle(
                      fontSize: width >= 600 ? 13 : 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: width >= 600 ? 8 : 6),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width >= 600 ? 8 : 6,
                          vertical: width >= 600 ? 4 : 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Size: ${cartItem.size}',
                          style: TextStyle(
                            fontSize: width >= 600 ? 12 : 11,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width >= 600 ? 8 : 6),
                  Text(
                    '₹${cartItem.totalPrice.toStringAsFixed(0)}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: width >= 600 ? 18 : 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Quantity Controls and Remove
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: width >= 600 ? 20 : 18,
                    color: Colors.grey[600],
                  ),
                  onPressed: onRemove,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                SizedBox(height: width >= 600 ? 12 : 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove,
                          size: width >= 600 ? 18 : 16,
                          color: Colors.black87,
                        ),
                        onPressed: onDecrement,
                        padding: EdgeInsets.all(width >= 600 ? 8 : 6),
                        constraints: const BoxConstraints(),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width >= 600 ? 12 : 10,
                        ),
                        child: Text(
                          '${cartItem.quantity}',
                          style: TextStyle(
                            fontSize: width >= 600 ? 16 : 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: width >= 600 ? 18 : 16,
                          color: Colors.black87,
                        ),
                        onPressed: onIncrement,
                        padding: EdgeInsets.all(width >= 600 ? 8 : 6),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
