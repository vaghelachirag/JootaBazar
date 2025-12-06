import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../uttils/constant.dart';

// Color scheme constants
class _FooterColors {
  static const darkBrown = Color(0xFF4A2C2A);
  static const tan = Color(0xFFD7B899);
  static const goldAccent = Color(0xFFC9A86A);
  static const creamBackground = Color(0xFFF7F4EF);
  static const charcoalText = Color(0xFF222222);
}

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 900;
    final isDesktop = width >= 900;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _FooterColors.creamBackground,
        boxShadow: [
          BoxShadow(
            color: _FooterColors.darkBrown.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop
              ? 40
              : isTablet
              ? 32
              : 20,
          vertical: isDesktop
              ? 48
              : isTablet
              ? 40
              : 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Footer Content
            isMobile
                ? _buildMobileLayout(context, width)
                : _buildDesktopLayout(context, width, isDesktop),

            const SizedBox(height: 32),

            // Divider
            Divider(
              color: _FooterColors.darkBrown.withOpacity(0.2),
              thickness: 1,
            ),

            const SizedBox(height: 24),

            // Bottom Section (Copyright & Social Media)
            _buildBottomSection(context, width, isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and Tagline
        _buildLogoSection(width, true),
        const SizedBox(height: 32),

        // About Us
        _buildFooterSection(
          title: 'About Us',
          items: [
            _FooterItem(
              text: 'Our Story',
              onTap: () => _navigateToAboutUs(context),
            ),
            _FooterItem(
              text: 'Our Mission',
              onTap: () => _navigateToAboutUs(context),
            ),
            _FooterItem(
              text: 'Our Values',
              onTap: () => _navigateToAboutUs(context),
            ),
          ],
          width: width,
          isMobile: true,
        ),
        const SizedBox(height: 24),

        // Contact Us
        _buildFooterSection(
          title: 'Contact Us',
          items: [
            _FooterItem(
              text: 'Email: support@jootabazar.com',
              onTap: () => _launchEmail(),
            ),
            _FooterItem(
              text: 'Phone: +91 1234567890',
              onTap: () => _launchPhone(),
            ),
            _FooterItem(text: 'Address', onTap: () => _showAddress(context)),
          ],
          width: width,
          isMobile: true,
        ),
        const SizedBox(height: 24),

        // Why We Choose
        _buildFooterSection(
          title: 'Why Choose Us',
          items: [
            _FooterItem(
              text: 'Handmade Quality',
              onTap: () => _navigateToWhyChoose(context),
            ),
            _FooterItem(
              text: 'Traditional Craftsmanship',
              onTap: () => _navigateToWhyChoose(context),
            ),
            _FooterItem(
              text: 'Customer Satisfaction',
              onTap: () => _navigateToWhyChoose(context),
            ),
          ],
          width: width,
          isMobile: true,
        ),
        const SizedBox(height: 24),

        // Traditional Video
        _buildFooterSection(
          title: 'Learn More',
          items: [
            _FooterItem(
              text: 'Traditional Video',
              icon: Icons.play_circle_outline,
              onTap: () => _navigateToTraditionalVideo(context),
            ),
            _FooterItem(
              text: 'How We Make',
              onTap: () => _navigateToTraditionalVideo(context),
            ),
          ],
          width: width,
          isMobile: true,
        ),
        const SizedBox(height: 24),

        // Quick Links
        _buildFooterSection(
          title: 'Quick Links',
          items: [
            _FooterItem(
              text: 'Privacy Policy',
              onTap: () => _navigateToPrivacyPolicy(context),
            ),
            _FooterItem(
              text: 'Terms & Conditions',
              onTap: () => _navigateToTerms(context),
            ),
            _FooterItem(
              text: 'Shipping Info',
              onTap: () => _navigateToShipping(context),
            ),
            _FooterItem(
              text: 'Returns & Refunds',
              onTap: () => _navigateToReturns(context),
            ),
          ],
          width: width,
          isMobile: true,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    double width,
    bool isDesktop,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo Section
        Expanded(
          flex: isDesktop ? 3 : 2,
          child: _buildLogoSection(width, false),
        ),
        const SizedBox(width: 40),

        // About Us
        Expanded(
          flex: 2,
          child: _buildFooterSection(
            title: 'About Us',
            items: [
              _FooterItem(
                text: 'Our Story',
                onTap: () => _navigateToAboutUs(context),
              ),
              _FooterItem(
                text: 'Our Mission',
                onTap: () => _navigateToAboutUs(context),
              ),
              _FooterItem(
                text: 'Our Values',
                onTap: () => _navigateToAboutUs(context),
              ),
            ],
            width: width,
            isMobile: false,
          ),
        ),

        // Contact Us
        Expanded(
          flex: 2,
          child: _buildFooterSection(
            title: 'Contact Us',
            items: [
              _FooterItem(
                text: 'Email: support@jootabazar.com',
                onTap: () => _launchEmail(),
              ),
              _FooterItem(
                text: 'Phone: +91 1234567890',
                onTap: () => _launchPhone(),
              ),
              _FooterItem(text: 'Address', onTap: () => _showAddress(context)),
            ],
            width: width,
            isMobile: false,
          ),
        ),

        // Why Choose Us & Traditional Video
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFooterSection(
                title: 'Why Choose Us',
                items: [
                  _FooterItem(
                    text: 'Handmade Quality',
                    onTap: () => _navigateToWhyChoose(context),
                  ),
                  _FooterItem(
                    text: 'Traditional Craftsmanship',
                    onTap: () => _navigateToWhyChoose(context),
                  ),
                  _FooterItem(
                    text: 'Customer Satisfaction',
                    onTap: () => _navigateToWhyChoose(context),
                  ),
                ],
                width: width,
                isMobile: false,
              ),
              const SizedBox(height: 32),
              _buildFooterSection(
                title: 'Learn More',
                items: [
                  _FooterItem(
                    text: 'Traditional Video',
                    icon: Icons.play_circle_outline,
                    onTap: () => _navigateToTraditionalVideo(context),
                  ),
                  _FooterItem(
                    text: 'How We Make',
                    onTap: () => _navigateToTraditionalVideo(context),
                  ),
                ],
                width: width,
                isMobile: false,
              ),
            ],
          ),
        ),

        // Quick Links
        Expanded(
          flex: 2,
          child: _buildFooterSection(
            title: 'Quick Links',
            items: [
              _FooterItem(
                text: 'Privacy Policy',
                onTap: () => _navigateToPrivacyPolicy(context),
              ),
              _FooterItem(
                text: 'Terms & Conditions',
                onTap: () => _navigateToTerms(context),
              ),
              _FooterItem(
                text: 'Shipping Info',
                onTap: () => _navigateToShipping(context),
              ),
              _FooterItem(
                text: 'Returns & Refunds',
                onTap: () => _navigateToReturns(context),
              ),
            ],
            width: width,
            isMobile: false,
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection(double width, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _FooterColors.darkBrown,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.shopping_bag,
                color: _FooterColors.goldAccent,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'JootaBazar',
              style: TextStyle(
                fontSize: isMobile ? 24 : 28,
                fontWeight: FontWeight.bold,
                color: _FooterColors.charcoalText,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Handmade with Love, Worn with Trust.',
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: _FooterColors.goldAccent,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Your trusted destination for authentic handmade footwear. Crafted with traditional techniques and modern comfort.',
          style: TextStyle(
            fontSize: isMobile ? 13 : 14,
            color: _FooterColors.charcoalText.withOpacity(0.7),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterSection({
    required String title,
    required List<_FooterItem> items,
    required double width,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.bold,
            color: _FooterColors.darkBrown,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FooterLink(item: item, isMobile: isMobile),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    double width,
    bool isMobile,
  ) {
    return isMobile
        ? Column(
            children: [
              // Social Media Icons
              _buildSocialMediaIcons(width, true),
              const SizedBox(height: 20),
              // Copyright
              _buildCopyright(width, true),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCopyright(width, false),
              _buildSocialMediaIcons(width, false),
            ],
          );
  }

  Widget _buildCopyright(double width, bool isMobile) {
    return Text(
      '© ${DateTime.now().year} JootaBazar. All rights reserved.',
      style: TextStyle(
        fontSize: isMobile ? 12 : 13,
        color: _FooterColors.charcoalText.withOpacity(0.6),
      ),
    );
  }

  Widget _buildSocialMediaIcons(double width, bool isMobile) {
    final iconSize = isMobile ? 20.0 : 22.0;
    final spacing = isMobile ? 16.0 : 20.0;

    return Row(
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.end,
      children: [
        _SocialIcon(
          icon: Image.asset(
            '${Contants().assetIconPath}icon_facebook.png',
            width: iconSize,
            height: iconSize,
          ),
          onTap: () => _launchSocialMedia('facebook'),
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        _SocialIcon(
          icon: Image.asset(
            '${Contants().assetIconPath}icon_instagram.png',
            width: iconSize,
            height: iconSize,
          ),
          onTap: () => _launchSocialMedia('instagram'),
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        _SocialIcon(
          icon: Image.asset(
            '${Contants().assetIconPath}icon_youtube.png',
            width: iconSize,
            height: iconSize,
          ),
          onTap: () => _launchSocialMedia('youtube'),
          iconSize: iconSize,
        ),
        SizedBox(width: spacing),
        _SocialIcon(
          icon: Image.asset(
            '${Contants().assetIconPath}icon_whatsapp.png',
            width: iconSize,
            height: iconSize,
          ),
          onTap: () => _launchSocialMedia('whatsapp'),
          iconSize: iconSize,
        ),
      ],
    );
  }

  // Navigation methods
  void _navigateToAboutUs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'About Us',
          content:
              'Learn more about JootaBazar and our commitment to quality handmade footwear.',
        ),
      ),
    );
  }

  void _navigateToWhyChoose(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'Why Choose Us',
          content:
              'Discover why customers choose JootaBazar for authentic, handmade, and comfortable footwear.',
        ),
      ),
    );
  }

  void _navigateToTraditionalVideo(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'Traditional Video',
          content:
              'Watch our traditional craftsmanship process and learn how we make our handmade shoes.',
        ),
      ),
    );
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'Privacy Policy',
          content:
              'Our privacy policy and how we protect your personal information.',
        ),
      ),
    );
  }

  void _navigateToTerms(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'Terms & Conditions',
          content: 'Terms and conditions for using JootaBazar services.',
        ),
      ),
    );
  }

  void _navigateToShipping(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'Shipping Information',
          content:
              'Learn about our shipping policies, delivery times, and shipping costs.',
        ),
      ),
    );
  }

  void _navigateToReturns(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const _PlaceholderScreen(
          title: 'Returns & Refunds',
          content: 'Our return and refund policy for your peace of mind.',
        ),
      ),
    );
  }

  void _launchEmail() async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'support@jootabazar.com',
        query: 'subject=Customer Inquiry',
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      }
    } catch (e) {
      // Handle error silently or show a snackbar
    }
  }

  void _launchPhone() async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: '+911234567890');
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      // Handle error silently or show a snackbar
    }
  }

  void _showAddress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _FooterColors.creamBackground,
        title: Text(
          'Our Address',
          style: TextStyle(color: _FooterColors.darkBrown),
        ),
        content: Text(
          'JootaBazar\n123 Shoe Street\nMumbai, Maharashtra 400001\nIndia',
          style: TextStyle(color: _FooterColors.charcoalText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: _FooterColors.goldAccent),
            ),
          ),
        ],
      ),
    );
  }

  void _launchSocialMedia(String platform) async {
    try {
      // Placeholder URLs - replace with actual social media links
      final Map<String, String> urls = {
        'facebook': 'https://www.facebook.com/jootabazar',
        'instagram': 'https://www.instagram.com/jootabazar',
        'youtube': 'https://www.youtube.com/jootabazar',
        'twitter': 'https://www.twitter.com/jootabazar',
        'whatsapp': 'https://wa.me/911234567890',
      };

      final url = urls[platform] ?? '';
      if (url.isNotEmpty) {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      // Handle error silently or show a snackbar
    }
  }
}

class _FooterItem {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  _FooterItem({required this.text, this.icon, required this.onTap});
}

class _FooterLink extends StatefulWidget {
  final _FooterItem item;
  final bool isMobile;

  const _FooterLink({required this.item, required this.isMobile});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.item.onTap,
        child: Row(
          children: [
            if (widget.item.icon != null) ...[
              Icon(
                widget.item.icon,
                size: widget.isMobile ? 16 : 18,
                color: _isHovered
                    ? _FooterColors.goldAccent
                    : _FooterColors.tan.withOpacity(0.8),
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                widget.item.text,
                style: TextStyle(
                  fontSize: widget.isMobile ? 13 : 14,
                  color: _isHovered
                      ? _FooterColors.goldAccent
                      : _FooterColors.charcoalText.withOpacity(0.8),
                  decoration: _isHovered
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: _FooterColors.goldAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final Image icon;
  final VoidCallback onTap;
  final double iconSize;

  const _SocialIcon({
    required this.icon,
    required this.onTap,
    required this.iconSize,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? _FooterColors.goldAccent.withOpacity(0.3)
                : _FooterColors.tan.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isHovered
                  ? _FooterColors.goldAccent
                  : _FooterColors.darkBrown.withOpacity(0.2),
              width: _isHovered ? 1.5 : 1,
            ),
          ),
          child: widget.icon,
        ),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  final String content;

  const _PlaceholderScreen({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: _FooterColors.darkBrown,
        foregroundColor: _FooterColors.creamBackground,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: _FooterColors.creamBackground,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: _FooterColors.darkBrown,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  content,
                  style: TextStyle(
                    fontSize: 16,
                    color: _FooterColors.charcoalText.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _FooterColors.tan.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _FooterColors.goldAccent.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _FooterColors.darkBrown.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'This page is under development. More content will be added soon.',
                    style: TextStyle(
                      fontSize: 14,
                      color: _FooterColors.charcoalText.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
