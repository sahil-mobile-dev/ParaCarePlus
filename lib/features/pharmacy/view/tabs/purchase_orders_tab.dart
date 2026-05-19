import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class PurchaseOrdersTab extends StatefulWidget {
  const PurchaseOrdersTab({super.key});

  @override
  State<PurchaseOrdersTab> createState() => _PurchaseOrdersTabState();
}

class _PurchaseOrdersTabState extends State<PurchaseOrdersTab> {
  final List<Map<String, dynamic>> _purchaseOrders = [
    {
      'poNo': 'PO-2024-009',
      'vendor': 'Cipla Distribution',
      'items': 12,
      'estDelivery': '22-05-2026',
      'status': 'SENT',
    },
    {
      'poNo': 'PO-2024-010',
      'vendor': 'Sun Pharma Logistics',
      'items': 5,
      'estDelivery': '25-05-2026',
      'status': 'PENDING APPROVAL',
    },
    {
      'poNo': 'PO-2024-011',
      'vendor': "Dr. Reddy's Labs",
      'items': 8,
      'estDelivery': '28-05-2026',
      'status': 'SENT',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Purchase Orders',
              style: AppTextStyles.labelLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _showDraftPoDialog,
              icon: const Icon(Icons.note_add_rounded, size: 16),
              label: const Text('Generate PO'),
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

        // PO Table Card
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
                  'Procurement Tracking Registry',
                  style: AppTextStyles.labelMedium.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(160), // PO No
                    1: FixedColumnWidth(220), // Vendor
                    2: FixedColumnWidth(140), // Items Ordered
                    3: FixedColumnWidth(150), // Est. Delivery
                    4: FixedColumnWidth(180), // Status
                    5: FixedColumnWidth(120), // Action
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.surface),
                      children: [
                        _buildHeaderCell('PO NUMBER'),
                        _buildHeaderCell('VENDOR'),
                        _buildHeaderCell('ITEMS ORDERED'),
                        _buildHeaderCell('EST. DELIVERY'),
                        _buildHeaderCell('STATUS'),
                        _buildHeaderCell('ACTION'),
                      ],
                    ),
                    ..._purchaseOrders.map((item) {
                      final isSent = item['status'] == 'SENT';
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
                              item['poNo'] as String,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell(item['vendor'] as String),
                          _buildTextCell('${item['items']} Line Items'),
                          _buildTextCell(item['estDelivery'] as String),
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
                                color: isSent
                                    ? AppColors.success.withValues(alpha: 0.1)
                                    : AppColors.secondaryAccent.withValues(
                                        alpha: 0.1,
                                      ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item['status'] as String,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: isSent
                                      ? AppColors.success
                                      : AppColors.secondaryAccent,
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
                            child: TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Viewing PO Details for ${item['poNo']}',
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                'View Detail',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
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

  void _showDraftPoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: const Text(
            'Draft Purchase Order',
            style: AppTextStyles.titleMedium,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField('Vendor Name (e.g. Cipla)'),
                const SizedBox(height: 12),
                _buildDialogField('Line Items Requested'),
                const SizedBox(height: 12),
                _buildDialogField('Urgency Note / Comments'),
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
                    content: Text('New Purchase Order Drafted & Saved!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: const Text('Save Draft'),
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
