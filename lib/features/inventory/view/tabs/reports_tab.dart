import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ReportsTab extends ConsumerWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stores = [
      {'store': 'Central Store', 'items': 485, 'value': '₹12.4L', 'low': 8, 'expiring': 3},
      {'store': 'Pharmacy', 'items': 620, 'value': '₹18.2L', 'low': 12, 'expiring': 8},
      {'store': 'Lab Store', 'items': 210, 'value': '₹6.8L', 'low': 6, 'expiring': 4},
      {'store': 'Surgical Store', 'items': 380, 'value': '₹4.2L', 'low': 8, 'expiring': 3},
      {'store': 'Linen Room', 'items': 147, 'value': '₹0.4L', 'low': 0, 'expiring': 0},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inventory Reports & Analysis',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Store-wise Summary',
          style: AppTextStyles.titleSmall.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.border),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(AppColors.surface.withOpacity(0.5)),
              columns: const [
                DataColumn(label: Text('Store Name')),
                DataColumn(label: Text('Total Items')),
                DataColumn(label: Text('Stock Value')),
                DataColumn(label: Text('Low Stock Alerts')),
                DataColumn(label: Text('Expiring Items')),
              ],
              rows: stores.map((s) {
                final lowVal = s['low'] as int;
                final expVal = s['expiring'] as int;
                return DataRow(
                  cells: [
                    DataCell(Text(s['store'] as String, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text('${s['items']} items')),
                    DataCell(Text(s['value'] as String)),
                    DataCell(
                      Text(
                        '$lowVal',
                        style: TextStyle(
                          color: lowVal > 0 ? AppColors.secondaryAccent : AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        '$expVal',
                        style: TextStyle(
                          color: expVal > 0 ? AppColors.error : AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        _buildQuickMetricsSection(),
      ],
    );
  }

  Widget _buildQuickMetricsSection() {
    final metrics = [
      {'label': 'Average Monthly Spend', 'val': '₹8.45 Lakhs', 'trend': '+4.2%'},
      {'label': 'Inventory Turnover Ratio', 'val': '12.4x', 'trend': 'Optimal'},
      {'label': 'Lead Time (PO to Receipt)', 'val': '8.2 Days', 'trend': '-1.1 Days'},
      {'label': 'Service Level Rate', 'val': '98.7%', 'trend': 'Excellent'},
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth > 800 ? 4 : 2;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: metrics.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
        ),
        itemBuilder: (context, index) {
          final m = metrics[index];
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(m['label']!, style: AppTextStyles.labelMedium.copyWith(color: AppColors.secondaryText)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      m['val']!,
                      style: AppTextStyles.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      m['trend']!,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: m['trend']!.startsWith('-') || m['trend']! == 'Optimal' || m['trend']! == 'Excellent'
                            ? AppColors.success
                            : AppColors.secondaryAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
