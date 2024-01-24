import 'package:flutter/material.dart';
import 'package:weather_app/common/colors.dart';

class AppStyles {
  static const TextStyle whiteText = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle boldWhiteText = TextStyle(
    color: AppColors.white,
    fontSize: 25,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle temperatureText = TextStyle(
    color: AppColors.white,
    fontSize: 55,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle weatherMainText = TextStyle(
    color: AppColors.white,
    fontSize: 25,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle smallWhiteText = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle infoRowText = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle infoRowValueText = TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );
}
