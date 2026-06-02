import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class ExpiryTab extends ConsumerWidget {
  const ExpiryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);

    final urgentAlerts = state.expiryAlerts.where((e) => e.daysLeft <= 10).toList();
    final regularAlerts = state.expiryAlerts.where((e) => e.daysLeft > 10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Critical Expiry Alerts',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (urgentAlerts.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text('No critical near-expiry items found.', style: TextStyle(color: AppColors.secondaryText)),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: urgentAlerts.length,
            itemBuilder: (context, index) {
              final alert = urgentAlerts[index];
              return Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          alert.item,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryText,
                          ),
                        ),
                        Text(
                          'Batch: ${alert.batch} | Qty: ${alert.qty} | Expires: ${alert.expiryDate}',
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                    Text(
                      '${alert.daysLeft} days left',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Expiry Register',
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
                DataColumn(label: Text('Item Name')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Batch')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Expiry Date')),
                DataColumn(label: Text('Days Left')),
                DataColumn(label: Text('Actions')),
              ],
              rows: state.expiryAlerts.map((alert) {
                final isUrgent = alert.daysLeft <= 10;
                return DataRow(
                  cells: [
                    DataCell(Text(alert.item, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(alert.category)),
                    DataCell(Text(alert.batch)),
                    DataCell(Text('${alert.qty}')),
                    DataCell(Text(alert.expiryDate)),
                    DataCell(
                      Text(
                        '${alert.daysLeft} days',
                        style: TextStyle(
                          color: isUrgent ? AppColors.error : AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.warning_amber_rounded, color: AppColors.secondaryAccent, size: 18),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Alert notification sent for ${alert.item}')),
                              );
                            },
                            tooltip: 'Send Alert',
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 18),
                            onPressed: () {
                              notifier.removeExpiryAlert(alert.item, alert.batch);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${alert.item} removed from inventory (marked for disposal)')),
                              );
                            },
                            tooltip: 'Mark for Disposal',
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
