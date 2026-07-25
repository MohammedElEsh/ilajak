import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ilajak/core/theme/colors/app_colors.dart';
import 'package:ilajak/core/theme/typography/app_typography.dart';

class HistoricalTrendChart extends StatelessWidget {
  const HistoricalTrendChart({super.key});

  @override
  Widget build(BuildContext context) {
    // 0: May, 1: Jun, 2: Jul, 3: Aug, 4: Sep, 5: Oct
    const List<FlSpot> spots = [
      FlSpot(0, 1.3),
      FlSpot(1, 1.1),
      FlSpot(2, 2.0),
      FlSpot(3, 2.2),
      FlSpot(4, 2.8),
      FlSpot(5, 3.5),
    ];

    return Container(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.surfaceDark.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Historical Trend - Last 6 Months
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historical Trend',
                style: AppTypography.semiBold18.copyWith(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              Text(
                'Last 6 Months',
                style: AppTypography.regular16.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Chart
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                // Hide grid and border
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),

                // Disable the touch interaction to prevent showing unwanted Tooltip (or it can be customized)
                lineTouchData: const LineTouchData(enabled: false),

                // Set the titles for the axes (the months below the chart)
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final style = AppTypography.medium12.copyWith(
                          color: AppColors.textSecondary,
                        );
                        switch (value.toInt()) {
                          case 0:
                            return Text('May', style: style);
                          case 1:
                            return Text('Jun', style: style);
                          case 2:
                            return Text('Jul', style: style);
                          case 3:
                            return Text('Aug', style: style);
                          case 4:
                            return Text('Sep', style: style);
                          case 5:
                            return Text(
                              'Oct',
                              style: AppTypography.bold12.copyWith(
                                color: AppColors.primary,
                              ),
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ),

                // Axes Positions
                minX: 0,
                maxX: 5,
                minY: 0.5,
                maxY: 4.0,

                // Line Data
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true, // for smooth curve
                    curveSmoothness: 0.35,
                    color: AppColors.primary, // main blue line color
                    barWidth: 3,
                    isStrokeCapRound: true,

                    // the white circle at each point on the curve
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 3,
                          color: AppColors.primary,
                          strokeWidth: 2,
                          strokeColor: AppColors.surfaceLight,
                        );
                      },
                    ),

                    // Gradient Fill
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.25),
                          AppColors.primary.withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
