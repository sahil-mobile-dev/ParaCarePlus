import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class PayrollTab extends StatefulWidget {
  const PayrollTab({super.key});

  @override
  State<PayrollTab> createState() => _PayrollTabState();
}

class _PayrollTabState extends State<PayrollTab> {
  final List<Map<String, dynamic>> _payroll = [
    {
      'id': 'EMP-1042',
      'name': 'Dr. Alok Verma',
      'role': 'HOD Cardiology',
      'base': 180000,
      'allowance': 35000,
      'deductions': 12000,
      'tax': 25000,
      'status': 'Paid',
    },
    {
      'id': 'EMP-2210',
      'name': 'Shashi Kiran',
      'role': 'Senior Staff Nurse',
      'base': 45000,
      'allowance': 8000,
      'deductions': 3000,
      'tax': 1500,
      'status': 'Paid',
    },
    {
      'id': 'EMP-1102',
      'name': 'Dr. Meera Gupta',
      'role': 'Senior Radiologist',
      'base': 150000,
      'allowance': 28000,
      'deductions': 10000,
      'tax': 20000,
      'status': 'Processing',
    },
    {
      'id': 'EMP-3049',
      'name': 'Aman Rawat',
      'role': 'HR Operations Lead',
      'base': 65000,
      'allowance': 12000,
      'deductions': 4500,
      'tax': 3200,
      'status': 'Paid',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSummaryBar(),
        const SizedBox(height: AppSpacing.lg),
        _buildPayrollTableCard(),
      ],
    );
  }

  Widget _buildSummaryBar() {
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

  Widget _buildPayrollTableCard() {
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
                  ..._payroll.map((row) {
                    final base = row['base'] as int;
                    final allowance = row['allowance'] as int;
                    final deductions = row['deductions'] as int;
                    final tax = row['tax'] as int;
                    final name = row['name'] as String;
                    final role = row['role'] as String;
                    final id = row['id'] as String;
                    final net = base + allowance - deductions - tax;
                    return TableRow(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColors.border),
                        ),
                      ),
                      children: [
                        _cell(id, isBold: true),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(role, style: AppTextStyles.bodySmall),
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Generating PDF payslip for $name...',
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.background,
                              foregroundColor: AppColors.primaryText,
                              side: const BorderSide(color: AppColors.border),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              minimumSize: const Size(0, 30),
                            ),
                            child: const Text(
                              'Download Slip',
                              style: TextStyle(fontSize: 10),
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
