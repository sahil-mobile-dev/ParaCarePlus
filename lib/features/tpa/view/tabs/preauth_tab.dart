import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class PreauthTab extends StatefulWidget {
  const PreauthTab({super.key});

  @override
  State<PreauthTab> createState() => _PreauthTabState();
}

class _PreauthTabState extends State<PreauthTab> {
  final List<Map<String, dynamic>> _queue = [
    {
      'id': 'PA-2026-904',
      'patient': 'Amit Shah',
      'insurer': 'Star Health Insurance',
      'procedure': 'Laparoscopic Cholecystectomy',
      'amount': '₹1,15,000',
      'status': 'Approved',
      'statusColor': AppColors.success,
    },
    {
      'id': 'PA-2026-905',
      'patient': 'Nirmala Devi',
      'insurer': 'Niva Bupa Health',
      'procedure': 'Total Knee Replacement',
      'amount': '₹2,45,000',
      'status': 'Queries Raised',
      'statusColor': AppColors.secondaryAccent,
    },
    {
      'id': 'PA-2026-906',
      'patient': 'Vipin Rawat',
      'insurer': 'HDFC ERGO General',
      'procedure': 'CABG (Heart Surgery)',
      'amount': '₹3,80,000',
      'status': 'Sent to TPA',
      'statusColor': AppColors.primary,
    },
    {
      'id': 'PA-2026-907',
      'patient': 'Sanjay Sen',
      'insurer': 'ICICI Lombard GIC',
      'procedure': 'Appendectomy',
      'amount': '₹75,000',
      'status': 'Draft',
      'statusColor': AppColors.secondaryText,
    },
  ];

  void _newPreAuthWizard() {
    showDialog<void>(
      context: context,
      builder: (context) {
        var patient = '';
        var procedure = '';
        var amount = '';
        var insurer = 'Star Health Insurance';

        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'New Pre-Authorization Request',
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.primaryText),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                onChanged: (val) => patient = val,
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Medical Procedure / Surgery',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                onChanged: (val) => procedure = val,
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Estimated Cost Amount (₹)',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(color: AppColors.primaryText),
                onChanged: (val) => amount = val,
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                initialValue: insurer,
                dropdownColor: AppColors.surface,
                decoration: const InputDecoration(
                  labelText: 'Insurer / TPA',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                ),
                style: const TextStyle(color: AppColors.primaryText),
                items: const [
                  DropdownMenuItem(value: 'Star Health Insurance', child: Text('Star Health Insurance')),
                  DropdownMenuItem(value: 'Niva Bupa Health', child: Text('Niva Bupa Health')),
                  DropdownMenuItem(value: 'HDFC ERGO General', child: Text('HDFC ERGO General')),
                  DropdownMenuItem(value: 'ICICI Lombard GIC', child: Text('ICICI Lombard GIC')),
                ],
                onChanged: (val) {
                  if (val != null) insurer = val;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.secondaryText)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              onPressed: () {
                if (patient.isNotEmpty && procedure.isNotEmpty && amount.isNotEmpty) {
                  setState(() {
                    _queue.insert(0, {
                      'id': 'PA-2026-${908 + _queue.length}',
                      'patient': patient,
                      'insurer': insurer,
                      'procedure': procedure,
                      'amount': '₹$amount',
                      'status': 'Sent to TPA',
                      'statusColor': AppColors.primary,
                    });
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text('Pre-Auth request generated and sent to $insurer!'),
                    ),
                  );
                }
              },
              child: const Text('Submit Request', style: TextStyle(color: Colors.white)),
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
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.playlist_add_check_rounded, color: AppColors.primary, size: 22),
                    SizedBox(width: 8),
                    Text('Active Pre-Authorization Worklist', style: AppTextStyles.titleSmall),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _newPreAuthWizard,
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('New Request'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
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
                  3: FlexColumnWidth(2.2),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(1.5),
                  6: FlexColumnWidth(1.2),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    children: [
                      _headerCell('Pre-Auth ID'),
                      _headerCell('Patient Name'),
                      _headerCell('Medical Procedure'),
                      _headerCell('TPA Insurer'),
                      _headerCell('Est. Cost'),
                      _headerCell('Workflow Status'),
                      _headerCell('Action'),
                    ],
                  ),
                  ..._queue.map(_buildTableRow),
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
    final procedure = row['procedure'] as String;
    final insurer = row['insurer'] as String;
    final amount = row['amount'] as String;
    final status = row['status'] as String;
    final statusColor = row['statusColor'] as Color;

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _cell(id, isBold: true),
        _cell(patient),
        _cell(procedure),
        _cell(insurer),
        _cell(amount),
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
                style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              if (status == 'Queries Raised')
                TextButton(
                  onPressed: () {
                    setState(() {
                      row['status'] = 'Sent to TPA';
                      row['statusColor'] = AppColors.primary;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.success,
                        content: Text('Additional diagnostics uploaded. Claim $id re-submitted!'),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  child: const Text('Resolve', style: TextStyle(color: AppColors.secondaryAccent, fontSize: 11, fontWeight: FontWeight.bold)),
                )
              else if (status == 'Draft')
                TextButton(
                  onPressed: () {
                    setState(() {
                      row['status'] = 'Sent to TPA';
                      row['statusColor'] = AppColors.primary;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.success,
                        content: Text('Pre-authorization $id submitted to TPA!'),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                  child: const Text('Submit', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                )
              else
                const Text('--', style: TextStyle(color: AppColors.secondaryText)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerCell(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(t, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText, fontWeight: FontWeight.bold)),
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
