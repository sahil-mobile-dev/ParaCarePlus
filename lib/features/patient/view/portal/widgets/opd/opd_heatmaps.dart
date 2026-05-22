import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class OpdHeatmaps extends StatelessWidget {
  const OpdHeatmaps({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    final depts = [
      'Medicine',
      'Cardio',
      'Endocrine',
      'Ortho',
      'Eye',
      'Dental',
      'Neuro',
      'Paeds',
    ];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final hours = ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00'];

    // Mock load values: 0=Low(Green), 1=Moderate(Yellow), 2=High(Red)
    final loadMatrix = <List<int>>[
      [0, 1, 0, 2, 1, 0, 0],
      [1, 2, 2, 1, 0, 0, 1],
      [0, 1, 1, 0, 2, 1, 0],
      [1, 0, 0, 1, 1, 2, 0],
      [0, 0, 2, 0, 0, 1, 0],
      [1, 1, 1, 2, 0, 0, 0],
      [0, 2, 0, 1, 1, 0, 1],
      [2, 1, 1, 0, 0, 2, 0],
    ];

    final waitTimeMatrix = <List<int>>[
      [1, 2, 1, 0, 1, 2],
      [0, 1, 2, 1, 0, 1],
      [2, 2, 1, 0, 1, 2],
      [1, 0, 0, 2, 1, 0],
      [0, 1, 1, 0, 2, 1],
      [1, 2, 2, 1, 0, 0],
      [0, 1, 1, 2, 1, 0],
    ];

    Color getCellColor(int val) {
      if (val == 2) return AppColors.error.withValues(alpha: 0.8);
      if (val == 1) return AppColors.secondaryAccent.withValues(alpha: 0.8);
      return AppColors.success.withValues(alpha: 0.8);
    }

    Widget buildDepartmentHeatmap() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  color: AppColors.secondaryAccent,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'OPD Load by Department × Day of Week',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Header: Days of the week
            Row(
              children: [
                const SizedBox(width: 75), // Spacer for y-labels
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: days.map((day) {
                      return SizedBox(
                        width: 26,
                        child: Text(
                          day,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Grid Rows
            Column(
              children: List.generate(depts.length, (rowIndex) {
                final dept = depts[rowIndex];
                final rowValues = loadMatrix[rowIndex];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 75,
                        child: Text(
                          dept,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (colIndex) {
                            final val = rowValues[colIndex];
                            return Tooltip(
                              message:
                                  '${depts[rowIndex]} · ${days[colIndex]}: ${val == 2
                                      ? "High"
                                      : val == 1
                                      ? "Moderate"
                                      : "Low"} load',
                              child: Container(
                                width: 26,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: getCellColor(val),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    }

    Widget buildWaitTimeHeatmap() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.card,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: AppColors.secondaryAccent,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Wait Time Heatmap — Hour × Day',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Header: Hours of the day
            Row(
              children: [
                const SizedBox(width: 45), // Spacer for y-labels
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: hours.map((hr) {
                      return SizedBox(
                        width: 32,
                        child: Text(
                          hr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            // Grid Rows
            Column(
              children: List.generate(days.length, (rowIndex) {
                final day = days[rowIndex];
                final rowValues = waitTimeMatrix[rowIndex];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 45,
                        child: Text(
                          day,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (colIndex) {
                            final val = rowValues[colIndex];
                            return Tooltip(
                              message:
                                  '${days[rowIndex]} · ${hours[colIndex]}: ${val == 2
                                      ? ">45 min delay"
                                      : val == 1
                                      ? "~25 min wait"
                                      : "<10 min wait"}',
                              child: Container(
                                width: 32,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: getCellColor(val),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      );
    }

    return isWide
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildDepartmentHeatmap()),
              const SizedBox(width: 16),
              Expanded(child: buildWaitTimeHeatmap()),
            ],
          )
        : Column(
            children: [
              buildDepartmentHeatmap(),
              const SizedBox(height: 16),
              buildWaitTimeHeatmap(),
            ],
          );
  }
}
