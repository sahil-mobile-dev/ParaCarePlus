import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ClaimsTab extends StatefulWidget {
  const ClaimsTab({super.key});

  @override
  State<ClaimsTab> createState() => _ClaimsTabState();
}

class _ClaimsTabState extends State<ClaimsTab> {
  final List<Map<String, dynamic>> _claims = [
    {
      'id': 'CLM-88902',
      'patient': 'Devendra Rawat',
      'insurer': 'Star Health Insurance',
      'amount': '₹85,000',
      'approved': '₹80,750',
      'settledDate': '2026-05-18',
      'txId': 'TXN-SH-990142',
      'status': 'Paid',
      'statusColor': AppColors.success,
    },
    {
      'id': 'CLM-88903',
      'patient': 'Rajni Kant',
      'insurer': 'Niva Bupa Health',
      'amount': '₹1,50,000',
      'approved': '₹1,35,000',
      'settledDate': '2026-05-19',
      'txId': 'TXN-NB-204192',
      'status': 'Paid',
      'statusColor': AppColors.success,
    },
    {
      'id': 'CLM-88904',
      'patient': 'Harendra Pal',
      'insurer': 'HDFC ERGO General',
      'amount': '₹2,30,000',
      'approved': '--',
      'settledDate': '--',
      'txId': '--',
      'status': 'In Progress',
      'statusColor': AppColors.primary,
    },
    {
      'id': 'CLM-88905',
      'patient': 'Kiran Negi',
      'insurer': 'ICICI Lombard GIC',
      'amount': '₹48,500',
      'approved': '₹32,000',
      'settledDate': '2026-05-12',
      'txId': 'TXN-IC-110294',
      'status': 'Disputed',
      'statusColor': AppColors.error,
    },
  ];

  bool _isSyncing = false;

  void _syncRemittance() {
    setState(() => _isSyncing = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isSyncing = false;
          // Simulate modifying one claim on sync
          _claims[2] = {
            'id': 'CLM-88904',
            'patient': 'Harendra Pal',
            'insurer': 'HDFC ERGO General',
            'amount': '₹2,30,000',
            'approved': '₹2,18,500',
            'settledDate': '2026-05-21',
            'txId': 'TXN-HE-002931',
            'status': 'Paid',
            'statusColor': AppColors.success,
          };
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.success,
            content: Text('Remittance register re-synced! Harendra Pal claim settled successfully.'),
          ),
        );
      }
    });
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
                    Icon(Icons.account_balance_wallet_rounded, color: AppColors.primary, size: 22),
                    SizedBox(width: 8),
                    Text('Electronic Claims Settlement (ECS) Register', style: AppTextStyles.titleSmall),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: _isSyncing ? null : _syncRemittance,
                  icon: _isSyncing
                      ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.sync_rounded, size: 16),
                  label: Text(_isSyncing ? 'Syncing...' : 'Sync TPA Remittance'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
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
              constraints: const BoxConstraints(minWidth: 900),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(1.2),
                  1: FlexColumnWidth(1.8),
                  2: FlexColumnWidth(2.2),
                  3: FlexColumnWidth(1.2),
                  4: FlexColumnWidth(1.2),
                  5: FlexColumnWidth(1.3),
                  6: FlexColumnWidth(2),
                  7: FlexColumnWidth(1.2),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    children: [
                      _headerCell('Claim ID'),
                      _headerCell('Patient'),
                      _headerCell('Insurer / TPA'),
                      _headerCell('Claimed'),
                      _headerCell('Approved Payout'),
                      _headerCell('Settled Date'),
                      _headerCell('Transaction ID'),
                      _headerCell('Status'),
                    ],
                  ),
                  ..._claims.map(_buildTableRow),
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
    final insurer = row['insurer'] as String;
    final amount = row['amount'] as String;
    final approved = row['approved'] as String;
    final settledDate = row['settledDate'] as String;
    final txId = row['txId'] as String;
    final status = row['status'] as String;
    final statusColor = row['statusColor'] as Color;

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _cell(id, isBold: true),
        _cell(patient),
        _cell(insurer),
        _cell(amount),
        _cell(approved, isGreen: status == 'Paid'),
        _cell(settledDate),
        _cell(txId),
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
      ],
    );
  }

  Widget _headerCell(String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      child: Text(t, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText, fontWeight: FontWeight.bold)),
    );
  }

  Widget _cell(String val, {bool isBold = false, bool isGreen = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isGreen ? AppColors.success : AppColors.primaryText,
          ),
        ),
      ),
    );
  }
}
