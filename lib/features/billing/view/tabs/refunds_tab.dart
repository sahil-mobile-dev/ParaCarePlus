import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RefundsTab extends StatelessWidget {
  const RefundsTab({super.key});

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  const Icon(Icons.replay_rounded, size: 20, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text('Refund Requests', style: AppTextStyles.titleSmall),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('New Refund'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  minimumSize: const Size(0, 36),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildTable(),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 1000),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(2.0),
            3: FlexColumnWidth(2.0),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.5),
            6: FlexColumnWidth(1.2),
            7: FlexColumnWidth(1.0),
          },
          children: [
            _buildTableHeader(),
            _buildTableRow('REF-001', 'BL-2024-890', 'Ram Prasad', 'Cancelled Test', '₹2,200', 'Dr. Sharma', 'Approved', AppColors.success),
            _buildTableRow('REF-002', 'BL-2025-012', 'Kamala Devi', 'Overpayment', '₹500', 'Admin', 'Pending', Colors.orange),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      children: [
        _headerCell('Refund No'),
        _headerCell('Bill No'),
        _headerCell('Patient'),
        _headerCell('Reason'),
        _headerCell('Amount'),
        _headerCell('Requested By'),
        _headerCell('Status'),
        _headerCell('Action'),
      ],
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText),
      ),
    );
  }

  TableRow _buildTableRow(
    String refundNo,
    String billNo,
    String patient,
    String reason,
    String amount,
    String requestedBy,
    String status,
    Color statusColor,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(refundNo, color: AppColors.secondaryText),
        _dataCell(billNo),
        _dataCell(patient, isBold: true),
        _dataCell(reason),
        _dataCell(amount, isBold: true),
        _dataCell(requestedBy, color: AppColors.secondaryText),
        _buildChipCell(status, statusColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _actionIconButton(Icons.check_rounded, AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _dataCell(String text, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.primaryText,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildChipCell(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _actionIconButton(IconData icon, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Icon(
        icon,
        size: 14,
        color: color,
      ),
    );
  }
}
