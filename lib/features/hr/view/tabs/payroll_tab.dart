import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/hr/view_model/hr_view_model.dart';
import 'package:paracareplus/features/hr/model/hr_model.dart';

class PayrollTab extends ConsumerWidget {
  const PayrollTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payrollList = ref.watch(hrProvider.select((s) => s.payrollList));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSummaryBar(context, ref),
        const SizedBox(height: AppSpacing.lg),
        _buildPayrollTableCard(context, ref, payrollList),
      ],
    );
  }

  Widget _buildSummaryBar(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.payments_outlined, color: AppColors.primary, size: 24),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Salaries & Disbursal Center',
                    style: AppTextStyles.titleSmall,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Disbursal cycle: May 2026',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.success,
                  content: Text(
                    'Disbursement Batch for May 2026 triggered successfully!',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.check_circle_outline_rounded, size: 16),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayrollTableCard(BuildContext context, WidgetRef ref, List<PayrollItem> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.secondaryAccent,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Employee Compensation & Allowances',
                  style: AppTextStyles.titleSmall,
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 1),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 850),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: FlexColumnWidth(1.8),
                  2: FlexColumnWidth(1.2),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(1.2),
                  6: FlexColumnWidth(1.2),
                  7: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    children: [
                      _headerCell('Staff ID'),
                      _headerCell('Staff Member'),
                      _headerCell('Base Salary'),
                      _headerCell('Allowances'),
                      _headerCell('Deductions'),
                      _headerCell('Tax Deducted'),
                      _headerCell('Net Payout'),
                      _headerCell('Payslip Disbursal'),
                    ],
                  ),
                  ...items.map((row) {
                    final cleanSalaryStr = row.salary.replaceAll(RegExp(r'[^0-9]'), '');
                    final base = int.tryParse(cleanSalaryStr) ?? 30000;
                    final allowance = (base * 0.15).round();
                    final deductions = (base * 0.05).round();
                    final tax = (base * 0.10).round();
                    final net = base + allowance - deductions - tax;

                    return TableRow(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.border),
                        ),
                      ),
                      children: [
                        _cell(row.id, isBold: true),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                row.name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(row.designation, style: AppTextStyles.bodySmall),
                            ],
                          ),
                        ),
                        _cell('₹$base'),
                        _cell('₹$allowance'),
                        _cell('₹$deductions'),
                        _cell('₹$tax'),
                        _cell('₹$net', isBold: true, color: AppColors.success),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              ref.read(hrProvider.notifier).processPayroll(row.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    row.status == 'PAID'
                                        ? 'Payslip for ${row.name} is already processed!'
                                        : 'Processing and disbursing payroll for ${row.name}...',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: row.status == 'PAID'
                                  ? AppColors.success.withValues(alpha: 0.2)
                                  : AppColors.primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              minimumSize: const Size(0, 30),
                            ),
                            child: Text(
                              row.status == 'PAID' ? 'Downloaded' : 'Disburse',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCell(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(
        t,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _cell(String val, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            color: color ?? AppColors.primaryText,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
