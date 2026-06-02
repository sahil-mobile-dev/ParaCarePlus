import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/model/inventory_model.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class GrnTab extends ConsumerWidget {
  const GrnTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Goods Receipt Notes (GRN)',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showNewGrnDialog(context, notifier),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              icon: const Icon(Icons.local_shipping, size: 16),
              label: const Text('New GRN'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
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
                DataColumn(label: Text('GRN No')),
                DataColumn(label: Text('PO Ref')),
                DataColumn(label: Text('Vendor')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Items Received')),
                DataColumn(label: Text('Total Value')),
                DataColumn(label: Text('Status')),
              ],
              rows: state.grnList.map((grn) {
                final isCompleted = grn.status == 'Completed';
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        grn.grnNo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(grn.poRef)),
                    DataCell(Text(grn.vendor)),
                    DataCell(Text(grn.date)),
                    DataCell(Text('${grn.itemsCount} items')),
                    DataCell(Text(grn.value)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? AppColors.success.withOpacity(0.2)
                              : AppColors.secondaryAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          grn.status,
                          style: TextStyle(
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.secondaryAccent,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  void _showNewGrnDialog(BuildContext context, InventoryNotifier notifier) {
    final poCtrl = TextEditingController();
    final vendorCtrl = TextEditingController();
    final itemsCtrl = TextEditingController();
    final valCtrl = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Add Goods Receipt Note (GRN)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: poCtrl,
                decoration: const InputDecoration(labelText: 'PO Reference (e.g. PO-2025-012)'),
              ),
              TextField(
                controller: vendorCtrl,
                decoration: const InputDecoration(labelText: 'Vendor Name'),
              ),
              TextField(
                controller: itemsCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of Items Received'),
              ),
              TextField(
                controller: valCtrl,
                decoration: const InputDecoration(labelText: 'Receipt Value (e.g. ₹1,50,000)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final count = int.tryParse(itemsCtrl.text) ?? 5;
                final newGrn = GrnItem(
                  grnNo: 'GRN-${001 + notifier.state.grnList.length + 1}',
                  poRef: poCtrl.text.isEmpty ? 'PO-2025-012' : poCtrl.text,
                  vendor: vendorCtrl.text.isEmpty ? 'Cipla Ltd.' : vendorCtrl.text,
                  date: '03/06',
                  itemsCount: count,
                  value: valCtrl.text.isEmpty ? '₹50,000' : valCtrl.text,
                  status: 'Completed',
                );
                notifier.addGrn(newGrn);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('GRN Created Successfully')),
                );
              },
              child: const Text('Save GRN'),
            ),
          ],
        );
      },
    );
  }
}
