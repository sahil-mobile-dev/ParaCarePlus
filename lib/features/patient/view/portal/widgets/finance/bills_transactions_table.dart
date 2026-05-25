import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class BillsTransactionsTable extends StatelessWidget {
  const BillsTransactionsTable({super.key});

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
          // Title row
          const Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                color: Color(0xFF00C897),
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Recent Bills & Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Table
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
              columnSpacing: 22,
              dividerThickness: 1,
              columns: const [
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
                    'Hospital',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Service',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Total Bill',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Insurance Paid',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Out-of-Pocket',
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
                    'Action',
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
                  date: '10 May 2026',
                  hospital: 'AIIMS Rishikesh',
                  service: 'Lab Tests + Consultation',
                  total: '₹4,200',
                  insuredPaid: '₹3,600',
                  oop: '₹600',
                  status: 'Paid',
                  statusColor: AppColors.success,
                  isPending: false,
                ),
                _buildDataRow(
                  context,
                  date: '01 May 2026',
                  hospital: 'Himalayan Hospital',
                  service: 'OPD + HbA1c Test',
                  total: '₹2,800',
                  insuredPaid: '₹2,800',
                  oop: '₹0',
                  status: 'Paid',
                  statusColor: AppColors.success,
                  isPending: false,
                ),
                _buildDataRow(
                  context,
                  date: '28 Apr 2026',
                  hospital: 'AIIMS Rishikesh',
                  service: 'Chest X-Ray + Radiology',
                  total: '₹1,800',
                  insuredPaid: '₹1,800',
                  oop: '₹0',
                  status: 'Paid',
                  statusColor: AppColors.success,
                  isPending: false,
                ),
                _buildDataRow(
                  context,
                  date: '15 Apr 2026',
                  hospital: 'AIIMS Rishikesh',
                  service: 'Cardiology OPD + ECG',
                  total: '₹3,200',
                  insuredPaid: '₹0',
                  oop: '₹3,200',
                  status: 'Claim Pending',
                  statusColor: const Color(0xFFFFD166), // Yellow
                  isPending: true,
                ),
                _buildDataRow(
                  context,
                  date: '10 Mar 2026',
                  hospital: 'Himalayan Hospital',
                  service: 'USG Abdomen',
                  total: '₹2,400',
                  insuredPaid: '₹2,400',
                  oop: '₹0',
                  status: 'Paid',
                  statusColor: AppColors.success,
                  isPending: false,
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
    required String date,
    required String hospital,
    required String service,
    required String total,
    required String insuredPaid,
    required String oop,
    required String status,
    required Color statusColor,
    required bool isPending,
  }) {
    return DataRow(
      cells: [
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
            hospital,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            service,
            style: const TextStyle(color: AppColors.primaryText, fontSize: 11),
          ),
        ),
        DataCell(
          Text(
            total,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(
          Text(
            insuredPaid,
            style: const TextStyle(color: AppColors.primaryText, fontSize: 11),
          ),
        ),
        DataCell(
          Text(
            oop,
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
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isPending
                        ? 'Tracking claim status…'
                        : 'Downloading receipt…',
                  ),
                  backgroundColor: isPending
                      ? const Color(0xFFFFD166)
                      : AppColors.primaryLight,
                  // foregroundColor: isPending ? Colors.black : Colors.white,
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: isPending
                      ? const Color(0xFFFFD166).withValues(alpha: 0.3)
                      : AppColors.border,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                isPending ? Icons.access_time_rounded : Icons.download_rounded,
                color: isPending
                    ? const Color(0xFFFFD166)
                    : const Color(0xFF00B4D8),
                size: 11,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
