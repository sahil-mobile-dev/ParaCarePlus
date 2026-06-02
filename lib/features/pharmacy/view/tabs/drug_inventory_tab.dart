import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/pharmacy/view_model/pharmacy_view_model.dart';

class DrugInventoryTab extends ConsumerStatefulWidget {
  const DrugInventoryTab({super.key});

  @override
  ConsumerState<DrugInventoryTab> createState() => _DrugInventoryTabState();
}

class _DrugInventoryTabState extends ConsumerState<DrugInventoryTab> {
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Simulate HIMS server load delay as seen in reference designs
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 350,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading inventory data...',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      );
    }

    final inventory = ref.watch(pharmacyProvider.select((s) => s.inventory));

    final filteredList = inventory.where((item) {
      final query = _searchQuery.toLowerCase();
      return item.name.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.batch.toLowerCase().contains(query);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Filter & Action Bar
        Column(
          children: [
            TextField(
              style: AppTextStyles.bodyMedium,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded, size: 20),
                hintText: 'Search drug name, batch, category...',
                hintStyle: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
            const SizedBox(height: AppSpacing.lg),

            Row(
              children: [
                _buildDropDownFilter('All Categories'),
                const SizedBox(width: 10),
                _buildDropDownFilter('All Stock Levels'),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: _showAddStockDialog,
                  icon: const Icon(Icons.add_rounded, size: 16),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: AppTextStyles.labelSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Inventory Table
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
                child: Text(
                  'Drug Master Stock Registry',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(200), // Drug name
                    1: FixedColumnWidth(130), // Category
                    2: FixedColumnWidth(100), // Form
                    3: FixedColumnWidth(100), // Batch
                    4: FixedColumnWidth(110), // Stock Qty
                    5: FixedColumnWidth(110), // Min Level
                    6: FixedColumnWidth(100), // MRP
                    7: FixedColumnWidth(130), // Status
                    8: FixedColumnWidth(100), // Actions
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.surface),
                      children: [
                        _buildHeaderCell('DRUG NAME'),
                        _buildHeaderCell('CATEGORY'),
                        _buildHeaderCell('FORM'),
                        _buildHeaderCell('BATCH'),
                        _buildHeaderCell('STOCK QTY'),
                        _buildHeaderCell('MIN LEVEL'),
                        _buildHeaderCell('MRP (₹)'),
                        _buildHeaderCell('STATUS'),
                        _buildHeaderCell('ACTION'),
                      ],
                    ),
                    ...filteredList.map((item) {
                      final isLow = item.status == 'Reorder Alert';
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
                              item.name,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell(item.category),
                          _buildTextCell(item.form),
                          _buildTextCell(item.batch),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Text(
                              '${item.qty}',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: isLow
                                    ? AppColors.error
                                    : AppColors.primaryText,
                                fontWeight: isLow
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          _buildTextCell('${item.minLevel}'),
                          _buildTextCell('₹${item.mrp}'),
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
                                color: isLow
                                    ? AppColors.error.withValues(alpha: 0.1)
                                    : AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item.status,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isLow
                                      ? AppColors.error
                                      : AppColors.success,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 18,
                                color: AppColors.primary,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Edit ${item.name} triggered.',
                                    ),
                                  ),
                                );
                              },
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

  Widget _buildDropDownFilter(String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.secondaryText,
            size: 16,
          ),
        ],
      ),
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

  void _showAddStockDialog() {
    final nameController = TextEditingController();
    final batchController = TextEditingController();
    final qtyController = TextEditingController();
    final mrpController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Add New Stock SKU',
            style: AppTextStyles.titleMedium,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField('Drug Name', nameController),
                const SizedBox(height: 12),
                _buildDialogField('Batch Number', batchController),
                const SizedBox(height: 12),
                _buildDialogField('Quantity', qtyController),
                const SizedBox(height: 12),
                _buildDialogField('MRP (₹)', mrpController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.secondaryText),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final batch = batchController.text.trim();
                final qty = int.tryParse(qtyController.text) ?? 0;
                final mrp = double.tryParse(mrpController.text) ?? 0.0;

                if (name.isNotEmpty && batch.isNotEmpty) {
                  ref.read(pharmacyProvider.notifier).addInventoryItem(
                    name: name,
                    category: 'Analgesic', // default mock category
                    form: 'Tablet',       // default mock form
                    batch: batch,
                    qty: qty,
                    minLevel: 100,         // default minLevel
                    mrp: mrp,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text('Stock SKU added successfully!'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 13,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
