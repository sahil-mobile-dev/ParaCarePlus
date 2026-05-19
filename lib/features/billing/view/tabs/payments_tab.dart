import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class PaymentsTab extends StatelessWidget {
  const PaymentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 1, child: _buildCollectPaymentCard()),
              const SizedBox(width: AppSpacing.lg),
              Expanded(flex: 2, child: _buildCollectionsCard()),
            ],
          );
        }

        return Column(
          children: [
            _buildCollectPaymentCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildCollectionsCard(),
          ],
        );
      },
    );
  }

  Widget _buildCollectPaymentCard() {
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
          const Row(
            children: [
              Icon(
                Icons.currency_rupee_rounded,
                size: 20,
                color: AppColors.success,
              ),
              SizedBox(width: 8),
              Text('Collect Payment', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildTextField(
            'Search Bill No / UHID',
            hint: 'Enter Bill No or UHID',
            suffixIcon: Icons.search_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Patient summary box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Ramesh Kumar', style: AppTextStyles.titleSmall),
                const SizedBox(height: 4),
                Text(
                  'UHID: UK-00421 | Bill: BL-001',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const Divider(color: AppColors.border, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bill Total:',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      '₹12,500',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount Paid:',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      '₹8,000',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Balance Due:',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹4,500',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.xl),
          _buildTextField('Amount to Pay (₹)', hint: '4500'),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Payment Method',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildPaymentToggle(
                'Cash',
                Icons.money_rounded,
                isSelected: true,
              ),
              _buildPaymentToggle('UPI', Icons.qr_code_rounded),
              _buildPaymentToggle('Card', Icons.credit_card_rounded),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _buildTextField('Transaction No', hint: 'Txn reference'),
          const SizedBox(height: AppSpacing.xl),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_rounded, size: 18),
            label: const Text('Receive Payment & Print Receipt'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsCard() {
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
                    Icons.account_balance_wallet_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8),
                  Text('Today\'s Collections', style: AppTextStyles.titleSmall),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.summarize_outlined, size: 16),
                label: const Text('Day Summary'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 36),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox('Cash', '₹24,500', AppColors.success),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildSummaryBox('UPI', '₹18,200', AppColors.primary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildSummaryBox('Card/NEFT', '₹12,000', Colors.orange),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildSummaryBox(
                  'Total',
                  '₹54,700',
                  Colors.white,
                  isTotal: true,
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

  Widget _buildSummaryBox(
    String title,
    String amount,
    Color color, {
    bool isTotal = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isTotal
            ? AppColors.primary.withValues(alpha: 0.2)
            : AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isTotal ? AppColors.primary : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 4),
          Text(amount, style: AppTextStyles.titleMedium.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 800),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(1.5),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(1),
          },
          children: [
            _buildTableHeader(),
            _buildTableRow(
              'RCPT-101',
              'BL-001',
              'Ramesh Kumar',
              '₹8,000',
              'Cash',
              '10:30 AM',
              'System Admin',
            ),
            _buildTableRow(
              'RCPT-102',
              'BL-003',
              'Kishore Negi',
              '₹2,000',
              'UPI',
              '11:15 AM',
              'John Doe',
            ),
            _buildTableRow(
              'RCPT-103',
              'BL-005',
              'Arjun Singh',
              '₹3,200',
              'Card',
              '11:45 AM',
              'John Doe',
            ),
            _buildTableRow(
              'RCPT-104',
              'BL-008',
              'Anita Thapa',
              '₹720',
              'Cash',
              '12:20 PM',
              'System Admin',
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
        _headerCell('Receipt No'),
        _headerCell('Bill No'),
        _headerCell('Patient'),
        _headerCell('Amount'),
        _headerCell('Mode'),
        _headerCell('Time'),
        _headerCell('Collected By'),
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
    String receiptNo,
    String billNo,
    String patient,
    String amount,
    String mode,
    String time,
    String collectedBy,
  ) {
    Color modeColor = mode == 'Cash'
        ? AppColors.success
        : (mode == 'UPI' ? AppColors.primary : Colors.orange);

    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(receiptNo, isBold: true),
        _dataCell(billNo, color: AppColors.secondaryText),
        _dataCell(patient),
        _dataCell(amount, color: AppColors.success, isBold: true),
        _buildChipCell(mode, modeColor),
        _dataCell(time, color: AppColors.secondaryText),
        _dataCell(collectedBy),
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

  Widget _buildTextField(
    String label, {
    required String hint,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
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
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, size: 16, color: AppColors.secondaryText)
                : null,
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
      ],
    );
  }

  Widget _buildPaymentToggle(
    String label,
    IconData icon, {
    bool isSelected = false,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.success.withValues(alpha: 0.1)
              : AppColors.background,
          border: Border.all(
            color: isSelected ? AppColors.success : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.success : AppColors.secondaryText,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.success : AppColors.secondaryText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
