import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RecentTransactionsTable extends StatelessWidget {
  const RecentTransactionsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        'id': 'BL-001',
        'patient': 'Ramesh Kumar',
        'type': 'IPD',
        'amount': '₹12,500',
        'status': 'Paid',
        'time': '12/04/04',
      },
      {
        'id': 'BL-002',
        'patient': 'Savita Devi',
        'type': 'OPD',
        'amount': '₹850',
        'status': 'Paid',
        'time': '12/04/04',
      },
      {
        'id': 'BL-003',
        'patient': 'Kishore Negi',
        'type': 'IPD',
        'amount': '₹4,500',
        'status': 'Partial',
        'time': '12/04/04',
      },
      {
        'id': 'BL-004',
        'patient': 'Meena Bisht',
        'type': 'OPD',
        'amount': '₹1,200',
        'status': 'Pending',
        'time': '12/04/04',
      },
      {
        'id': 'BL-005',
        'patient': 'Arjun Singh',
        'type': 'Emergency',
        'amount': '₹3,200',
        'status': 'Paid',
        'time': '12/04/04',
      },
      {
        'id': 'BL-006',
        'patient': 'Pushpa Karki',
        'type': 'OPD',
        'amount': '₹650',
        'status': 'Paid',
        'time': '12/04/04',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.list_alt_rounded,
                    size: 20,
                    color: AppColors.primaryText,
                  ),
                  SizedBox(width: 8),
                  Text('Recent Transactions', style: AppTextStyles.titleSmall),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingTextStyle: AppTextStyles.labelSmall.copyWith(
                color: AppColors.secondaryText,
                fontWeight: FontWeight.bold,
              ),
              dataTextStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primaryText,
              ),
              dividerThickness: 0.5,
              columns: const [
                DataColumn(label: Text('Bill No')),
                DataColumn(label: Text('Patient')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Action')),
              ],
              rows: transactions.map((t) {
                Color statusColor;
                Color statusBg;
                switch (t['status']) {
                  case 'Paid':
                    statusColor = AppColors.success;
                    statusBg = AppColors.success.withValues(alpha: 0.1);
                  case 'Pending':
                    statusColor = AppColors.error;
                    statusBg = AppColors.error.withValues(alpha: 0.1);
                  case 'Partial':
                  default:
                    statusColor = AppColors.secondaryAccent;
                    statusBg = AppColors.secondaryAccent.withValues(alpha: 0.1);
                }

                Color typeColor;
                Color typeBg;
                switch (t['type']) {
                  case 'IPD':
                    typeColor = AppColors.primary;
                    typeBg = AppColors.primary.withValues(alpha: 0.1);
                  case 'Emergency':
                    typeColor = AppColors.error;
                    typeBg = AppColors.error.withValues(alpha: 0.1);
                  default:
                    typeColor = Colors.blue;
                    typeBg = Colors.blue.withValues(alpha: 0.1);
                }

                return DataRow(
                  cells: [
                    DataCell(Text(t['id']!)),
                    DataCell(
                      Text(
                        t['patient']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: typeBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          t['type']!,
                          style: TextStyle(
                            color: typeColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        t['amount']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusBg,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          t['status']!,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        t['time']!,
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: const Icon(
                          Icons.visibility_outlined,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
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
