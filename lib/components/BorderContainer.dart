import 'package:flutter/material.dart';

import 'package:blazehub/values/colors.dart';

class BorderContainer extends StatelessWidget {
  final Widget child;

  const BorderContainer({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
