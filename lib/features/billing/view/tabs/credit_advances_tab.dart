import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class CreditAdvancesTab extends StatelessWidget {
  const CreditAdvancesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildPatientDepositsCard()),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: _buildCreditOrganisationsCard()),
            ],
          );
        }

        return Column(
          children: [
            _buildPatientDepositsCard(),
            const SizedBox(height: AppSpacing.lg),
            _buildCreditOrganisationsCard(),
          ],
        );
      },
    );
  }

  Widget _buildPatientDepositsCard() {
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
                    Icons.account_balance_rounded,
                    size: 20,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 8),
                  Text('Patient Deposits', style: AppTextStyles.titleSmall),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('New Deposit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
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
          _buildDepositsTable(),
        ],
      ),
    );
  }

  Widget _buildCreditOrganisationsCard() {
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
              Icon(Icons.business_rounded, size: 20, color: AppColors.success),
              SizedBox(width: 8),
              Text('Credit Organisations', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildOrganisationsTable(),
        ],
      ),
    );
  }

  Widget _buildDepositsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 500),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1.5),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(0.8),
          },
          children: [
            _buildTableHeader([
              'Patient',
              'Date',
              'Deposited',
              'Used',
              'Balance',
              'Action',
            ]),
            _buildDepositRow(
              'Kishore Negi',
              '10/04',
              '₹10,000',
              '₹5,000',
              '₹5,000',
            ),
            _buildDepositRow('Meena Bisht', '12/04', '₹5,000', '₹0', '₹5,000'),
            _buildDepositRow(
              'Anita Thapa',
              '11/04',
              '₹2,000',
              '₹720',
              '₹1,280',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganisationsTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 500),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.2),
            2: FlexColumnWidth(1.2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(),
          },
          children: [
            _buildTableHeader([
              'Organisation',
              'Limit',
              'Used',
              'Balance',
              'Status',
            ]),
            _buildOrganisationRow(
              'Uttarakhand Police Welfare',
              '₹2,00,000',
              '₹45,000',
              '₹1,55,000',
              'Active',
              AppColors.success,
            ),
            _buildOrganisationRow(
              'ONGC Employees',
              '₹5,00,000',
              '₹1,20,000',
              '₹3,80,000',
              'Active',
              AppColors.success,
            ),
            _buildOrganisationRow(
              'Army Unit 18 RR',
              '₹3,00,000',
              '₹2,80,000',
              '₹20,000',
              'Near Limit',
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader(List<String> headers) {
    return TableRow(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(6),
      ),
      children: headers.map(_headerCell).toList(),
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

  TableRow _buildDepositRow(
    String patient,
    String date,
    String deposited,
    String used,
    String balance,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(patient, isBold: true),
        _dataCell(date, color: AppColors.secondaryText),
        _dataCell(deposited, color: AppColors.primary, isBold: true),
        _dataCell(used, color: Colors.orange, isBold: true),
        _dataCell(balance, color: AppColors.success, isBold: true),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: _actionIconButton(
              Icons.visibility_outlined,
              AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildOrganisationRow(
    String org,
    String limit,
    String used,
    String balance,
    String status,
    Color statusColor,
  ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      children: [
        _dataCell(org, isBold: true),
        _dataCell(limit),
        _dataCell(used, color: Colors.orange),
        _dataCell(balance, color: AppColors.success, isBold: true),
        _buildChipCell(status, statusColor),
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
