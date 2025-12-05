import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/product_model.dart';
import '../product_detail_screen.dart';
import 'provider/wishlist_provider.dart';
import '../cart/provider/cart_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistProvider);
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
              _buildHeader(context, width, wishlistItems.length),

              // Wishlist Content
              Expanded(
                child: wishlistItems.isEmpty
                    ? _buildEmptyWishlist(context, width)
                    : _buildWishlistGrid(context, ref, wishlistItems, width),
              ),
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
            'My Wishlist',
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

  Widget _buildEmptyWishlist(BuildContext context, double width) {
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
                Icons.favorite_border,
                size: width >= 600 ? 100 : 80,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: width >= 600 ? 32 : 24),
            Text(
              'Your wishlist is empty',
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
              'Add products you love to your wishlist',
              style: TextStyle(
                fontSize: width >= 600 ? 16 : 14,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: width >= 600 ? 40 : 32),
            ElevatedButton(
              onPressed: () {
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

  Widget _buildWishlistGrid(
    BuildContext context,
    WidgetRef ref,
    List<Product> wishlistItems,
    double width,
  ) {
    final crossAxisCount = width >= 1200
        ? 4
        : width >= 900
        ? 3
        : width >= 600
        ? 2
        : 2;

    return GridView.builder(
      padding: EdgeInsets.all(width >= 600 ? 20 : 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: width >= 600 ? 16 : 12,
        crossAxisSpacing: width >= 600 ? 16 : 12,
        childAspectRatio: width >= 1200
            ? 0.65
            : width >= 900
            ? 0.7
            : width >= 600
            ? 0.75
            : 0.8,
      ),
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        final product = wishlistItems[index];
        return _WishlistItemCard(
          product: product,
          onRemove: () =>
              ref.read(wishlistProvider.notifier).removeFromWishlist(product),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(product: product),
              ),
            );
          },
          onAddToCart: () {
            ref.read(cartProvider.notifier).addToCart(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Added to cart'),
                duration: const Duration(seconds: 1),
                backgroundColor: Colors.black,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          width: width,
        );
      },
    );
  }
}

class _WishlistItemCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final double width;

  const _WishlistItemCard({
    required this.product,
    required this.onRemove,
    required this.onTap,
    required this.onAddToCart,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final originalPrice = (product.price * 1.8).round();
    final discountPercent =
        ((1 - (product.price / originalPrice)) * 100).round();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with remove button
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
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
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  // Remove from wishlist button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Sale badge
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: width >= 600 ? 8 : 6,
                        vertical: width >= 600 ? 3 : 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red[600],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: width >= 600 ? 10 : 9,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Product Info
            Padding(
              padding: EdgeInsets.fromLTRB(
                width >= 600 ? 12 : 10,
                width >= 600 ? 5 : 4,
                width >= 600 ? 12 : 10,
                width >= 600 ? 6 : 5,
              ),
              child: Text(
                product.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: width >= 600 ? 14 : 13,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Price
            Padding(
              padding: EdgeInsets.fromLTRB(
                width >= 600 ? 12 : 10,
                width >= 600 ? 5 : 4,
                width >= 600 ? 12 : 10,
                width >= 600 ? 8 : 6,
              ),
              child: Row(
                children: [
                  Text(
                    '₹${product.price.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width >= 600 ? 14 : 13,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: width >= 600 ? 6 : 4),
                  Text(
                    '₹$originalPrice',
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey[500],
                      fontSize: width >= 600 ? 12 : 10,
                    ),
                  ),
                ],
              ),
            ),
            // Add to Cart Button
            Padding(
              padding: EdgeInsets.fromLTRB(
                width >= 600 ? 12 : 10,
                0,
                width >= 600 ? 12 : 10,
                width >= 600 ? 12 : 10,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAddToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(
                      vertical: width >= 600 ? 10 : 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: width >= 600 ? 13 : 12,
                    ),
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



