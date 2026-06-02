import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DiseaseSurveillanceHeatmapPanel extends StatelessWidget {
  const DiseaseSurveillanceHeatmapPanel({
    required this.title,
    required this.subtitle,
    required this.columns,
    required this.rows,
    required this.cells, // Matrix of rows x columns double values [0.0 - 1.0]
    required this.colorRange, // List of colors representing low to high intensity
    super.key,
  });

  final String title;
  final String subtitle;
  final List<String> columns;
  final List<String> rows;
  final List<List<double>> cells;
  final List<Color> colorRange;

  Color _getColorForValue(double val) {
    if (colorRange.isEmpty) return Colors.blue;
    if (colorRange.length == 1) return colorRange[0];

    // Simple multi-stop gradient color mapper
    final segmentValue = 1.0 / (colorRange.length - 1);
    final idx = (val / segmentValue).floor().clamp(0, colorRange.length - 2);
    final ratio = (val - (idx * segmentValue)) / segmentValue;

    return Color.lerp(
          colorRange[idx],
          colorRange[idx + 1],
          ratio.clamp(0.0, 1.0),
        ) ??
        colorRange[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _buildLegendBox('Low', colorRange.first),
                  const SizedBox(width: 8),
                  _buildLegendBox('High', colorRange.last),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Scrollable layout for grids
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Column Header Row
                Row(
                  children: [
                    const SizedBox(width: 90), // Offset for row titles
                    ...columns.map(
                      (col) => Container(
                        width: 76,
                        alignment: Alignment.center,
                        child: Text(
                          col,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryText,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Matrix rows
                ...List.generate(rows.length, (rowIndex) {
                  final rowTitle = rows[rowIndex];
                  final rowCells = cells[rowIndex];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    child: Row(
                      children: [
                        // Row Title
                        SizedBox(
                          width: 90,
                          child: Text(
                            rowTitle,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Cells
                        ...List.generate(columns.length, (colIndex) {
                          final val = rowCells[colIndex];
                          final cellColor = _getColorForValue(val);

                          return Container(
                            width: 70,
                            height: 24,
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                              color: cellColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black.withValues(alpha: 0.25),
                                width: 0.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '${(val * 100).round()}',
                              style: TextStyle(
                                fontSize: 8.5,
                                fontWeight: FontWeight.w900,
                                color: val > 0.65
                                    ? Colors.white
                                    : Colors.white70,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendBox(String label, Color col) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: col,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9.5,
            color: AppColors.secondaryText,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }
}
