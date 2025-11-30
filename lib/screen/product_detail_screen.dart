import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jootabazar/model/product_model.dart';
import 'package:jootabazar/screen/home/provider/product_riverpood.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  int _selectedImageIndex = 0;
  bool _isFavorite = false;
  String _selectedSize = '8';
  bool _isInStock = true; // Stock status

  // Generate multiple image URLs for the product (using the same image for demo)
  List<String> get _productImages => [
        widget.product.imageUrl,
        widget.product.imageUrl,
        widget.product.imageUrl,
      ];

  void _openFullScreenImage(int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenImageViewer(
          images: _productImages,
          initialIndex: initialIndex,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final originalPrice = (widget.product.price * 1.8).round();
    final discountPercent =
        ((1 - (widget.product.price / originalPrice)) * 100).round();

    // Get similar products (same category, excluding current product)
    final similarProducts = products
        .where((p) =>
            p.category == widget.product.category && p.id != widget.product.id)
        .toList();

    // If no similar products in same category, get other products
    final displaySimilarProducts = similarProducts.isEmpty
        ? products.where((p) => p.id != widget.product.id).take(4).toList()
        : similarProducts.take(4).toList();

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
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 0,
                floating: true,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.all(8),
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
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.all(8),
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
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.black,
                      ),
                      onPressed: () =>
                          setState(() => _isFavorite = !_isFavorite),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // Product Images with Scroll
              SliverToBoxAdapter(
                child: Container(
                  height: 400,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    children: [
                      // Main Image
                      Expanded(
                        child: PageView.builder(
                          itemCount: _productImages.length,
                          onPageChanged: (index) {
                            setState(() => _selectedImageIndex = index);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => _openFullScreenImage(index),
                              child: _ZoomableImage(
                                imageUrl: _productImages[index],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Image Indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _productImages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: _selectedImageIndex == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: _selectedImageIndex == index
                                  ? Colors.black
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Product Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Stock Status
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: _isInStock ? Colors.green[50] : Colors.red[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _isInStock
                                ? Colors.green[300]!
                                : Colors.red[300]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _isInStock ? Icons.check_circle : Icons.cancel,
                              color: _isInStock ? Colors.green[700] : Colors.red[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _isInStock ? 'In Stock' : 'Out of Stock',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _isInStock
                                    ? Colors.green[700]
                                    : Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Price Section
                      Row(
                        children: [
                          Text(
                            '₹${widget.product.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '₹$originalPrice',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[500],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$discountPercent% OFF',
                              style: TextStyle(
                                color: Colors.red[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Size Selection
                      const Text(
                        'Select Size',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: ['6', '7', '8', '9', '10', '11'].map((size) {
                          final isSelected = _selectedSize == size;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedSize = size),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.black
                                      : Colors.grey[300]!,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                size,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Delivery Information
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.local_shipping,
                                  color: Colors.blue[700],
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Delivery Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _buildDeliveryRow(
                              'Standard Delivery',
                              '3-5 business days',
                              'Free',
                              Icons.delivery_dining,
                            ),
                            const Divider(height: 24),
                            _buildDeliveryRow(
                              'Express Delivery',
                              '1-2 business days',
                              '₹99',
                              Icons.flash_on,
                            ),
                            const Divider(height: 24),
                            _buildDeliveryRow(
                              'Same Day Delivery',
                              'Order before 2 PM',
                              '₹199',
                              Icons.timer,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Product Details
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Category', widget.product.category),
                            const Divider(height: 24),
                            _buildDetailRow('Material', 'Premium Leather'),
                            const Divider(height: 24),
                            _buildDetailRow('Sole', 'Rubber'),
                            const Divider(height: 24),
                            _buildDetailRow('Closure', 'Lace-Up'),
                            const Divider(height: 24),
                            _buildDetailRow(
                              'Description',
                              'High-quality ${widget.product.name.toLowerCase()} designed for comfort and style. Perfect for everyday wear with excellent durability and modern design.',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Similar Products Section
                      if (displaySimilarProducts.isNotEmpty) ...[
                        const Text(
                          'Similar Products',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 280,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: displaySimilarProducts.length,
                            itemBuilder: (context, index) {
                              final product = displaySimilarProducts[index];
                              return _SimilarProductCard(
                                product: product,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreen(product: product),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
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
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _isInStock
                      ? () {
                          // Add to cart functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _isInStock
                      ? () {
                          // Buy now functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Proceeding to checkout!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Buy Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryRow(
    String title,
    String description,
    String price,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue[700], size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Text(
          price,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: price == 'Free' ? Colors.green[700] : Colors.black87,
          ),
        ),
      ],
    );
  }
}

// Full Screen Image Viewer
class _FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenImageViewer({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenImageViewer> createState() =>
      _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _pageController;
  late int _currentIndex;
  TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformationController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    '${_currentIndex + 1} / ${widget.images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_out_map,
                        color: Colors.white, size: 28),
                    onPressed: _resetZoom,
                  ),
                ],
              ),
            ),

            // Image Viewer
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _resetZoom();
                  });
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 1.0,
                    maxScale: 4.0,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.images[index],
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Image Selection
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final isSelected = _currentIndex == index;
                  return GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.grey[700]!,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: widget.images[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[800],
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoomableImage extends StatefulWidget {
  final String imageUrl;

  const _ZoomableImage({required this.imageUrl});

  @override
  State<_ZoomableImage> createState() => _ZoomableImageState();
}

class _ZoomableImageState extends State<_ZoomableImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AnimatedScale(
            scale: _isHovered ? 1.2 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
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
                size: 50,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SimilarProductImage extends StatefulWidget {
  final String imageUrl;

  const _SimilarProductImage({required this.imageUrl});

  @override
  State<_SimilarProductImage> createState() => _SimilarProductImageState();
}

class _SimilarProductImageState extends State<_SimilarProductImage> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: AnimatedScale(
            scale: _isHovered ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
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
      ),
    );
  }
}

class _SimilarProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _SimilarProductCard({
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final originalPrice = (product.price * 1.8).round();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
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
            // Product Image
            Expanded(
              child: _SimilarProductImage(imageUrl: product.imageUrl),
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '₹$originalPrice',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[500],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

