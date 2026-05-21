import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DisputesTab extends StatefulWidget {
  const DisputesTab({super.key});

  @override
  State<DisputesTab> createState() => _DisputesTabState();
}

class _DisputesTabState extends State<DisputesTab> {
  final List<Map<String, dynamic>> _rejections = [
    {
      'id': 'DISP-4012',
      'patient': 'Kiran Negi',
      'tpa': 'ICICI Lombard GIC',
      'amount': '₹48,500',
      'code': 'ERR-TPA-102',
      'reason': 'Mismatched Diagnostics code in Pre-Auth billing.',
      'status': 'Pending Draft',
      'statusColor': AppColors.secondaryText,
    },
    {
      'id': 'DISP-4013',
      'patient': 'Devendra Rawat',
      'tpa': 'Star Health Insurance',
      'amount': '₹12,400',
      'code': 'ERR-TPA-305',
      'reason': 'Non-medical consumable deductions exceed margin.',
      'status': 'Under Appeal',
      'statusColor': AppColors.primary,
    },
    {
      'id': 'DISP-4014',
      'patient': 'Dr. Rohan Mehra (Staff Family)',
      'tpa': 'Niva Bupa Health',
      'amount': '₹95,000',
      'code': 'ERR-TPA-412',
      'reason': 'Excluded package clause: Cosmetic implants.',
      'status': 'Appeal Denied',
      'statusColor': AppColors.error,
    },
  ];

  void _draftAppealWizard(Map<String, dynamic> claim) {
    final tpa = claim['tpa'] as String;
    final code = claim['code'] as String;
    final patient = claim['patient'] as String;
    final reason = claim['reason'] as String;

    var appealText =
        'To,\nThe Claims Department\n$tpa\n\n'
        'Subject: Appeal against Rejection Code $code for Patient $patient.\n\n'
        'We have reviewed the rejection indicating: "$reason". '
        'We hereby submit verified clinical records and diagnostic logs supporting the absolute necessity of the procedure and items charged. Please re-assess the claim.\n\n'
        'Sincerely,\nParaCarePlus Admin Desk';

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Draft Appeal Letter',
            style: AppTextStyles.titleMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Review and edit the formal appeal letter draft:',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  TextField(
                    maxLines: 8,
                    controller: TextEditingController(text: appealText),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: AppColors.background,
                      filled: true,
                    ),
                    style: const TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 12,
                      height: 1.4,
                    ),
                    onChanged: (val) => appealText = val,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                setState(() {
                  claim['status'] = 'Under Appeal';
                  claim['statusColor'] = AppColors.primary;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.success,
                    content: Text(
                      'Appeal submitted successfully to $tpa for patient $patient!',
                    ),
                  ),
                );
              },
              child: const Text(
                'Send Appeal',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                Icon(Icons.gpp_maybe_rounded, color: AppColors.error, size: 22),
                SizedBox(width: 8),
                Text(
                  'Claim Rejections & Disputes Panel',
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
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(1.8),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(2.5),
                  6: FlexColumnWidth(1.5),
                  7: FlexColumnWidth(1.5),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    children: [
                      _headerCell('Dispute ID'),
                      _headerCell('Patient Name'),
                      _headerCell('TPA Insurer'),
                      _headerCell('Est. Cost'),
                      _headerCell('Code'),
                      _headerCell('Reason of Rejection'),
                      _headerCell('Appeal Status'),
                      _headerCell('Action'),
                    ],
                  ),
                  ..._rejections.map(_buildTableRow),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(Map<String, dynamic> row) {
    final id = row['id'] as String;
    final patient = row['patient'] as String;
    final tpa = row['tpa'] as String;
    final amount = row['amount'] as String;
    final code = row['code'] as String;
    final reason = row['reason'] as String;
    final status = row['status'] as String;
    final statusColor = row['statusColor'] as Color;

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _cell(id, isBold: true),
        _cell(patient),
        _cell(tpa),
        _cell(amount),
        _cell(code),
        _cell(reason),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              if (status == 'Pending Draft')
                ElevatedButton(
                  onPressed: () => _draftAppealWizard(row),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    minimumSize: Size.zero,
                  ),
                  child: const Text(
                    'Draft Appeal',
                    style: TextStyle(fontSize: 10),
                  ),
                )
              else
                const Text(
                  '--',
                  style: TextStyle(color: AppColors.secondaryText),
                ),
            ],
          ),
        ),
      ],
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

  Widget _cell(String val, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
