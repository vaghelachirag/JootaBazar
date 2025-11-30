import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle h1 = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle h2 = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle h3 = GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Body
  static TextStyle body = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
  );

  static TextStyle bodyBold = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  // Small text
  static TextStyle small = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  // Price styling
  static TextStyle price = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle priceStrike = GoogleFonts.poppins(
    fontSize: 13,
    decoration: TextDecoration.lineThrough,
    color: AppColors.grey,
  );
}
