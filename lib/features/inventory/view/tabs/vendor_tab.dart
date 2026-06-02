import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/model/inventory_model.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class VendorTab extends ConsumerWidget {
  const VendorTab({super.key});

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
              'Vendor Directory',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddVendorDialog(context, notifier),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Vendor'),
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
                DataColumn(label: Text('Vendor Code')),
                DataColumn(label: Text('Vendor Name')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('GSTIN')),
                DataColumn(label: Text('Contact')),
                DataColumn(label: Text('Rating')),
                DataColumn(label: Text('Status')),
              ],
              rows: state.vendors.map((vendor) {
                final isActive = vendor.status == 'Active';
                final ratingString = '★' * vendor.rating.floor() + (vendor.rating % 1 > 0 ? '½' : '');

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        vendor.code,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(vendor.name)),
                    DataCell(Text(vendor.category)),
                    DataCell(Text(vendor.gstin)),
                    DataCell(Text(vendor.contact)),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.orange, size: 14),
                          const SizedBox(width: 4),
                          Text('$ratingString (${vendor.rating})'),
                        ],
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.success.withOpacity(0.2)
                              : AppColors.secondaryAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          vendor.status,
                          style: TextStyle(
                            color: isActive ? AppColors.success : AppColors.secondaryAccent,
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

  void _showAddVendorDialog(BuildContext context, InventoryNotifier notifier) {
    final nameCtrl = TextEditingController();
    final catCtrl = TextEditingController();
    final gstCtrl = TextEditingController();
    final contactCtrl = TextEditingController();
    final rateCtrl = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Add Vendor Profile'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Vendor Name'),
              ),
              TextField(
                controller: catCtrl,
                decoration: const InputDecoration(labelText: 'Category (e.g. Pharmaceuticals)'),
              ),
              TextField(
                controller: gstCtrl,
                decoration: const InputDecoration(labelText: 'GSTIN Registration'),
              ),
              TextField(
                controller: contactCtrl,
                decoration: const InputDecoration(labelText: 'Contact Info'),
              ),
              TextField(
                controller: rateCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Initial Rating (1.0 to 5.0)'),
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
                final rating = double.tryParse(rateCtrl.text) ?? 5.0;
                final newVendor = VendorItem(
                  code: 'V-0${notifier.state.vendors.length + 1}',
                  name: nameCtrl.text.isEmpty ? 'New Vendor Ltd.' : nameCtrl.text,
                  category: catCtrl.text.isEmpty ? 'General Supplier' : catCtrl.text,
                  gstin: gstCtrl.text.isEmpty ? 'GSTIN-PENDING' : gstCtrl.text,
                  contact: contactCtrl.text.isEmpty ? 'N/A' : contactCtrl.text,
                  rating: rating,
                  status: 'Active',
                );
                notifier.addVendor(newVendor);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vendor Profile Added')),
                );
              },
              child: const Text('Save Vendor'),
            ),
          ],
        );
      },
    );
  }
}
