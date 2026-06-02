import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/disease_surveillance/model/disease_surveillance_model.dart';

class DiseaseSurveillanceOutbreakTable extends StatelessWidget {
  const DiseaseSurveillanceOutbreakTable({
    required this.outbreaks,
    super.key,
  });

  final List<OutbreakItem> outbreaks;

  Color _getSeverityColor(String sev) {
    switch (sev) {
      case 'crit':
        return AppColors.error;
      case 'high':
        return AppColors.secondaryAccent;
      case 'med':
        return const Color(0xFFFFD166);
      default:
        return AppColors.success;
    }
  }

  Color _getRrtColor(String rrt) {
    switch (rrt) {
      case 'Deployed':
        return AppColors.success;
      case 'Standby':
        return const Color(0xFFFFD166);
      default:
        return AppColors.secondaryAccent;
    }
  }

  Color _getContColor(String cont) {
    switch (cont) {
      case 'Active':
        return AppColors.error;
      case 'Controlled':
        return AppColors.success;
      default:
        return const Color(0xFFFFD166);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x11FFFFFF))),
            ),
            child: const Row(
              children: [
                Text('📋', style: TextStyle(fontSize: 16)),
                SizedBox(width: 8),
                Text(
                  'Active Outbreak Register — Current Status',
                  style: AppTextStyles.labelLarge,
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                Colors.white.withValues(alpha: 0.02),
              ),
              dataRowMinHeight: 44,
              dataRowMaxHeight: 48,
              columnSpacing: 18,
              horizontalMargin: 16,
              columns: const [
                DataColumn(label: Text('Disease', style: _headerStyle)),
                DataColumn(label: Text('District', style: _headerStyle)),
                DataColumn(label: Text('First Reported', style: _headerStyle)),
                DataColumn(label: Text('Cases', style: _headerStyle)),
                DataColumn(label: Text('Deaths', style: _headerStyle)),
                DataColumn(label: Text('CFR %', style: _headerStyle)),
                DataColumn(label: Text('RRT Status', style: _headerStyle)),
                DataColumn(label: Text('Containment', style: _headerStyle)),
                DataColumn(label: Text('Severity', style: _headerStyle)),
                DataColumn(label: Text('Last Update', style: _headerStyle)),
              ],
              rows: outbreaks.map((r) {
                final sevCol = _getSeverityColor(r.severity);
                final rrtCol = _getRrtColor(r.rrtStatus);
                final contCol = _getContColor(r.containmentStatus);

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        r.disease,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(Text(r.district, style: _cellStyle)),
                    DataCell(
                      Text(
                        r.firstReported,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${r.casesCount}',
                        style: const TextStyle(
                          color: AppColors.secondaryAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${r.deathsCount}',
                        style: const TextStyle(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.5,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '${r.cfrPercent.toStringAsFixed(2)}%',
                        style: TextStyle(
                          color: r.cfrPercent > 1.0
                              ? AppColors.error
                              : (r.cfrPercent > 0.0
                                  ? AppColors.secondaryAccent
                                  : AppColors.success),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r.rrtStatus,
                        style: TextStyle(
                          color: rrtCol,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        r.containmentStatus,
                        style: TextStyle(
                          color: contCol,
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: sevCol.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: sevCol.withValues(alpha: 0.3)),
                        ),
                        child: Text(
                          r.severity.toUpperCase(),
                          style: TextStyle(
                            color: sevCol,
                            fontWeight: FontWeight.w800,
                            fontSize: 8.5,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      const Text(
                        'Today',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

const TextStyle _headerStyle = TextStyle(
  color: AppColors.secondaryText,
  fontWeight: FontWeight.bold,
  fontSize: 10,
  letterSpacing: 0.5,
  fontFamily: AppTextStyles.fontFamily,
);

const TextStyle _cellStyle = TextStyle(
  color: Colors.white70,
  fontSize: 11.5,
  fontFamily: AppTextStyles.fontFamily,
);
