import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view/widgets/bb_modals.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';

class BbInventoryTab extends ConsumerStatefulWidget {
  const BbInventoryTab({super.key});

  @override
  ConsumerState<BbInventoryTab> createState() => _BbInventoryTabState();
}

class _BbInventoryTabState extends ConsumerState<BbInventoryTab> {
  String _groupFilter = 'All Groups';
  String _compFilter = 'All Components';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bloodBankProvider);

    // Filter Stock Items
    final filtered = state.stock.where((s) {
      final matchesGroup = _groupFilter == 'All Groups' || s.group == _groupFilter;
      final matchesComp = _compFilter == 'All Components' || s.component == _compFilter;
      return matchesGroup && matchesComp;
    }).toList();

    // Critical Alerts
    final alerts = state.groupsStock.where((g) => g.status != 'ok').toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final leftWidth = constraints.maxWidth > 950
            ? constraints.maxWidth * 0.68
            : constraints.maxWidth;

        final isWide = constraints.maxWidth > 950;

        final leftSide = Container(
          width: leftWidth,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & Filters
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '🩸 Blood Unit Stock Register',
                      style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        _buildFilterDropdown(
                          value: _groupFilter,
                          items: const ['All Groups', 'A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
                          onChanged: (val) {
                            if (val != null) setState(() => _groupFilter = val);
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildFilterDropdown(
                          value: _compFilter,
                          items: const ['All Components', 'Whole Blood', 'PCV/RCC', 'Platelets', 'FFP', 'Cryo'],
                          onChanged: (val) {
                            if (val != null) setState(() => _compFilter = val);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Data table
              ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.border.withValues(alpha: 0.15)),
                    columns: const [
                      DataColumn(label: Text('Bag ID', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Group', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Component', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Volume', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Collected', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Expiry', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Days Left', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filtered.map((s) {
                      final isReserved = s.status == 'Reserved';
                      final isLow = s.daysLeft <= 10;

                      return DataRow(
                        cells: [
                          DataCell(Text(s.bagId, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'))),
                          DataCell(Text(s.group, style: const TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 15))),
                          DataCell(Text(s.component)),
                          DataCell(Text(s.volume)),
                          DataCell(Text(s.collected, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText))),
                          DataCell(Text(s.expiry, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          DataCell(
                            Text(
                              '${s.daysLeft} days',
                              style: TextStyle(
                                color: isLow ? const Color(0xFFC62828) : AppColors.success,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: (isReserved ? const Color(0xFFE65100) : AppColors.success).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                s.status.toUpperCase(),
                                style: TextStyle(
                                  color: isReserved ? const Color(0xFFE65100) : AppColors.success,
                                  fontSize: 9,
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
          ),
        );

        final rightSide = Column(
          children: [
            // Component Wise horizontal bar breakdown card
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🩸 COMPONENT STOCK RATIO',
                    style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildComponentLine('Whole Blood', 45, const Color(0xFFC62828)),
                  _buildComponentLine('PCV/RCC', 38, const Color(0xFF880E4F)),
                  _buildComponentLine('Platelets', 22, const Color(0xFFE65100)),
                  _buildComponentLine('FFP', 18, const Color(0xFF1565C0)),
                  _buildComponentLine('Cryoprecipitate', 8, const Color(0xFF6A1B9A)),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            // Critical Alerts card
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠️ DEPT STOCK ALERTS',
                    style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.secondaryText),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (alerts.isEmpty)
                    const Text('No stock alerts. All inventories adequate.', style: TextStyle(color: AppColors.success, fontSize: 12))
                  else
                    ...alerts.map((a) {
                      final isCrit = a.status == 'critical';
                      final col = isCrit ? const Color(0xFFC62828) : const Color(0xFFE65100);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: col.withValues(alpha: 0.1),
                          border: Border.all(color: col.withValues(alpha: 0.25)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${a.group} Stock ${a.status.toUpperCase()}', style: TextStyle(color: col, fontWeight: FontWeight.bold, fontSize: 12)),
                                Text('Available: ${a.units} units (Min: ${a.minRequired})', style: const TextStyle(fontSize: 10, color: AppColors.secondaryText)),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: col,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                minimumSize: const Size(0, 28),
                              ),
                              onPressed: () => BbModals.showBloodRequest(context, ref),
                              child: const Text('PROCURE', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              leftSide,
              const SizedBox(width: AppSpacing.md),
              Expanded(child: rightSide),
            ],
          );
        } else {
          return Column(
            children: [
              leftSide,
              const SizedBox(height: AppSpacing.md),
              rightSide,
            ],
          );
        }
      },
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.card,
          style: const TextStyle(fontSize: 11, color: AppColors.primaryText),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildComponentLine(String label, int count, Color color) {
    final pct = (count / 45.0).clamp(0.0, 1.0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Text('$count Units', style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 5,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.border.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: pct,
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
