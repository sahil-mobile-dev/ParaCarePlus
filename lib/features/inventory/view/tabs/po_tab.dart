import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/model/inventory_model.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class PoTab extends ConsumerWidget {
  const PoTab({super.key});

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
              'Purchase Orders',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showCreatePoDialog(context, notifier),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Create PO'),
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
                DataColumn(label: Text('PO No')),
                DataColumn(label: Text('Vendor')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Value')),
                DataColumn(label: Text('Delivery By')),
                DataColumn(label: Text('Status')),
              ],
              rows: state.poList.map((po) {
                Color statusColor = AppColors.primary;
                if (po.status == 'Closed') {
                  statusColor = AppColors.success;
                } else if (po.status == 'Overdue') {
                  statusColor = AppColors.error;
                } else if (po.status == 'Partial GRN') {
                  statusColor = AppColors.secondaryAccent;
                }

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        po.poNo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(po.vendor)),
                    DataCell(Text(po.date)),
                    DataCell(Text(po.category)),
                    DataCell(Text(po.value)),
                    DataCell(Text(po.deliveryBy)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          po.status,
                          style: TextStyle(
                            color: statusColor,
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

  void _showCreatePoDialog(BuildContext context, InventoryNotifier notifier) {
    final vendorCtrl = TextEditingController();
    final valueCtrl = TextEditingController();
    String category = 'Medicines';
    String delivery = '15/06';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Create Purchase Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: vendorCtrl,
                decoration: const InputDecoration(labelText: 'Vendor Name'),
              ),
              DropdownButtonFormField<String>(
                value: category,
                dropdownColor: AppColors.surface,
                items: ['Medicines', 'Surgical', 'Equipment', 'Consumables']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => category = v ?? 'Medicines',
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: valueCtrl,
                decoration: const InputDecoration(labelText: 'Total Value (e.g. ₹2,50,000)'),
              ),
              DropdownButtonFormField<String>(
                value: delivery,
                dropdownColor: AppColors.surface,
                items: ['15/06', '20/06', '30/06']
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => delivery = v ?? '15/06',
                decoration: const InputDecoration(labelText: 'Expected Delivery Date'),
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
                final newPo = PurchaseOrderItem(
                  poNo: 'PO-2026-0${12 + notifier.state.poList.length + 1}',
                  vendor: vendorCtrl.text.isEmpty ? 'Cipla Ltd.' : vendorCtrl.text,
                  date: '03/06',
                  category: category,
                  value: valueCtrl.text.isEmpty ? '₹1,00,000' : valueCtrl.text,
                  deliveryBy: delivery,
                  status: 'Open',
                );
                notifier.addPurchaseOrder(newPo);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Purchase Order Created Successfully')),
                );
              },
              child: const Text('Create PO'),
            ),
          ],
        );
      },
    );
  }
}
