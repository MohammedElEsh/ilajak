import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLoading extends StatelessWidget {
  final double size;
  final Color? color;
  final double strokeWidth;

  const AppLoading({
    super.key,
    this.size = 24.0,
    this.color,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: SizedBox(
        width: size.r,
        height: size.r,
        child: CircularProgressIndicator(
          color: color ?? theme.colorScheme.primary,
          strokeWidth: strokeWidth.r,
        ),
      ),
    );
  }
}
