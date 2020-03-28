import 'package:flutter/material.dart';

import 'package:blazehub/values/colors.dart';

class Spinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: AppColors.light,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
    );
  }
}
