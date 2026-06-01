import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class FamilyVaccinationHeatmap extends StatelessWidget {
  const FamilyVaccinationHeatmap({super.key});

  static const List<String> _members = [
    'Ramesh (Self)',
    'Geeta (Spouse)',
    'Aryan (Son 22)',
    'Priya (Daughter 18)',
    'Mother (74)',
  ];

  static const List<String> _vaccines = [
    'COVID-19',
    'Hep B',
    'Flu',
    'Tdap',
    'Typhoid',
    'Pneumo',
  ];

  // 0=Not Done (Red, ✗), 1=Partial (Yellow, ~), 2=Complete (Green, ✓), 3=N/A (Muted, —)
  static const List<List<int>> _famData = [
    [2, 2, 2, 0, 1, 2], // Ramesh
    [2, 2, 2, 2, 2, 2], // Geeta
    [2, 2, 1, 2, 2, 1], // Aryan
    [2, 2, 1, 2, 1, 1], // Priya
    [2, 1, 2, 1, 2, 2], // Mother
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Icon(
                Icons.local_fire_department_rounded,
                color: AppColors.error,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Family Vaccination Heatmap',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Scrollable layout in case width is too narrow on mobile
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rows representing members and cells
                ...List.generate(_members.length, (memberIndex) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        // Y-Axis label
                        SizedBox(
                          width: 130,
                          child: Text(
                            _members[memberIndex],
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        // Heatmap cells
                        ...List.generate(_vaccines.length, (vaxIndex) {
                          final statusVal = _famData[memberIndex][vaxIndex];
                          return _buildHeatmapCell(context, statusVal);
                        }),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 10),
                // X-Axis labels at bottom
                Row(
                  children: [
                    const SizedBox(width: 130), // Align with Y axis
                    ..._vaccines.map((vaxName) {
                      return SizedBox(
                        width: 58,
                        child: Text(
                          vaxName,
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
              _buildLegendItem(color: AppColors.success, text: '✓ Complete'),
              const SizedBox(width: 16),
              _buildLegendItem(
                color: AppColors.secondaryAccent,
                text: '~ Partial',
              ),
              const SizedBox(width: 16),
              _buildLegendItem(color: AppColors.error, text: '✗ Not Done'),
              const SizedBox(width: 16),
              _buildLegendItem(color: const Color(0xFF4A6A8A), text: '— N/A'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeatmapCell(BuildContext context, int statusVal) {
    Color cellColor;
    String symbol;
    String statusString;

    switch (statusVal) {
      case 2:
        cellColor = AppColors.success;
        symbol = '✓';
        statusString = 'Complete';
      case 1:
        cellColor = AppColors.secondaryAccent;
        symbol = '~';
        statusString = 'Partial';
      case 0:
        cellColor = AppColors.error;
        symbol = '✗';
        statusString = 'Not Done';
      default:
        cellColor = const Color(0xFF4A6A8A);
        symbol = '—';
        statusString = 'N/A';
    }

    return Tooltip(
      message: statusString,
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
          symbol,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
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
}
