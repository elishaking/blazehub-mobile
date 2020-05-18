import 'package:flutter/material.dart';

import 'package:blazehub/values/colors.dart';

class Spinner extends StatelessWidget {
  final double width;
  final double opacity;

  const Spinner({this.width, this.opacity = 1});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: width,
      backgroundColor: AppColors.light,
      valueColor:
          AlwaysStoppedAnimation<Color>(AppColors.primary.withOpacity(opacity)),
    );
  }
}
