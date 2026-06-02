import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';

class IpdAmbulanceTable extends ConsumerWidget {
  const IpdAmbulanceTable({super.key});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return AppColors.success;
      case 'dispatch':
        return AppColors.secondaryAccent;
      case 'returning':
        return AppColors.primaryLight;
      case 'maintenance':
        return AppColors.secondaryText;
      case 'critical':
      default:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipdBedsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final content = [
          // Fleet Status Table
          Expanded(
            flex: isWide ? 3 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.airport_shuttle_rounded, color: AppColors.secondaryAccent, size: 16),
                      SizedBox(width: 8),
                      Text(
                        '108 AMBULANCE FLEET STATUS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppColors.secondaryText,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowHeight: 34,
                      dataRowMinHeight: 32,
                      dataRowMaxHeight: 38,
                      horizontalMargin: 8,
                      columnSpacing: 16,
                      columns: const [
                        DataColumn(label: Text('Vehicle No', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Driver', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Status', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Patient', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Location', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('ETA', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                      ],
                      rows: state.ambulances.map((amb) {
                        final color = _getStatusColor(amb.status);
                        return DataRow(
                          cells: [
                            DataCell(Text(amb.vehicleNo, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
                            DataCell(Text(amb.driver, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: color.withValues(alpha: 0.3)),
                                ),
                                child: Text(
                                  amb.status.toUpperCase(),
                                  style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            DataCell(Text(amb.patientName, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                            DataCell(Text(amb.location, style: const TextStyle(color: Colors.white54, fontSize: 11))),
                            DataCell(Text(amb.etaMinutes > 0 ? '${amb.etaMinutes} min' : '—', style: TextStyle(color: amb.etaMinutes > 0 ? AppColors.secondaryAccent : Colors.white70, fontSize: 11, fontWeight: FontWeight.bold))),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // Pending Transfers Table
          Expanded(
            flex: isWide ? 2 : 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.swap_horiz_rounded, color: Colors.purple, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'PENDING TRANSFER REQUESTS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: AppColors.secondaryText,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowHeight: 34,
                      dataRowMinHeight: 32,
                      dataRowMaxHeight: 38,
                      horizontalMargin: 8,
                      columnSpacing: 14,
                      columns: const [
                        DataColumn(label: Text('Accession', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Patient', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('From → To', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Priority', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                        DataColumn(label: Text('Status', style: TextStyle(color: AppColors.secondaryText, fontSize: 10, fontWeight: FontWeight.bold))),
                      ],
                      rows: state.transfers.map((xfer) {
                        final isStat = xfer.priority.toUpperCase() == 'STAT';
                        final prioColor = isStat ? AppColors.error : AppColors.secondaryAccent;

                        return DataRow(
                          cells: [
                            DataCell(Text(xfer.accession, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))),
                            DataCell(Text(xfer.patient, style: const TextStyle(color: Colors.white70, fontSize: 11))),
                            DataCell(Text('${xfer.fromWard} → ${xfer.toWard}', style: const TextStyle(color: Colors.white54, fontSize: 11))),
                            DataCell(
                              Text(
                                xfer.priority,
                                style: TextStyle(
                                  color: prioColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                xfer.status,
                                style: TextStyle(
                                  color: xfer.status.contains('Approved') ? AppColors.success : AppColors.secondaryText,
                                  fontSize: 10,
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
            ),
          ),
        ];

        return isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: content,
              );
      },
    );
  }
}
