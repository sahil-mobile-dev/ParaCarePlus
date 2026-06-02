import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/model/inventory_model.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class AssetsTab extends ConsumerWidget {
  const AssetsTab({super.key});

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
              'Asset Management & Maintenance',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showAddAssetDialog(context, notifier),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add Asset'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        _buildCategorySummaryGrid(),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Asset Register',
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
                DataColumn(label: Text('Asset ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Purchase Date')),
                DataColumn(label: Text('AMC Expiry')),
                DataColumn(label: Text('Status')),
              ],
              rows: state.assets.map((asset) {
                Color statusColor = AppColors.success;
                if (asset.status == 'AMC Expired') {
                  statusColor = AppColors.error;
                } else if (asset.status == 'AMC Expiring') {
                  statusColor = AppColors.secondaryAccent;
                }

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        asset.assetId,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(asset.name)),
                    DataCell(Text(asset.category)),
                    DataCell(Text(asset.location)),
                    DataCell(Text(asset.purchaseDate)),
                    DataCell(
                      Text(
                        asset.amcExpiry,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
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
                          asset.status,
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

  Widget _buildCategorySummaryGrid() {
    final categories = [
      {'name': 'Medical Equipment', 'icon': Icons.healing, 'count': 24, 'color': AppColors.primary},
      {'name': 'Lab Equipment', 'icon': Icons.biotech, 'count': 18, 'color': AppColors.primaryLight},
      {'name': 'Radiology', 'icon': Icons.scanner, 'count': 8, 'color': AppColors.success},
      {'name': 'IT Assets', 'icon': Icons.computer, 'count': 42, 'color': AppColors.secondaryText},
    ];

    return LayoutBuilder(builder: (context, constraints) {
      final columns = constraints.maxWidth > 800 ? 4 : 2;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.2,
        ),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 28),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        cat['name'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.labelMedium.copyWith(color: AppColors.secondaryText),
                      ),
                      Text(
                        '${cat['count']} assets',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  void _showAddAssetDialog(BuildContext context, InventoryNotifier notifier) {
    final nameCtrl = TextEditingController();
    final locationCtrl = TextEditingController();
    String category = 'Medical Equipment';
    String expiry = 'Dec 2026';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Add Biomedical Asset'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Asset Name (e.g. ECG Monitor)'),
              ),
              DropdownButtonFormField<String>(
                value: category,
                dropdownColor: AppColors.surface,
                items: ['Medical Equipment', 'Lab Equipment', 'Radiology', 'IT Assets', 'Vehicles/Fleet']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => category = v ?? 'Medical Equipment',
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: locationCtrl,
                decoration: const InputDecoration(labelText: 'Operating Location (e.g. ICU Room 3)'),
              ),
              DropdownButtonFormField<String>(
                value: expiry,
                dropdownColor: AppColors.surface,
                items: ['Dec 2026', 'Mar 2027', 'Jun 2027', 'Dec 2027']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => expiry = v ?? 'Dec 2026',
                decoration: const InputDecoration(labelText: 'AMC/Warranty Expiry'),
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
                final newAsset = AssetItem(
                  assetId: 'AST-0${notifier.state.assets.length + 1}',
                  name: nameCtrl.text.isEmpty ? 'Ventilator Monitor' : nameCtrl.text,
                  category: category,
                  location: locationCtrl.text.isEmpty ? 'General Ward' : locationCtrl.text,
                  purchaseDate: 'Jun 2026',
                  amcExpiry: expiry,
                  status: 'Active',
                );
                notifier.addAsset(newAsset);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Asset Registered Successfully')),
                );
              },
              child: const Text('Save Asset'),
            ),
          ],
        );
      },
    );
  }
}
