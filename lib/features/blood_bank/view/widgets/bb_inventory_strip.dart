import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/model/blood_bank_model.dart';

class BbInventoryStrip extends StatelessWidget {
  const BbInventoryStrip({required this.groupsStock, super.key});
  final List<BloodGroupStock> groupsStock;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 1000
            ? 8
            : (constraints.maxWidth > 650 ? 4 : 2);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.15,
          ),
          itemCount: groupsStock.length,
          itemBuilder: (context, index) {
            final b = groupsStock[index];
            
            // Calculate status colors & fill percentages
            Color statusColor = AppColors.success;
            String statusText = '✓ Adequate';
            var bgBorder = AppColors.border.withValues(alpha: 0.3);

            if (b.status == 'critical') {
              statusColor = const Color(0xFFC62828);
              statusText = '🚨 Critical Low';
              bgBorder = const Color(0xFFC62828).withValues(alpha: 0.4);
            } else if (b.status == 'low') {
              statusColor = const Color(0xFFE65100);
              statusText = '↓ Low Stock';
              bgBorder = const Color(0xFFE65100).withValues(alpha: 0.4);
            }

            final double fillPct = (b.units / (b.minRequired * 1.8)).clamp(0.0, 1.0);

            return Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: bgBorder, width: 1.2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    b.group,
                    style: TextStyle(
                      color: const Color(0xFFC62828),
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  Text(
                    '${b.units} Units',
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 8.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Progress Bar
                  Container(
                    height: 5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.border.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: fillPct,
                        child: Container(
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
