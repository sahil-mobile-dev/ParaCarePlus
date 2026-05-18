import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class InsuranceTpaTab extends StatelessWidget {
  const InsuranceTpaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMetricsRow(),
        const SizedBox(height: AppSpacing.lg),
        _buildPreAuthRequestsCard(),
        const SizedBox(height: AppSpacing.lg),
        _buildSubmittedClaimsCard(),
      ],
    );
  }

  Widget _buildMetricsRow() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Active Pre-Auths',
                '12',
                Icons.pending_actions_rounded,
                Colors.orange,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildMetricCard(
                'Approved Claims',
                '45',
                Icons.verified_rounded,
                AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                'Pending Amount',
                '₹2.4L',
                Icons.account_balance_wallet_rounded,
                AppColors.primary,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildMetricCard(
                'Rejected Claims',
                '3',
                Icons.cancel_rounded,
                AppColors.error,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, style: AppTextStyles.titleMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPreAuthRequestsCard() {
    return _buildCard(
      title: 'Pre-Auth Requests',
      icon: Icons.shield_outlined,
      action: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add_rounded, size: 16),
        label: const Text('New Pre-Auth'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 36),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 800),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.0),
              5: FlexColumnWidth(1.2),
            },
            children: [
              _buildPreAuthTableHeader(),
              _buildPreAuthTableRow(
                'PA-1042',
                'Savita Devi',
                'Star Health',
                '₹45,000',
                'Pending',
                Colors.orange,
              ),
              _buildPreAuthTableRow(
                'PA-1041',
                'Mohan Lal',
                'HDFC ERGO',
                '₹1,12,000',
                'Approved',
                AppColors.success,
              ),
              _buildPreAuthTableRow(
                'PA-1040',
                'Kishore Negi',
                'SBI General',
                '₹35,000',
                'Query',
                AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildPreAuthTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      children: [
        _headerCell('Req ID'),
        _headerCell('Patient'),
        _headerCell('TPA / Insurance'),
        _headerCell('Est. Amount'),
        _headerCell('Status'),
        _headerCell('Actions'),
      ],
    );
  }

  TableRow _buildPreAuthTableRow(
    String reqId,
    String patient,
    String tpa,
    String amount,
    String status,
    Color statusColor,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(reqId, isBold: true),
        _dataCell(patient),
        _dataCell(tpa),
        _dataCell(amount, isBold: true),
        _buildChipCell(status, statusColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              _actionIconButton(Icons.visibility_outlined, AppColors.primary),
              const SizedBox(width: 4),
              _actionIconButton(Icons.upload_file_outlined, AppColors.success),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubmittedClaimsCard() {
    return _buildCard(
      title: 'Submitted Claims',
      icon: Icons.assignment_turned_in_rounded,
      action: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.search_rounded, size: 16),
        label: const Text('Search Claims'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          minimumSize: const Size(0, 36),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 800),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1.5),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.2),
              4: FlexColumnWidth(1.0),
              5: FlexColumnWidth(1.2),
            },
            children: [
              _buildClaimTableHeader(),
              _buildClaimTableRow(
                'CLM-2098',
                'Ramesh Kumar',
                'ICICI Lombard',
                '₹55,000',
                'In Process',
                AppColors.primary,
              ),
              _buildClaimTableRow(
                'CLM-2097',
                'Anita Thapa',
                'Max Bupa',
                '₹85,000',
                'Settled',
                AppColors.success,
              ),
              _buildClaimTableRow(
                'CLM-2096',
                'Arjun Singh',
                'Star Health',
                '₹12,500',
                'Rejected',
                AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildClaimTableHeader() {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      children: [
        _headerCell('Claim ID'),
        _headerCell('Patient'),
        _headerCell('Insurance Co.'),
        _headerCell('Claim Amount'),
        _headerCell('Status'),
        _headerCell('Actions'),
      ],
    );
  }

  TableRow _buildClaimTableRow(
    String claimId,
    String patient,
    String insurance,
    String amount,
    String status,
    Color statusColor,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(claimId, isBold: true),
        _dataCell(patient),
        _dataCell(insurance),
        _dataCell(amount, isBold: true),
        _buildChipCell(status, statusColor),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              _actionIconButton(Icons.visibility_outlined, AppColors.primary),
              const SizedBox(width: 4),
              _actionIconButton(Icons.download_rounded, AppColors.success),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
    Widget? action,
  }) {
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
                  Icon(icon, size: 20, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Text(title, style: AppTextStyles.titleSmall),
                ],
              ),
              if (action != null) action,
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          child,
        ],
      ),
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

  Widget _actionIconButton(IconData icon, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Icon(icon, size: 14, color: color),
    );
  }
}
