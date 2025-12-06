import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jootabazar/screen/home/provider/product_riverpood.dart';
import 'package:jootabazar/screen/product_detail_screen.dart';
import 'package:jootabazar/screen/wishlist/provider/wishlist_provider.dart';
import 'package:jootabazar/widgets/app_footer.dart';
import 'package:jootabazar/widgets/top_menu_header.dart';

import '../../model/product_model.dart';
import '../../uttils/constant.dart';

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

  // Search and filter state
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _filterCategory;
  String _sortBy = 'Default';
  RangeValues _priceRange = const RangeValues(0, 5000);

  final List<_BannerData> _banners = const [
    _BannerData(
      imageUrl:
          'https://i.ibb.co/HfSXP89h/Chat-GPT-Image-Dec-5-2025-09-59-35-PM.png',
    ),
    _BannerData(
      imageUrl:
          'https://i.ibb.co/9m1sJ59p/Chat-GPT-Image-Dec-5-2025-10-09-48-PM.png',
    ),
    _BannerData(
      imageUrl:
          'https://i.ibb.co/N6gJvpsx/Gemini-Generated-Image-lneysulneysulney.png',
    ),
    _BannerData(
      imageUrl:
          'https://i.ibb.co/zWN9NBCP/Green-and-Yellow-Simple-Clean-Shoes-Sale-Banner.png',
    ),
    _BannerData(
      imageUrl: 'https://i.ibb.co/KpzNcL4H/shoes-sale-Banner-Landscape.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
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
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _filterProducts(List<Product> products) {
    var filtered = products;

    // Apply category filter
    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((product) => product.category == _selectedCategory)
          .toList();
    }

    // Apply search query filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (product) =>
                product.name.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                product.category.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    // Apply filter dialog category filter
    if (_filterCategory != null && _filterCategory != 'All') {
      filtered = filtered
          .where((product) => product.category == _filterCategory)
          .toList();
    }

    // Apply price range filter
    filtered = filtered
        .where(
          (product) =>
              product.price >= _priceRange.start &&
              product.price <= _priceRange.end,
        )
        .toList();

    // Apply sorting
    if (_sortBy == 'Price: Low to High') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Price: High to Low') {
      filtered.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'Name: A to Z') {
      filtered.sort((a, b) => a.name.compareTo(b.name));
    }

    return filtered;
  }

  void _showFilterDialog(BuildContext context, double width) {
    String? tempFilterCategory = _filterCategory;
    String tempSortBy = _sortBy;
    RangeValues tempPriceRange = _priceRange;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: width >= 600 ? 500 : double.infinity,
                  maxHeight: MediaQuery.of(context).size.height * 0.85,
                ),
                padding: EdgeInsets.all(width >= 600 ? 24 : 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter Products',
                          style: TextStyle(
                            fontSize: width >= 600 ? 24 : 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Category Filter
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: width >= 600 ? 16 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['All', 'Men', 'Women', 'Kids'].map((category) {
                        final isSelected =
                            tempFilterCategory == category ||
                            (tempFilterCategory == null && category == 'All');
                        return FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setDialogState(() {
                              tempFilterCategory = selected ? category : null;
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          checkmarkColor: Colors.white,
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 24),

                    // Price Range
                    Text(
                      'Price Range',
                      style: TextStyle(
                        fontSize: width >= 600 ? 16 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    RangeSlider(
                      values: tempPriceRange,
                      min: 0,
                      max: 5000,
                      divisions: 50,
                      labels: RangeLabels(
                        '₹${tempPriceRange.start.round()}',
                        '₹${tempPriceRange.end.round()}',
                      ),
                      onChanged: (RangeValues values) {
                        setDialogState(() {
                          tempPriceRange = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${tempPriceRange.start.round()}',
                          style: TextStyle(
                            fontSize: width >= 600 ? 14 : 12,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(
                          '₹${tempPriceRange.end.round()}',
                          style: TextStyle(
                            fontSize: width >= 600 ? 14 : 12,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sort By
                    Text(
                      'Sort By',
                      style: TextStyle(
                        fontSize: width >= 600 ? 16 : 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...[
                      'Default',
                      'Price: Low to High',
                      'Price: High to Low',
                      'Name: A to Z',
                    ].map((sortOption) {
                      final isSelected = tempSortBy == sortOption;
                      return RadioListTile<String>(
                        title: Text(
                          sortOption,
                          style: TextStyle(
                            fontSize: width >= 600 ? 15 : 14,
                            color: Colors.black87,
                          ),
                        ),
                        value: sortOption,
                        groupValue: tempSortBy,
                        onChanged: (value) {
                          setDialogState(() {
                            tempSortBy = value!;
                          });
                        },
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                      );
                    }).toList(),

                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              setDialogState(() {
                                tempFilterCategory = null;
                                tempSortBy = 'Default';
                                tempPriceRange = const RangeValues(0, 5000);
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: width >= 600 ? 16 : 14,
                              ),
                              side: BorderSide(color: Colors.grey[300]!),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Reset',
                              style: TextStyle(
                                fontSize: width >= 600 ? 15 : 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _filterCategory = tempFilterCategory;
                                _sortBy = tempSortBy;
                                _priceRange = tempPriceRange;
                              });
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: width >= 600 ? 16 : 14,
                              ),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: TextStyle(
                                fontSize: width >= 600 ? 15 : 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
    // Make banner square - use the available width minus padding
    final horizontalPadding = _getHorizontalPadding(width);
    final availableWidth = width - (horizontalPadding * 2);
    // Return square height (same as available width)
    return availableWidth;
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
              SliverToBoxAdapter(child: const TopMenuHeader()),
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
                      SizedBox(height: width >= 600 ? 12 : 10),
                      Row(
                        children: [
                          Text(
                            'Handmade with Love, Worn with Trust.',
                            style: TextStyle(
                              fontSize: width >= 1200
                                  ? 16
                                  : width >= 900
                                  ? 15
                                  : width >= 600
                                  ? 14
                                  : 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(width: width >= 600 ? 6 : 4),
                          Text(
                            '❤️',
                            style: TextStyle(fontSize: width >= 600 ? 16 : 14),
                          ),
                        ],
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
                          controller: _searchController,
                          style: TextStyle(fontSize: searchFontSize),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
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
                            suffixIcon: _searchQuery.isNotEmpty
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.clear,
                                          color: Colors.grey[600],
                                          size: width >= 600 ? 20 : 18,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _searchQuery = '';
                                            _searchController.clear();
                                          });
                                        },
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            _showFilterDialog(context, width),
                                        child: Container(
                                          margin: EdgeInsets.all(
                                            width >= 600 ? 8 : 6,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.black,
                                                Colors.grey[800]!,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.tune,
                                            color: Colors.white,
                                            size: width >= 600 ? 20 : 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: () =>
                                        _showFilterDialog(context, width),
                                    child: Container(
                                      margin: EdgeInsets.all(
                                        width >= 600 ? 8 : 6,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.grey[800]!,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        Icons.tune,
                                        color: Colors.white,
                                        size: width >= 600 ? 20 : 18,
                                      ),
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
                                      width: width,
                                      horizontalPadding: horizontalPadding,
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

                            CategoryTile(
                              name: Contants().categorySport,
                              isSelected:
                                  _selectedCategory == Contants().categorySport,
                              width: width,
                              onTap: () => setState(
                                () => _selectedCategory =
                                    Contants().categorySport,
                              ),
                            ),

                            CategoryTile(
                              name: Contants().categoryChappal,
                              isSelected:
                                  _selectedCategory ==
                                  Contants().categoryChappal,
                              width: width,
                              onTap: () => setState(
                                () => _selectedCategory =
                                    Contants().categoryChappal,
                              ),
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
                      SizedBox(height: 20.sp),
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
              SliverToBoxAdapter(child: const AppFooter()),
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

class ProductCard extends ConsumerStatefulWidget {
  final Product product;
  final double width;
  const ProductCard({super.key, required this.product, required this.width});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  bool _hover = false;

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
                        onTap: () {
                          ref
                              .read(wishlistProvider.notifier)
                              .toggleWishlist(widget.product);
                        },
                        child: Icon(
                          ref
                                  .watch(wishlistProvider)
                                  .any((p) => p.id == widget.product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              ref
                                  .watch(wishlistProvider)
                                  .any((p) => p.id == widget.product.id)
                              ? Colors.red
                              : Colors.grey[500],
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

class _BannerCard extends StatefulWidget {
  final _BannerData data;
  final bool isActive;
  final double width;
  final double horizontalPadding;

  const _BannerCard({
    super.key,
    required this.data,
    required this.isActive,
    required this.width,
    required this.horizontalPadding,
  });

  @override
  State<_BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<_BannerCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    if (widget.isActive) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(_BannerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxPadding = 4.0;
    final availableWidth =
        widget.width - (widget.horizontalPadding * 2) - (maxPadding * 2);
    final squareSize = availableWidth;
    final theme = Theme.of(context);
    final isSmallScreen = widget.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovering ? _scaleAnimation.value : 1.0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOut,
              width: squareSize,
              height: squareSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(_isHovering ? 0.2 : 0.1),
                    blurRadius: _isHovering ? 30 : 20,
                    offset: const Offset(0, 8),
                    spreadRadius: _isHovering ? 2 : 0,
                  ),
                ],
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: CachedNetworkImage(
                      imageUrl: widget.data.imageUrl,
                      fit: BoxFit.cover,
                      width: squareSize,
                      height: squareSize,
                    ),
                  ),

                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Title
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _isHovering ? 1.0 : 0.9,
                          child: Text(
                            'New Collection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Description
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _isHovering ? 0.9 : 0.8,
                          child: Text(
                            'Discover our latest styles',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: isSmallScreen ? 24 : 32,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // CTA Button
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: _isHovering ? 1.0 : 0.0,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            transform: Matrix4.translationValues(
                              0,
                              _isHovering ? 0 : 20,
                              0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle CTA
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 20 : 30,
                                  vertical: isSmallScreen ? 12 : 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 3,
                              ),
                              child: Text(
                                'Shop Now',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 14 : 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
