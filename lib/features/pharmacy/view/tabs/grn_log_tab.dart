import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/pharmacy/view_model/pharmacy_view_model.dart';

class GrnLogTab extends ConsumerWidget {
  const GrnLogTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grnLogs = ref.watch(pharmacyProvider.select((s) => s.grnLogs));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Table Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Goods Received Note (GRN) History',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.border),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.download_rounded,
                            size: 14,
                            color: AppColors.secondaryText,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Export Log',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(140), // GRN No
                    1: FixedColumnWidth(140), // Supplier
                    2: FixedColumnWidth(130), // Invoice No
                    3: FixedColumnWidth(100), // Items
                    4: FixedColumnWidth(120), // Total Value
                    5: FixedColumnWidth(160), // Received By
                    6: FixedColumnWidth(110), // Date
                    7: FixedColumnWidth(120), // Status
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.surface),
                      children: [
                        _buildHeaderCell('GRN NO.'),
                        _buildHeaderCell('SUPPLIER'),
                        _buildHeaderCell('INVOICE NO.'),
                        _buildHeaderCell('ITEMS'),
                        _buildHeaderCell('TOTAL VALUE'),
                        _buildHeaderCell('RECEIVED BY'),
                        _buildHeaderCell('DATE'),
                        _buildHeaderCell('STATUS'),
                      ],
                    ),
                    ...grnLogs.map((item) {
                      final isVerified = item.status == 'verified';
                      return TableRow(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.border),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Text(
                              item.grnNo,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell(item.supplier),
                          _buildTextCell(item.invoice),
                          _buildTextCell('${item.items}'),
                          _buildTextCell(item.value),
                          _buildTextCell(item.receivedBy),
                          _buildTextCell(item.date),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isVerified
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : AppColors.secondaryAccent.withValues(
                                        alpha: 0.1,
                                      ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item.status.toUpperCase(),
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isVerified
                                      ? AppColors.success
                                      : AppColors.secondaryAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildTextCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(text, style: AppTextStyles.bodyMedium),
    );
  }
}
