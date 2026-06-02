import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/model/inventory_model.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class StockTab extends ConsumerStatefulWidget {
  const StockTab({super.key});

  @override
  ConsumerState<StockTab> createState() => _StockTabState();
}

class _StockTabState extends ConsumerState<StockTab> {
  String selectedCategory = '';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);

    final filteredStock = state.stock.where((item) {
      final matchesCategory = selectedCategory.isEmpty ||
          item.category.toLowerCase() == selectedCategory.toLowerCase();
      final matchesSearch =
          item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              item.code.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Stock Register',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                _buildCategoryDropdown(),
                const SizedBox(width: AppSpacing.sm),
                _buildSearchField(),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton.icon(
                  onPressed: () => _showAddItemDialog(context, notifier),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                  icon: const Icon(Icons.add, size: 16),
                  label: const Text('Add Item'),
                ),
              ],
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
                DataColumn(label: Text('Item Code')),
                DataColumn(label: Text('Item Name')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Unit')),
                DataColumn(label: Text('Qty in Hand')),
                DataColumn(label: Text('Reorder Level')),
                DataColumn(label: Text('Unit Cost')),
                DataColumn(label: Text('Value')),
                DataColumn(label: Text('Store')),
                DataColumn(label: Text('Status')),
              ],
              rows: filteredStock.map((item) {
                final isLow = item.qtyInHand <= item.reorderLevel;
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        item.code,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(item.name)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.category,
                          style: const TextStyle(color: AppColors.primaryText),
                        ),
                      ),
                    ),
                    DataCell(Text(item.unit)),
                    DataCell(
                      Text(
                        '${item.qtyInHand}',
                        style: TextStyle(
                          color: isLow
                              ? AppColors.secondaryAccent
                              : AppColors.success,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataCell(Text('${item.reorderLevel}')),
                    DataCell(Text('₹${item.unitCost.toStringAsFixed(2)}')),
                    DataCell(
                      Text(
                        '₹${item.value.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(item.store)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isLow
                              ? AppColors.error.withOpacity(0.2)
                              : AppColors.success.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item.status,
                          style: TextStyle(
                            color: isLow ? AppColors.error : AppColors.success,
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

  Widget _buildCategoryDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          dropdownColor: AppColors.surface,
          items: const [
            DropdownMenuItem(value: '', child: Text('All Categories')),
            DropdownMenuItem(value: 'Medicines', child: Text('Medicines')),
            DropdownMenuItem(value: 'Surgical', child: Text('Surgical')),
            DropdownMenuItem(
              value: 'Reagents/Chemicals',
              child: Text('Reagents/Chemicals'),
            ),
            DropdownMenuItem(value: 'Consumables', child: Text('Consumables')),
            DropdownMenuItem(value: 'Linen', child: Text('Linen')),
          ],
          onChanged: (val) {
            setState(() {
              selectedCategory = val ?? '';
            });
          },
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        onChanged: (val) {
          setState(() {
            searchQuery = val;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search item...',
          prefixIcon: const Icon(Icons.search, size: 16),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          fillColor: AppColors.surface,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.border),
          ),
        ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context, InventoryNotifier notifier) {
    final nameCtrl = TextEditingController();
    final codeCtrl = TextEditingController();
    final costCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final reorderCtrl = TextEditingController();
    String category = 'Medicines';
    String unit = 'Strip';
    String store = 'Pharmacy';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Add New Item'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: 'Item Name'),
                ),
                TextField(
                  controller: codeCtrl,
                  decoration: const InputDecoration(labelText: 'Item Code'),
                ),
                DropdownButtonFormField<String>(
                  value: category,
                  dropdownColor: AppColors.surface,
                  items: ['Medicines', 'Surgical', 'Reagents/Chemicals', 'Consumables', 'Linen']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => category = v ?? 'Medicines',
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                DropdownButtonFormField<String>(
                  value: unit,
                  dropdownColor: AppColors.surface,
                  items: ['Strip', 'Box(100)', 'Box(50)', 'Kit', 'No']
                      .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                      .toList(),
                  onChanged: (v) => unit = v ?? 'Strip',
                  decoration: const InputDecoration(labelText: 'Unit'),
                ),
                TextField(
                  controller: qtyCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Opening Stock'),
                ),
                TextField(
                  controller: reorderCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Reorder Level'),
                ),
                TextField(
                  controller: costCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Unit Cost (₹)'),
                ),
                DropdownButtonFormField<String>(
                  value: store,
                  dropdownColor: AppColors.surface,
                  items: ['Pharmacy', 'Surgical Store', 'Lab Store', 'Central Store', 'Linen Room']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => store = v ?? 'Pharmacy',
                  decoration: const InputDecoration(labelText: 'Store Location'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final qty = int.tryParse(qtyCtrl.text) ?? 0;
                final reorder = int.tryParse(reorderCtrl.text) ?? 0;
                final cost = double.tryParse(costCtrl.text) ?? 0.0;
                final item = InventoryItem(
                  code: codeCtrl.text.isEmpty ? 'MED-GEN' : codeCtrl.text,
                  name: nameCtrl.text.isEmpty ? 'Generic Medicine' : nameCtrl.text,
                  category: category,
                  unit: unit,
                  qtyInHand: qty,
                  reorderLevel: reorder,
                  unitCost: cost,
                  store: store,
                  status: qty <= reorder ? 'Low Stock' : 'In Stock',
                );
                notifier.addInventoryItem(item);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Inventory Item Added Successfully')),
                );
              },
              child: const Text('Save Item'),
            ),
          ],
        );
      },
    );
  }
}
