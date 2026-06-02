import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/inventory/model/inventory_model.dart';
import 'package:paracareplus/features/inventory/view_model/inventory_view_model.dart';

class IndentTab extends ConsumerWidget {
  const IndentTab({super.key});

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
              'Department Indents',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _showNewIndentDialog(context, notifier),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
              ),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Indent'),
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
                DataColumn(label: Text('Indent No')),
                DataColumn(label: Text('Department')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Items Count')),
                DataColumn(label: Text('Requested By')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: state.indents.map((indent) {
                Color statusColor = AppColors.secondaryAccent;
                if (indent.status == 'Approved') {
                  statusColor = AppColors.primary;
                } else if (indent.status == 'Issued') {
                  statusColor = AppColors.success;
                } else if (indent.status == 'Rejected') {
                  statusColor = AppColors.error;
                }

                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        indent.indentNo,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(indent.dept)),
                    DataCell(Text(indent.date)),
                    DataCell(Text('${indent.itemsCount} items')),
                    DataCell(Text(indent.requestedBy)),
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
                          indent.status,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        children: [
                          if (indent.status == 'Pending') ...[
                            IconButton(
                              icon: const Icon(Icons.check, color: AppColors.success, size: 18),
                              onPressed: () {
                                notifier.approveIndent(indent.indentNo);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Indent ${indent.indentNo} Approved')),
                                );
                              },
                              tooltip: 'Approve',
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: AppColors.error, size: 18),
                              onPressed: () {
                                notifier.rejectIndent(indent.indentNo);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Indent ${indent.indentNo} Rejected')),
                                );
                              },
                              tooltip: 'Reject',
                            ),
                          ],
                          if (indent.status == 'Approved') ...[
                            IconButton(
                              icon: const Icon(Icons.local_shipping, color: AppColors.primary, size: 18),
                              onPressed: () {
                                notifier.issueIndent(indent.indentNo);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Indent ${indent.indentNo} Issued')),
                                );
                              },
                              tooltip: 'Issue Stock',
                            ),
                          ],
                          if (indent.status == 'Issued' || indent.status == 'Rejected') ...[
                            const Text('—', style: TextStyle(color: AppColors.secondaryText)),
                          ],
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

  void _showNewIndentDialog(BuildContext context, InventoryNotifier notifier) {
    final staffCtrl = TextEditingController();
    final itemsCountCtrl = TextEditingController();
    String department = 'ICU';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('Create New Indent Request'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: department,
                dropdownColor: AppColors.surface,
                items: ['Medicine', 'Surgery', 'ICU', 'OT', 'Lab', 'Pharmacy']
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (v) => department = v ?? 'ICU',
                decoration: const InputDecoration(labelText: 'Department'),
              ),
              TextField(
                controller: staffCtrl,
                decoration: const InputDecoration(labelText: 'Requested By (Staff Name)'),
              ),
              TextField(
                controller: itemsCountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Number of Items'),
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
                final count = int.tryParse(itemsCountCtrl.text) ?? 1;
                final newIndent = IndentItem(
                  indentNo: 'IND-${100 + notifier.state.indents.length + 1}',
                  dept: department,
                  date: '03/06',
                  itemsCount: count,
                  requestedBy: staffCtrl.text.isEmpty ? 'Staff Nurse' : staffCtrl.text,
                  status: 'Pending',
                );
                notifier.addIndent(newIndent);
                Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Indent Request Submitted')),
                );
              },
              child: const Text('Submit Indent'),
            ),
          ],
        );
      },
    );
  }
}
