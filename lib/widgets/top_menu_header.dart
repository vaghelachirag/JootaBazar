import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screen/cart/cart_screen.dart';
import '../screen/cart/provider/cart_provider.dart';

class TopMenuHeader extends ConsumerWidget {
  const TopMenuHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final cartItemCount = ref.watch(cartItemCountProvider);
    final isMobile = width < 600;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: width >= 1200
            ? 40
            : width >= 900
            ? 32
            : width >= 600
            ? 24
            : 16,
        vertical: width >= 600 ? 16 : 12,
      ),
      child: Row(
        children: [
          // Logo Section
          _buildLogo(context, width),

          // Navigation Menu (hidden on mobile)
          if (!isMobile) ...[
            SizedBox(width: width >= 1200 ? 40 : 24),
            Expanded(child: _buildNavigationMenu(context, width)),
          ],

          // Hamburger menu for mobile
          if (isMobile) ...[
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.grey),
              onPressed: () {
                // Show bottom sheet or drawer with menu items
                _showMobileMenu(context, ref, cartItemCount, width);
              },
            ),
          ],

          // Right side utilities
          if (!isMobile) const Spacer(),
          SizedBox(width: width >= 600 ? 16 : 8),
          _buildUtilityIcons(context, ref, cartItemCount, width),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context, double width) {
    return GestureDetector(
      onTap: () {
        // Navigate to home or scroll to top
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // RED text in red
          Text(
            'RED',
            style: TextStyle(
              fontSize: width >= 1200
                  ? 28
                  : width >= 600
                  ? 24
                  : 20,
              fontWeight: FontWeight.bold,
              color: Colors.red[700],
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(width: 4),
          // CHIEF text in blue
          Text(
            'CHIEF',
            style: TextStyle(
              fontSize: width >= 1200
                  ? 28
                  : width >= 600
                  ? 24
                  : 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[700],
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationMenu(BuildContext context, double width) {
    final menuItems = [
      _MenuItem(title: 'New Drops', hasDropdown: false),
      _MenuItem(title: 'Best Sellers', hasDropdown: false),
      _MenuItem(title: 'Shop Men', hasDropdown: true),
      _MenuItem(title: 'Red Chief Sports', hasDropdown: true),
      _MenuItem(title: 'Sale', hasDropdown: false),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: menuItems.map((item) {
        return _NavigationItem(
          title: item.title,
          hasDropdown: item.hasDropdown,
          width: width,
        );
      }).toList(),
    );
  }

  Widget _buildUtilityIcons(
    BuildContext context,
    WidgetRef ref,
    int cartItemCount,
    double width,
  ) {
    final iconSize = width >= 600 ? 24.0 : 20.0;
    final fontSize = width >= 600 ? 14.0 : 12.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Hi with user icon
        Icon(Icons.person_outline, size: iconSize, color: Colors.grey[800]),

        SizedBox(width: width >= 600 ? 20 : 16),

        // Heart icon with badge
        _IconWithBadge(
          icon: Icons.favorite_border,
          badgeCount: 0,
          iconSize: iconSize,
          onTap: () {
            // Navigate to wishlist
          },
        ),

        SizedBox(width: width >= 600 ? 20 : 16),

        // Search icon
        GestureDetector(
          onTap: () {
            // Open search
          },
          child: Icon(Icons.search, size: iconSize, color: Colors.grey[800]),
        ),

        SizedBox(width: width >= 600 ? 20 : 16),

        // Shopping cart icon with badge
        _IconWithBadge(
          icon: Icons.shopping_cart_outlined,
          badgeCount: cartItemCount,
          iconSize: iconSize,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          },
        ),
      ],
    );
  }

  void _showMobileMenu(
    BuildContext context,
    WidgetRef ref,
    int cartItemCount,
    double width,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _MobileMenuItem(
              title: 'New Drops',
              onTap: () => Navigator.pop(context),
            ),
            _MobileMenuItem(
              title: 'Best Sellers',
              onTap: () => Navigator.pop(context),
            ),
            _MobileMenuItem(
              title: 'Shop Men',
              onTap: () => Navigator.pop(context),
            ),
            _MobileMenuItem(
              title: 'Red Chief Sports',
              onTap: () => Navigator.pop(context),
            ),
            _MobileMenuItem(title: 'Sale', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _MobileMenuItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MobileMenuItem({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}

class _MenuItem {
  final String title;
  final bool hasDropdown;

  _MenuItem({required this.title, required this.hasDropdown});
}

class _NavigationItem extends StatefulWidget {
  final String title;
  final bool hasDropdown;
  final double width;

  const _NavigationItem({
    required this.title,
    required this.hasDropdown,
    required this.width,
  });

  @override
  State<_NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<_NavigationItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          // Handle navigation
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: widget.width >= 1200 ? 12 : 8,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: widget.width >= 1200 ? 12 : 8,
            vertical: 8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: widget.width >= 1200 ? 15 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              if (widget.hasDropdown) ...[
                SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_down,
                  size: widget.width >= 1200 ? 18 : 16,
                  color: Colors.grey[800],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _IconWithBadge extends StatelessWidget {
  final IconData icon;
  final int badgeCount;
  final double iconSize;
  final VoidCallback onTap;

  const _IconWithBadge({
    required this.icon,
    required this.badgeCount,
    required this.iconSize,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon, size: iconSize, color: Colors.grey[800]),
          if (badgeCount > 0)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Center(
                  child: Text(
                    badgeCount > 9 ? '9+' : '$badgeCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          else
          // Show badge with 0 for wishlist
          if (icon == Icons.favorite_border)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: const Center(
                  child: Text(
                    '0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
