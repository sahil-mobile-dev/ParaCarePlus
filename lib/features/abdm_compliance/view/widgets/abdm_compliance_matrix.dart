import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/abdm_compliance/model/abdm_compliance_model.dart';
import 'package:paracareplus/features/abdm_compliance/view_model/abdm_compliance_view_model.dart';

class AbdmComplianceMatrix extends ConsumerWidget {
  const AbdmComplianceMatrix({super.key});

  Color _getStatusColor(String status) {
    if (status == 'Full') return AppColors.success;
    if (status == 'Partial') return AppColors.secondaryAccent;
    if (status == 'Degraded') return AppColors.error;
    return AppColors.error;
  }

  IconData _getTrendIcon(String trend) {
    if (trend == 'up') return Icons.trending_up_rounded;
    if (trend == 'down') return Icons.trending_down_rounded;
    return Icons.trending_flat_rounded;
  }

  Color _getTrendColor(String trend) {
    if (trend == 'up') return AppColors.success;
    if (trend == 'down') return AppColors.error;
    return AppColors.secondaryText;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(abdmComplianceProvider);
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 760;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ABDM Module Compliance Matrix',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.5,
              fontWeight: FontWeight.bold,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 16),
          if (isCompact)
            ...state.complianceMatrix.map((row) => _buildCompactCard(row))
          else
            _buildTable(state.complianceMatrix),
        ],
      ),
    );
  }

  Widget _buildCompactCard(ComplianceMatrixRow row) {
    final statusColor = _getStatusColor(row.status);
    final trendColor = _getTrendColor(row.trend);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF132640),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                row.module,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  row.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${row.facilitiesCount} Facilities Linked',
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Score ${row.score}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Icon(_getTrendIcon(row.trend), color: trendColor, size: 12),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: row.compliancePercent / 100,
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                    minHeight: 4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${row.compliancePercent.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTable(List<ComplianceMatrixRow> rows) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2.5),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(2.0),
        3: FlexColumnWidth(0.8),
        4: FlexColumnWidth(0.8),
        5: FlexColumnWidth(1.2),
        6: FlexColumnWidth(1.2),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        // Header
        TableRow(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          children: [
            _buildHeaderCell('ABDM Module'),
            _buildHeaderCell('Facilities'),
            _buildHeaderCell('Compliance %'),
            _buildHeaderCell('Score'),
            _buildHeaderCell('Trend'),
            _buildHeaderCell('Status'),
            _buildHeaderCell('Last Audit'),
          ],
        ),
        // Rows
        ...rows.map((row) {
          final statusColor = _getStatusColor(row.status);
          final trendColor = _getTrendColor(row.trend);

          return TableRow(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0x1FFFFFFF), width: 1),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  row.module,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 10.5,
                  ),
                ),
              ),
              Text(
                '${row.facilitiesCount}',
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10.5,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        value: row.compliancePercent / 100,
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                        valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                        minHeight: 4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${row.compliancePercent.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(
                row.score,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(_getTrendIcon(row.trend), color: trendColor, size: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  row.status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Text(
                row.lastAudit,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 9.5,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 9,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
