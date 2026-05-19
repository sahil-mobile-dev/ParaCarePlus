import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabInventoryTab extends StatefulWidget {
  const LabInventoryTab({super.key});

  @override
  State<LabInventoryTab> createState() => _LabInventoryTabState();
}

class _LabInventoryTabState extends State<LabInventoryTab> {
  String _searchQuery = '';
  final List<Map<String, dynamic>> _reagents = [
    {
      'name': 'EDTA Blood Tubes (purple)',
      'category': 'Consumables',
      'qty': '850 units',
      'expiry': '12-08-2027',
      'status': 'Good',
    },
    {
      'name': 'Glucose Assay Reagent Kit',
      'category': 'Reagents',
      'qty': '4 packs',
      'expiry': '22-06-2026',
      'status': 'Low Stock',
    },
    {
      'name': 'CBC Diluent Fluid 20L',
      'category': 'Chemicals',
      'qty': '2 canisters',
      'expiry': '15-11-2026',
      'status': 'Good',
    },
    {
      'name': 'Pregnancy Rapid Test Strips',
      'category': 'Consumables',
      'qty': '10 packs',
      'expiry': '01-09-2026',
      'status': 'Low Stock',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _reagents.where((item) {
      final q = _searchQuery.toLowerCase();
      return item['name'].toString().toLowerCase().contains(q) ||
          item['category'].toString().toLowerCase().contains(q);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter row
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppColors.secondaryText,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: AppTextStyles.bodyMedium,
                        decoration: const InputDecoration(
                          hintText:
                              'Search reagents, consumables, test kits...',
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
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton.icon(
              onPressed: _showUpdateReagentsDialog,
              icon: const Icon(Icons.inventory_2_rounded, size: 16),
              label: const Text('Update Reagents'),
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
        const SizedBox(height: AppSpacing.lg),

        // Registry Table
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
                  'Diagnostic Supply & Chemical Registry',
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
                    0: FixedColumnWidth(240), // Item Name
                    1: FixedColumnWidth(140), // Category
                    2: FixedColumnWidth(140), // Stock Vol / Qty
                    3: FixedColumnWidth(130), // Expiry
                    4: FixedColumnWidth(130), // Status
                    5: FixedColumnWidth(110), // Actions
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.surface),
                      children: [
                        _buildHeaderCell('ITEM NAME'),
                        _buildHeaderCell('CATEGORY'),
                        _buildHeaderCell('STOCK VOL / QTY'),
                        _buildHeaderCell('EXPIRY'),
                        _buildHeaderCell('STATUS'),
                        _buildHeaderCell('ACTIONS'),
                      ],
                    ),
                    ...filtered.map((item) {
                      final status = item['status'] as String;
                      final isLow = status == 'Low Stock';
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
                              item['name'] as String,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell(item['category'] as String),
                          _buildTextCell(item['qty'] as String),
                          _buildTextCell(item['expiry'] as String),
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
                                status,
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
                                      'Edit supply details for ${item['name']}',
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

  void _showUpdateReagentsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Update Supplies Registry',
            style: AppTextStyles.titleMedium,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField('Item Supply Name'),
                const SizedBox(height: 12),
                _buildDialogField('Current Quantity Count'),
                const SizedBox(height: 12),
                _buildDialogField('Manufacturer / Batch'),
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
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.success,
                    content: Text('Reagents stock updated successfully!'),
                  ),
                );
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

  Widget _buildDialogField(String label) {
    return TextField(
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
