import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jootabazar/screen/cart/cart_screen.dart';
import 'package:jootabazar/screen/home/provider/product_riverpood.dart';
import 'package:jootabazar/screen/product_detail_screen.dart';
import 'package:jootabazar/widgets/top_menu_header.dart';

import '../../model/product_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedCategory = 'All';
  String _selectedMenSubCategory = 'All';
  bool _isGridView = true;
  late final PageController _bannerController;
  Timer? _bannerTimer;
  int _currentBanner = 0;

  final List<_BannerData> _banners = const [
    _BannerData(imageUrl: 'https://i.ibb.co/Q39V7sSn/banner-1.jpg'),
    _BannerData(imageUrl: 'https://i.ibb.co/VY7MnHNr/banner-2.png'),
    _BannerData(imageUrl: 'https://i.ibb.co/twpW272w/banner-3.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    // Will be updated in build method with responsive value
    _bannerController = PageController(viewportFraction: 0.9);
    _startBannerAutoScroll();
  }

  void _startBannerAutoScroll() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_banners.isEmpty || !_bannerController.hasClients) return;
      final nextPage = (_currentBanner + 1) % _banners.length;
      _bannerController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      setState(() => _currentBanner = nextPage);
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_selectedCategory == 'All') return products;
    var filtered = products
        .where((product) => product.category == _selectedCategory)
        .toList();

    // Optional sub-filter for Men sub categories (UI first, data later)
    if (_selectedCategory == 'Men' && _selectedMenSubCategory != 'All') {}

    return filtered;
  }

  int _calculateCrossAxisCount(double width) {
    if (width >= 1200) return 4;
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 2; // Always 2 columns on mobile
  }

  double _calculateAspectRatio(double width) {
    if (width >= 1200) return 0.65;
    if (width >= 900) return 0.7;
    if (width >= 600) return 0.75;
    return 0.8; // Smaller cards on mobile
  }

  double _calculateBannerHeight(double width) {
    if (width >= 1400) return 420;
    if (width >= 1100) return 360;
    if (width >= 900) return 320;
    if (width >= 700) return 280;
    if (width >= 500) return 240;
    return 200;
  }

  // Responsive padding calculations
  double _getHorizontalPadding(double width) {
    if (width >= 1400) return 40;
    if (width >= 1200) return 32;
    if (width >= 900) return 24;
    if (width >= 600) return 20;
    return 16;
  }

  double _getVerticalPadding(double width) {
    if (width >= 1200) return 32;
    if (width >= 900) return 28;
    if (width >= 600) return 24;
    return 20;
  }

  // Responsive font sizes
  double _getTitleFontSize(double width) {
    if (width >= 1200) return 32;
    if (width >= 900) return 28;
    if (width >= 600) return 24;
    return 22;
  }

  double _getSubtitleFontSize(double width) {
    if (width >= 1200) return 18;
    if (width >= 900) return 16;
    if (width >= 600) return 15;
    return 14;
  }

  double _getCategoryTitleFontSize(double width) {
    if (width >= 1200) return 18;
    if (width >= 900) return 16;
    if (width >= 600) return 14;
    return 16;
  }

  double _getCategoryChipFontSize(double width) {
    if (width >= 900) return 12;
    if (width >= 600) return 10;
    return 13;
  }

  double _getSearchFontSize(double width) {
    if (width >= 900) return 16;
    if (width >= 600) return 15;
    return 14;
  }

  // Responsive icon sizes
  double _getHeaderIconSize(double width) {
    if (width >= 1200) return 32;
    if (width >= 900) return 28;
    if (width >= 600) return 24;
    return 22;
  }

  double _getNotificationIconSize(double width) {
    if (width >= 1200) return 28;
    if (width >= 900) return 24;
    if (width >= 600) return 22;
    return 20;
  }

  // Responsive spacing
  double _getSectionSpacing(double width) {
    if (width >= 1200) return 32;
    if (width >= 900) return 28;
    if (width >= 600) return 24;
    return 20;
  }

  double _getSmallSpacing(double width) {
    if (width >= 900) return 16;
    if (width >= 600) return 14;
    return 12;
  }

  // Responsive category tile height
  double _getCategoryTileHeight(double width) {
    if (width >= 900) return 60;
    if (width >= 600) return 56;
    return 52;
  }

  // Responsive banner viewport fraction
  double _getBannerViewportFraction(double width) {
    if (width >= 1200) return 0.85;
    if (width >= 900) return 0.9;
    return 0.95;
  }

  // Responsive grid spacing
  double _getGridSpacing(double width) {
    if (width >= 1200) return 16;
    if (width >= 900) return 12;
    if (width >= 600) return 8;
    return 5;
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productsProvider);
    final filteredProducts = _filterProducts(products);
    final width = MediaQuery.of(context).size.width;
    final bannerHeight = _calculateBannerHeight(width);
    final horizontalPadding = _getHorizontalPadding(width);
    final verticalPadding = _getVerticalPadding(width);
    final titleFontSize = _getTitleFontSize(width);
    final subtitleFontSize = _getSubtitleFontSize(width);
    final categoryTitleFontSize = _getCategoryTitleFontSize(width);
    final categoryChipFontSize = _getCategoryChipFontSize(width);
    final searchFontSize = _getSearchFontSize(width);
    final headerIconSize = _getHeaderIconSize(width);
    final notificationIconSize = _getNotificationIconSize(width);
    final sectionSpacing = _getSectionSpacing(width);
    final smallSpacing = _getSmallSpacing(width);
    final categoryTileHeight = _getCategoryTileHeight(width);
    final gridSpacing = _getGridSpacing(width);

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
              SliverToBoxAdapter(
                child: const TopMenuHeader(),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Discover Your Style',
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: width >= 600 ? 8 : 6),
                      Text(
                        'Find the perfect pair for you',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          style: TextStyle(fontSize: searchFontSize),
                          decoration: InputDecoration(
                            hintText: 'Search for shoes...',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: searchFontSize,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[600],
                              size: width >= 600 ? 24 : 20,
                            ),
                            suffixIcon: Container(
                              margin: EdgeInsets.all(width >= 600 ? 8 : 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.grey[800]!],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.tune,
                                color: Colors.white,
                                size: width >= 600 ? 20 : 18,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: width >= 600 ? 20 : 16,
                              vertical: width >= 600 ? 16 : 14,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      SizedBox(
                        height: bannerHeight,
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: _bannerController,
                                onPageChanged: (index) {
                                  setState(() => _currentBanner = index);
                                },
                                itemCount: _banners.length,
                                itemBuilder: (context, index) {
                                  final banner = _banners[index];
                                  return AnimatedPadding(
                                    duration: const Duration(milliseconds: 300),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: _currentBanner == index
                                          ? 4
                                          : 12,
                                      vertical: _currentBanner == index ? 0 : 8,
                                    ),
                                    child: _BannerCard(
                                      data: banner,
                                      isActive: _currentBanner == index,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                _banners.length,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  height: 8,
                                  width: _currentBanner == index ? 24 : 10,
                                  decoration: BoxDecoration(
                                    color: _currentBanner == index
                                        ? Colors.black
                                        : Colors.black.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: sectionSpacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: categoryTitleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(width >= 600 ? 4 : 3),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              children: [
                                _ViewToggleIcon(
                                  icon: Icons.grid_view_rounded,
                                  isActive: _isGridView,
                                  iconSize: width >= 600 ? 18 : 16,
                                  onTap: () {
                                    if (!_isGridView) {
                                      setState(() => _isGridView = true);
                                    }
                                  },
                                ),
                                _ViewToggleIcon(
                                  icon: Icons.view_list_rounded,
                                  isActive: !_isGridView,
                                  iconSize: width >= 600 ? 18 : 16,
                                  onTap: () {
                                    if (_isGridView) {
                                      setState(() => _isGridView = false);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: smallSpacing),
                      SizedBox(
                        height: categoryTileHeight,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryTile(
                              name: 'All',
                              isSelected: _selectedCategory == 'All',
                              width: width,
                              onTap: () =>
                                  setState(() => _selectedCategory = 'All'),
                            ),
                            CategoryTile(
                              name: 'Men',
                              isSelected: _selectedCategory == 'Men',
                              width: width,
                              onTap: () =>
                                  setState(() => _selectedCategory = 'Men'),
                            ),
                            CategoryTile(
                              name: 'Women',
                              isSelected: _selectedCategory == 'Women',
                              width: width,
                              onTap: () =>
                                  setState(() => _selectedCategory = 'Women'),
                            ),
                            CategoryTile(
                              name: 'Kids',
                              isSelected: _selectedCategory == 'Kids',
                              width: width,
                              onTap: () =>
                                  setState(() => _selectedCategory = 'Kids'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: smallSpacing * 0.75),
                      if (_selectedCategory == 'Men')
                        SizedBox(
                          height: width >= 600 ? 44 : 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _MenSubCategoryChip(
                                label: 'All',
                                isSelected: _selectedMenSubCategory == 'All',
                                width: width,
                                onTap: () => setState(
                                  () => _selectedMenSubCategory = 'All',
                                ),
                              ),
                              _MenSubCategoryChip(
                                label: 'Sandals',
                                isSelected:
                                    _selectedMenSubCategory == 'Sandals',
                                width: width,
                                onTap: () => setState(
                                  () => _selectedMenSubCategory = 'Sandals',
                                ),
                              ),
                              _MenSubCategoryChip(
                                label: 'Home Made',
                                isSelected:
                                    _selectedMenSubCategory == 'Home Made',
                                width: width,
                                onTap: () => setState(
                                  () => _selectedMenSubCategory = 'Home Made',
                                ),
                              ),
                              _MenSubCategoryChip(
                                label: 'Shoes',
                                isSelected: _selectedMenSubCategory == 'Shoes',
                                width: width,
                                onTap: () => setState(
                                  () => _selectedMenSubCategory = 'Shoes',
                                ),
                              ),
                              _MenSubCategoryChip(
                                label: 'Chappal',
                                isSelected:
                                    _selectedMenSubCategory == 'Chappal',
                                width: width,
                                onTap: () => setState(
                                  () => _selectedMenSubCategory = 'Chappal',
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                sliver: _isGridView
                    ? SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = filteredProducts[index];
                          return ProductCard(product: product, width: width);
                        }, childCount: filteredProducts.length),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _calculateCrossAxisCount(width),
                          mainAxisSpacing: gridSpacing,
                          crossAxisSpacing: gridSpacing,
                          childAspectRatio: _calculateAspectRatio(width),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final product = filteredProducts[index];
                          return Padding(
                            padding: EdgeInsets.only(bottom: gridSpacing),
                            child: _ProductListTile(
                              product: product,
                              width: width,
                            ),
                          );
                        }, childCount: filteredProducts.length),
                      ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: width >= 600 ? 100 : 80),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryTile extends StatefulWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  const CategoryTile({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: widget.width >= 600 ? 12 : 8),
          padding: EdgeInsets.symmetric(
            horizontal: widget.width >= 900
                ? 24
                : widget.width >= 600
                ? 20
                : 16,
            vertical: widget.width >= 600 ? 12 : 10,
          ),
          decoration: BoxDecoration(
            gradient: widget.isSelected || _hover
                ? LinearGradient(
                    colors: [Colors.black, Colors.grey[800]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: widget.isSelected || _hover ? null : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: widget.isSelected || _hover
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
            border: Border.all(
              color: widget.isSelected ? Colors.transparent : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                color: widget.isSelected || _hover
                    ? Colors.white
                    : Colors.grey[700],
                fontWeight: widget.isSelected
                    ? FontWeight.bold
                    : FontWeight.w600,
                fontSize: widget.width >= 900
                    ? 15
                    : widget.width >= 600
                    ? 14
                    : 13,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenSubCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  const _MenSubCategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: width >= 600 ? 10 : 8),
          padding: EdgeInsets.symmetric(
            horizontal: width >= 600 ? 16 : 12,
            vertical: width >= 600 ? 8 : 6,
          ),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? Colors.black : Colors.grey[300]!,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: width >= 600 ? 13 : 12,
            ),
          ),
        ),
      ),
    );
  }
}

class _ViewToggleIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final double iconSize;

  const _ViewToggleIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: isActive ? Colors.white : Colors.grey[700],
        ),
      ),
    );
  }
}

class _ProductListTile extends StatelessWidget {
  final Product product;
  final double width;

  const _ProductListTile({required this.product, required this.width});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(width >= 600 ? 12 : 10),
          child: Row(
            children: [
              // Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: width >= 600 ? 90 : 80,
                  height: width >= 600 ? 90 : 80,
                  color: Colors.white,
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
                      size: width >= 600 ? 32 : 28,
                    ),
                  ),
                ),
              ),
              SizedBox(width: width >= 600 ? 16 : 12),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
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
                      product.category,
                      style: TextStyle(
                        fontSize: width >= 600 ? 13 : 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: width >= 600 ? 10 : 8),
                    getPriceText(product),
                  ],
                ),
              ),

              SizedBox(width: width >= 600 ? 8 : 6),

              // CTA
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: width >= 600 ? 12 : 10,
                  vertical: width >= 600 ? 8 : 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                      size: width >= 600 ? 16 : 14,
                    ),
                    SizedBox(width: width >= 600 ? 6 : 4),
                    Text(
                      'View',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: width >= 600 ? 13 : 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Product product;
  final double width;
  const ProductCard({super.key, required this.product, required this.width});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _hover = false;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final originalPrice = (widget.product.price * 1.8).round();
    final discountPercent = ((1 - (widget.product.price / originalPrice)) * 100)
        .round();

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailScreen(product: widget.product),
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()..scale(_hover ? 1.02 : 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
            boxShadow: _hover
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.width >= 600 ? 5 : 4,
                  vertical: widget.width >= 600 ? 8 : 6,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, top: 2, right: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.width >= 600 ? 8 : 6,
                          vertical: widget.width >= 600 ? 3 : 2,
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
                            fontSize: widget.width >= 600 ? 10 : 9,
                          ),
                        ),
                      ),
                      SizedBox(width: widget.width >= 600 ? 6 : 4),
                      Text(
                        '$discountPercent% off',
                        style: TextStyle(
                          color: Colors.red[600],
                          fontWeight: FontWeight.w600,
                          fontSize: widget.width >= 600 ? 10 : 9,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => setState(() => _isFavorite = !_isFavorite),
                        child: Icon(
                          _isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: _isFavorite ? Colors.red : Colors.grey[500],
                          size: widget.width >= 600 ? 20 : 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: widget.product.imageUrl,
                        fit: BoxFit.contain,
                        width: 100,
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
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  widget.width >= 600 ? 12 : 10,
                  widget.width >= 600 ? 5 : 4,
                  widget.width >= 600 ? 12 : 10,
                  widget.width >= 600 ? 6 : 5,
                ),
                child: Text(
                  widget.product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.width >= 600 ? 14 : 13,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  widget.width >= 600 ? 12 : 10,
                  widget.width >= 600 ? 5 : 4,
                  widget.width >= 600 ? 12 : 10,
                  widget.width >= 600 ? 12 : 10,
                ),
                child: Row(
                  children: [
                    Text(
                      '₹${widget.product.price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: widget.width >= 600 ? 12 : 11,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: widget.width >= 600 ? 6 : 4),
                    Text(
                      '₹$originalPrice',
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey[500],
                        fontSize: widget.width >= 600 ? 12 : 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerData {
  final String imageUrl;

  const _BannerData({required this.imageUrl});
}

class _BannerCard extends StatelessWidget {
  final _BannerData data;
  final bool isActive;

  const _BannerCard({super.key, required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: CachedNetworkImage(imageUrl: data.imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}

Widget getPriceText(Product product) {
  return LayoutBuilder(
    builder: (context, constraints) {
      double width = constraints.maxWidth;

      // Responsive font sizes
      double priceFont = width < 450
          ? 14
          : width < 800
          ? 16
          : 18;
      double cutPriceFont = width < 450
          ? 10
          : width < 800
          ? 12
          : 13;

      return Row(
        children: [
          Text(
            '₹${product.price.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: priceFont,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '₹${(product.price * 1.8).round()}',
            style: GoogleFonts.poppins(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey[600],
              fontSize: cutPriceFont,
            ),
          ),
        ],
      );
    },
  );
}
