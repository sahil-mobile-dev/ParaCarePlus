import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class NutritionTab extends StatelessWidget {
  const NutritionTab({super.key});

  static const List<String> _members = ['Ramesh', 'Geeta', 'Aryan', 'Priya'];

  static const List<String> _nutrients = [
    'Calories',
    'Protein',
    'Iron',
    'Calcium',
    'Vit D',
    'Folate',
  ];

  // 0=Adequate (Green, OK), 1=Borderline (Yellow, Low), 2=Deficient (Red, DEF)
  static const List<List<int>> _nutData = [
    [1, 1, 0, 0, 2, 0], // Ramesh
    [0, 1, 2, 2, 1, 1], // Geeta
    [0, 0, 0, 0, 0, 0], // Aryan
    [0, 1, 1, 0, 0, 1], // Priya
  ];

  static const List<Map<String, String>> _nutritionTable = [
    {
      'member': 'Ramesh (Father)',
      'hb': '13.8',
      'iron': 'Normal',
      'calcium': 'Normal',
      'vitd': 'Deficient',
      'bmi': 'Overweight',
    },
    {
      'member': 'Geeta (Mother)',
      'hb': '11.6',
      'iron': 'Mild Anemia',
      'calcium': 'Low',
      'vitd': 'Insufficient',
      'bmi': 'Normal',
    },
    {
      'member': 'Aryan (Son 22)',
      'hb': '15.2',
      'iron': 'Normal',
      'calcium': 'Normal',
      'vitd': 'Normal',
      'bmi': 'Normal',
    },
    {
      'member': 'Priya (Daughter 18)',
      'hb': '12.4',
      'iron': 'Borderline',
      'calcium': 'Normal',
      'vitd': 'Normal',
      'bmi': 'Normal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Nutrition Heatmap card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.map_rounded, color: AppColors.success, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Family Nutritional Risk Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Grid Rows
                    ...List.generate(_members.length, (memberIndex) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                _members[memberIndex],
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            ...List.generate(_nutrients.length, (nutIndex) {
                              final statusVal = _nutData[memberIndex][nutIndex];
                              return _buildHeatmapCell(context, statusVal);
                            }),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 10),
                    // Bottom X labels
                    Row(
                      children: [
                        const SizedBox(width: 80),
                        ..._nutrients.map((nutName) {
                          return SizedBox(
                            width: 58,
                            child: Text(
                              nutName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(
                    color: AppColors.success,
                    text: 'Adequate (OK)',
                  ),
                  const SizedBox(width: 20),
                  _buildLegendItem(
                    color: AppColors.secondaryAccent,
                    text: 'Borderline (Low)',
                  ),
                  const SizedBox(width: 20),
                  _buildLegendItem(
                    color: AppColors.error,
                    text: 'Deficient (DEF)',
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Nutrition Table card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.apple_rounded, color: AppColors.success, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Family Nutritional Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Scrollbar(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: AppColors.border.withValues(alpha: 0.3),
                    ),
                    child: DataTable(
                      horizontalMargin: 8,
                      columnSpacing: 18,
                      headingRowColor: WidgetStateProperty.all(
                        Colors.white.withValues(alpha: 0.04),
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Member',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Hb (g/dL)',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Iron Status',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Calcium',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Vitamin D',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'BMI Category',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      rows: _nutritionTable.map((row) {
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                row['member']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                row['hb']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            DataCell(_buildStatusBadge(row['iron']!)),
                            DataCell(_buildStatusBadge(row['calcium']!)),
                            DataCell(_buildStatusBadge(row['vitd']!)),
                            DataCell(
                              Text(
                                row['bmi']!,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeatmapCell(BuildContext context, int statusVal) {
    Color cellColor;
    String text;
    String tooltipText;

    switch (statusVal) {
      case 0:
        cellColor = AppColors.success;
        text = 'OK';
        tooltipText = 'Adequate';
      case 1:
        cellColor = AppColors.secondaryAccent;
        text = 'Low';
        tooltipText = 'Borderline';
      default:
        cellColor = AppColors.error;
        text = 'DEF';
        tooltipText = 'Deficient';
    }

    return Tooltip(
      message: tooltipText,
      child: Container(
        width: 50,
        height: 38,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: cellColor.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String text) {
    Color bgColor;
    Color textColor;

    switch (text) {
      case 'Normal':
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
      case 'Low':
      case 'Insufficient':
      case 'Borderline':
      case 'Mild Anemia':
        bgColor = AppColors.secondaryAccent.withValues(alpha: 0.15);
        textColor = AppColors.secondaryAccent;
      default:
        bgColor = AppColors.error.withValues(alpha: 0.15);
        textColor = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
