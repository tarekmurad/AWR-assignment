import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../styles/app_colors.dart';

class Helper {
  /// Validation
  static bool validateEmail(String email) {
    if (email.isEmpty) {
      return false;
    } else if (!EmailValidator.validate(email)) {
      return false;
    }
    return true;
  }

  static Future<BitmapDescriptor> getMarkerFromAsset(
      String assetPath, double width, double height) async {
    return await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(width, height)),
      assetPath,
    );
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case 'awaiting_pickup':
        return AppColors.blueColor;
      case 'in_transit':
        return AppColors.orangeColor;
      case 'delivered':
        return AppColors.greenColor;
      default:
        return Colors.grey;
    }
  }
}
