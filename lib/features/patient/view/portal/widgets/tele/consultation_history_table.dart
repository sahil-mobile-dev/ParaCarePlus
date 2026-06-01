import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ConsultationHistoryTable extends StatelessWidget {
  const ConsultationHistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header title
          const Row(
            children: [
              Icon(Icons.history_rounded, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text(
                'Consultation History',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Scrollable table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(
                Colors.white.withValues(alpha: 0.04),
              ),
              dataRowMinHeight: 38,
              dataRowMaxHeight: 44,
              horizontalMargin: 12,
              columnSpacing: 20,
              dividerThickness: 1,
              columns: const [
                DataColumn(
                  label: Text(
                    'Doctor',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Specialty',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Date',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Duration',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Rx',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: [
                _buildDataRow(
                  context,
                  doctor: 'Dr. Rajesh Kumar',
                  specialty: 'Cardiology',
                  date: '13 May 2026',
                  duration: '22 min',
                  type: 'Video',
                  status: 'Active',
                  statusColor: const Color(0xFF00B4D8), // Accent blue
                  hasRx: true,
                ),
                _buildDataRow(
                  context,
                  doctor: 'Dr. Meena Verma',
                  specialty: 'Endocrinology',
                  date: '01 May 2026',
                  duration: '18 min',
                  type: 'Video',
                  status: 'Completed',
                  statusColor: AppColors.success,
                  hasRx: true,
                ),
                _buildDataRow(
                  context,
                  doctor: 'Dr. Kavita Mehta',
                  specialty: 'Radiology',
                  date: '28 Apr 2026',
                  duration: '12 min',
                  type: 'Audio',
                  status: 'Completed',
                  statusColor: AppColors.success,
                  hasRx: false,
                ),
                _buildDataRow(
                  context,
                  doctor: 'Dr. Anand Patel',
                  specialty: 'General Medicine',
                  date: '15 Apr 2026',
                  duration: '25 min',
                  type: 'Video',
                  status: 'Completed',
                  statusColor: AppColors.success,
                  hasRx: true,
                ),
                _buildDataRow(
                  context,
                  doctor: 'Dr. Suresh Gupta',
                  specialty: 'Orthopedics',
                  date: '02 Apr 2026',
                  duration: '15 min',
                  type: 'Video',
                  status: 'Completed',
                  statusColor: AppColors.success,
                  hasRx: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildDataRow(
    BuildContext context, {
    required String doctor,
    required String specialty,
    required String date,
    required String duration,
    required String type,
    required String status,
    required Color statusColor,
    required bool hasRx,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            doctor,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            specialty,
            style: const TextStyle(color: AppColors.primaryText, fontSize: 11),
          ),
        ),
        DataCell(
          Text(
            date,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 11,
            ),
          ),
        ),
        DataCell(
          Text(
            duration,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 11,
            ),
          ),
        ),
        DataCell(
          Text(
            type,
            style: const TextStyle(color: AppColors.primaryText, fontSize: 11),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          hasRx
              ? GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening prescription…'),
                        backgroundColor: AppColors.primaryLight,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.description_rounded,
                      color: Color(0xFF00B4D8),
                      size: 11,
                    ),
                  ),
                )
              : const Text(
                  '—',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
        ),
      ],
    );
  }
}
