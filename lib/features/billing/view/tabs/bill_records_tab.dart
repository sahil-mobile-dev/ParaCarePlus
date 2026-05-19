import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class BillRecordsTab extends StatelessWidget {
  const BillRecordsTab({super.key});

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
          _buildHeaderRow(),
          const SizedBox(height: AppSpacing.lg),
          _buildTable(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.list_alt_rounded, size: 20, color: AppColors.primary),
            SizedBox(width: 8),
            Text('Bill Records', style: AppTextStyles.titleSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            SizedBox(
              width: 175,
              child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Search patient, bill no...',
                  hintStyle: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 13,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 16,
                    color: AppColors.secondaryText,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.border),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'All Status',
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.secondaryText,
                    size: 18,
                  ),
                  dropdownColor: AppColors.card,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  items: const [
                    DropdownMenuItem(
                      value: 'All Status',
                      child: Text('All Status'),
                    ),
                    DropdownMenuItem(value: 'Paid', child: Text('Paid')),
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                  ],
                  onChanged: (_) {},
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.file_download_outlined, size: 16),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ), // matched height with dropdown
              ),
            ),
          ],
        ),
      ],
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
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(1.2),
            7: FlexColumnWidth(1.2),
            8: FlexColumnWidth(1.5),
            9: FlexColumnWidth(2),
          },
          children: [
            _buildTableHeader(),
            _buildTableRow(
              'BL-001',
              'Ramesh Kumar',
              'UK-00421',
              'IPD',
              '12/04',
              '₹12,500',
              '₹12,500',
              '₹0',
              'Paid',
              AppColors.success,
            ),
            _buildTableRow(
              'BL-002',
              'Savita Devi',
              'UK-00318',
              'OPD',
              '12/04',
              '₹850',
              '₹850',
              '₹0',
              'Paid',
              AppColors.success,
            ),
            _buildTableRow(
              'BL-003',
              'Kishore Negi',
              'UK-00512',
              'IPD',
              '12/04',
              '₹4,500',
              '₹2,000',
              '₹2,500',
              'Partial',
              Colors.orange,
            ),
            _buildTableRow(
              'BL-004',
              'Meena Bisht',
              'UK-00290',
              'OPD',
              '12/04',
              '₹1,200',
              '₹0',
              '₹1,200',
              'Pending',
              AppColors.error,
            ),
            _buildTableRow(
              'BL-005',
              'Arjun Singh',
              'UK-00601',
              'Emergency',
              '12/04',
              '₹3,200',
              '₹3,200',
              '₹0',
              'Paid',
              AppColors.success,
            ),
            _buildTableRow(
              'BL-006',
              'Pushpa Karki',
              'UK-00445',
              'OPD',
              '12/04',
              '₹650',
              '₹650',
              '₹0',
              'Paid',
              AppColors.success,
            ),
            _buildTableRow(
              'BL-007',
              'Mohan Lal',
              'UK-00389',
              'IPD',
              '11/04',
              '₹8,900',
              '₹0',
              '₹8,900',
              'Credit',
              Colors.purple,
            ),
            _buildTableRow(
              'BL-008',
              'Anita Thapa',
              'UK-00271',
              'OPD',
              '11/04',
              '₹720',
              '₹720',
              '₹0',
              'Paid',
              AppColors.success,
            ),
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
        _headerCell('Bill No'),
        _headerCell('Patient'),
        _headerCell('UHID'),
        _headerCell('Visit'),
        _headerCell('Date'),
        _headerCell('Amount'),
        _headerCell('Paid'),
        _headerCell('Balance'),
        _headerCell('Status'),
        _headerCell('Actions'),
      ],
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  TableRow _buildTableRow(
    String billNo,
    String patient,
    String uhid,
    String visit,
    String date,
    String amount,
    String paid,
    String balance,
    String status,
    Color statusColor,
  ) {
    Color visitColor = visit == 'IPD'
        ? AppColors.primary
        : (visit == 'OPD' ? AppColors.success : Colors.orange);
    bool showPayAction =
        status == 'Partial' || status == 'Pending' || status == 'Credit';

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(billNo, isBold: true),
        _dataCell(patient),
        _dataCell(uhid, color: AppColors.secondaryText),
        _buildChipCell(visit, visitColor),
        _dataCell(date),
        _dataCell(amount),
        _dataCell(paid, color: AppColors.success),
        _dataCell(
          balance,
          color: balance == '₹0' ? AppColors.success : AppColors.error,
        ),
        _buildChipCell(status, statusColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              _actionIconButton(Icons.visibility_outlined, AppColors.primary),
              const SizedBox(width: 4),
              _actionIconButton(Icons.print_outlined, AppColors.primary),
              if (showPayAction) ...[
                const SizedBox(width: 4),
                _actionIconButton(
                  Icons.currency_rupee_rounded,
                  AppColors.success,
                  isFilled: true,
                ),
              ],
            ],
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
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _actionIconButton(
    IconData icon,
    Color color, {
    bool isFilled = false,
  }) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: isFilled ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Icon(icon, size: 14, color: isFilled ? Colors.white : color),
    );
  }
}
