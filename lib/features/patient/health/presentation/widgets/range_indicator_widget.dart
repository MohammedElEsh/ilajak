import 'package:flutter/material.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class RangeIndicatorBar extends StatelessWidget {
  final double value; // القيمة الحالية (مثلاً 245)
  final double min; // أدنى قيمة (مثلاً 125)
  final double max; // أقصى قيمة (مثلاً 300)

  const RangeIndicatorBar({
    super.key,
    required this.value,
    this.min = 125,
    this.max = 300,
  });

  @override
  Widget build(BuildContext context) {
    // حساب النسبة المئوية لموقع المؤشر بين (0.0 و 1.0)
    final double clampedValue = value.clamp(min, max);
    final double percentage = (clampedValue - min) / (max - min);

    return Column(
      children: [
        // الـ Stack الرئيسي يحتوي على الشريط والخاط/المؤشر
        LayoutBuilder(
          builder: (context, constraints) {
            final double totalWidth = constraints.maxWidth;
            const double indicatorWidth = 3.0; // سمك خط المؤشر
            const double barHeight = 8.0; // ارتفاع الشريط الملون

            // حساب الإزاحة من اليسار بالبكسل
            final double leftPosition =
                (percentage * totalWidth) - (indicatorWidth / 2);

            return Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                // 1. الشريط الخلفي المكون من 3 ألوان مع حواف دائرية
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    height: barHeight,
                    child: Row(
                      children: [
                        // الجزء الأول: أزرق فاتح جداً
                        Expanded(
                          flex: 30,
                          child: Container(
                            color: AppColors.primary.withValues(alpha: 0.2),
                          ),
                        ),
                        // الجزء الثاني: أزرق ناعم (المنطقة الطبيعية)
                        Expanded(
                          flex: 40,
                          child: Container(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                        // الجزء الثالث: أحمر فاتح (منطقة الخطر)
                        Expanded(
                          flex: 30,
                          child: Container(
                            color: AppColors.redTileIconBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. المؤشر العمودي Red Line Indicator
                Positioned(
                  bottom: 0,
                  left: leftPosition.clamp(0.0, totalWidth - indicatorWidth),
                  child: Container(
                    width: indicatorWidth,
                    height: 18, // أطول من الشريط الملون ليبرز لأعلى ولأسفل
                    decoration: BoxDecoration(
                      color: AppColors.error, // لون المؤشر الأحمر
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 6),

        // النصوص الموجودة أسفل الشريط (125 - Normal Range - 300)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${min.toInt()}',
              style: AppTypography.medium12.copyWith(
                color: AppColors.textPrimaryLight,
              ),
            ),
            Text(
              'Normal Range',
              style: AppTypography.bold12.copyWith(color: AppColors.primary),
            ),
            Text(
              '${max.toInt()}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
