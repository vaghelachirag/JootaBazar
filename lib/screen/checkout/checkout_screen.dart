import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/cart_item_model.dart';
import '../cart/provider/cart_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _apartmentController = TextEditingController();
  final _cityController = TextEditingController();
  final _pinCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _discountCodeController = TextEditingController();

  String _selectedCountry = 'India';
  String _selectedState = 'Gujarat';
  String? _selectedPaymentMethod;
  String? _selectedShippingMethod;
  bool _saveInfo = false;
  bool _emailNews = false;
  bool _discountApplied = false;

  List<String> get _countries => ['India', 'USA', 'UK', 'Canada'];

  List<String> get _states => [
    'Gujarat',
    'Maharashtra',
    'Delhi',
    'Karnataka',
    'Tamil Nadu',
  ];

  double get _sectionSpacing => 20.h;
  double get _fieldSpacing => 16.h;

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _apartmentController.dispose();
    _cityController.dispose();
    _pinCodeController.dispose();
    _phoneController.dispose();
    _discountCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartTotalProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [SizedBox(width: 12.w)],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart(context)
          : Form(
              key: _formKey,
              child: isDesktop
                  ? _buildDesktopLayout(cartItems, totalPrice)
                  : _buildMobileLayout(cartItems, totalPrice),
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80.sp, color: Colors.grey),
          SizedBox(height: 16.h),
          Text(
            'Your cart is empty',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Continue Shopping',
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(List<CartItem> cartItems, double totalPrice) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _buildLeftColumn(cartItems, totalPrice)),
          SizedBox(width: 24.w),
          Expanded(flex: 1, child: _buildRightColumn(cartItems, totalPrice)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(List<CartItem> cartItems, double totalPrice) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRightColumn(cartItems, totalPrice),
          SizedBox(height: _sectionSpacing),
          _buildLeftColumn(cartItems, totalPrice),
        ],
      ),
    );
  }

  Widget _buildLeftColumn(List<CartItem> cartItems, double totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSection(
          title: 'Contact',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Checkbox(
                    value: _emailNews,
                    onChanged: (value) =>
                        setState(() => _emailNews = value ?? false),
                    activeColor: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      'Email me with news and offers',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: _sectionSpacing),
        _buildSection(
          title: 'Delivery',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCountry,
                icon: Icon(Icons.keyboard_arrow_down_rounded, size: 18.sp),
                style: _fieldTextStyle,
                decoration: _inputDecoration('Country/Region'),
                items: _countries
                    .map(
                      (country) => DropdownMenuItem(
                        value: country,
                        child: Text(country, style: _fieldTextStyle),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedCountry = value ?? 'India'),
              ),
              SizedBox(height: _fieldSpacing),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _firstNameController,
                      label: 'First name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildTextField(
                      controller: _lastNameController,
                      label: 'Last name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: _fieldSpacing),
              _buildTextField(
                controller: _addressController,
                label: 'Address',
                hint: 'House number and street name',
                validator: (value) => value == null || value.isEmpty
                    ? 'Please enter your address'
                    : null,
              ),
              SizedBox(height: _fieldSpacing),
              _buildTextField(
                controller: _apartmentController,
                label: 'Apartment, suite, etc.',
                hint: 'Optional',
                optional: true,
              ),
              SizedBox(height: _fieldSpacing),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _cityController,
                      label: 'City',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedState,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 18.sp,
                      ),
                      style: _fieldTextStyle,
                      decoration: _inputDecoration('State'),
                      items: _states
                          .map(
                            (state) => DropdownMenuItem(
                              value: state,
                              child: Text(state, style: _fieldTextStyle),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => _selectedState = value ?? 'Gujarat'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildTextField(
                      controller: _pinCodeController,
                      label: 'PIN code',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Required';
                        if (value.length != 6) return 'Invalid PIN';
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: _fieldSpacing),
              _buildTextField(
                controller: _phoneController,
                label: 'Phone',
                keyboardType: TextInputType.phone,
                hint: 'For delivery updates',
                suffix: Icon(
                  Icons.help_outline,
                  size: 18.sp,
                  color: Colors.grey[600],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter your phone number';
                  if (value.length < 10) return 'Invalid phone number';
                  return null;
                },
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Checkbox(
                    value: _saveInfo,
                    onChanged: (value) =>
                        setState(() => _saveInfo = value ?? false),
                    activeColor: Colors.black,
                  ),
                  Expanded(
                    child: Text(
                      'Save this information for next time',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: _sectionSpacing),
        _buildSection(
          title: 'Shipping method',
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              _selectedShippingMethod == null
                  ? 'Enter your shipping address to view available shipping methods.'
                  : 'Selected: $_selectedShippingMethod',
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        SizedBox(height: _sectionSpacing),
        _buildSection(
          title: 'Payment',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All transactions are secure and encrypted.',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.h),
              _buildPaymentOption(
                title: 'Paytm Payment Gateway',
                value: 'paytm',
                isSelected: _selectedPaymentMethod == 'paytm',
                onChanged: (value) =>
                    setState(() => _selectedPaymentMethod = value),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        _buildPaymentIcon('VISA'),
                        _buildPaymentIcon('MC'),
                        _buildPaymentIcon('AMEX'),
                        _buildPaymentIcon('+4'),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Icon(
                          Icons.launch,
                          size: 16.sp,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'After clicking "Pay now", you will be redirected to Paytm to complete your purchase securely.',
                            style: GoogleFonts.poppins(
                              fontSize: 11.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              _buildPaymentOption(
                title: 'Cash on Delivery (COD)',
                value: 'cod',
                isSelected: _selectedPaymentMethod == 'cod',
                onChanged: (value) =>
                    setState(() => _selectedPaymentMethod = value),
              ),
            ],
          ),
        ),
        SizedBox(height: _sectionSpacing),
        _buildSection(
          title: 'Billing address',
          child: Row(
            children: [
              Checkbox(
                value: _saveInfo,
                onChanged: (value) =>
                    setState(() => _saveInfo = value ?? false),
                activeColor: Colors.black,
              ),
              Text(
                'Same as delivery address',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate() &&
                  _selectedPaymentMethod != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Processing payment...'),
                    backgroundColor: Colors.black87,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              } else if (_selectedPaymentMethod == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please select a payment method'),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 2,
            ),
            child: Text(
              'Pay now',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(List<CartItem> cartItems, double totalPrice) {
    final platformFee = 0.0;
    final discount = _discountApplied ? totalPrice * 0.1 : 0.0;
    final finalTotal = totalPrice + platformFee - discount;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          ...cartItems.map((item) => _buildOrderItem(item)),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _discountCodeController,
                  label: 'Discount code',
                  hint: 'Enter code',
                  optional: true,
                  validator: (_) => null,
                ),
              ),
              SizedBox(width: 12.w),
              ElevatedButton(
                onPressed: () {
                  if (_discountCodeController.text.isNotEmpty) {
                    setState(() => _discountApplied = true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Discount code applied!'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildPriceRow('Subtotal', totalPrice),
          SizedBox(height: 8.h),
          _buildPriceRow(
            'Platform Fee',
            platformFee,
            subtitle: _selectedShippingMethod == null
                ? 'Enter shipping address'
                : 'Based on method',
          ),
          if (_discountApplied) ...[
            SizedBox(height: 8.h),
            _buildPriceRow('Discount', -discount, isDiscount: true),
          ],
          SizedBox(height: 12.h),
          Divider(color: Colors.grey[300]),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'INR ₹${finalTotal.toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'All prices are inclusive of taxes',
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),
        child,
      ],
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String value,
    required bool isSelected,
    required Function(String?) onChanged,
    Widget? child,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey[300]!,
          width: isSelected ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: _selectedPaymentMethod,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (child != null) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 40.w),
              child: child,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentIcon(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildOrderItem(CartItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: 70.w,
              height: 70.w,
              color: Colors.grey[100],
              child: CachedNetworkImage(
                imageUrl: item.product.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) =>
                    Icon(Icons.image_not_supported, size: 20.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${item.product.category} / Size ${item.size}',
                  style: GoogleFonts.poppins(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '₹${item.totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    double amount, {
    String? subtitle,
    bool isDiscount = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 11.sp,
                  color: Colors.grey[500],
                ),
              ),
          ],
        ),
        Text(
          amount == 0 && subtitle != null
              ? ''
              : '${isDiscount ? '-' : ''}₹${amount.toStringAsFixed(2)}',
          style: GoogleFonts.poppins(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }

  TextStyle get _fieldTextStyle => GoogleFonts.poppins(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  InputDecoration _inputDecoration(
    String label, {
    String? hintText,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.grey[600]),
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.grey[400]),
      errorStyle: GoogleFonts.poppins(fontSize: 11.sp, color: Colors.redAccent),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: Colors.black, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Widget? suffix,
    bool optional = false,
  }) {
    final displayLabel = optional ? '$label (optional)' : label;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: _fieldTextStyle,
      decoration: _inputDecoration(
        displayLabel,
        hintText: hint,
        suffix: suffix,
      ),
      validator: validator,
    );
  }
}
