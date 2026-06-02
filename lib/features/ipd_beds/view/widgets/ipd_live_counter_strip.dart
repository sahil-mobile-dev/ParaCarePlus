import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';

class IpdLiveCounterStrip extends ConsumerWidget {
  const IpdLiveCounterStrip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ipdBedsProvider);
    final kpi = state.kpiData;

    final counters = [
      {
        'title': 'Beds Occupied',
        'value': kpi.occupiedBeds.toString(),
        'icon': Icons.bed_rounded,
        'color': AppColors.primaryLight,
        'bg': AppColors.primaryLight.withValues(alpha: 0.15),
      },
      {
        'title': 'Beds Available',
        'value': kpi.availableBeds.toString(),
        'icon': Icons.check_circle_outline_rounded,
        'color': AppColors.success,
        'bg': AppColors.success.withValues(alpha: 0.15),
      },
      {
        'title': 'ICU Occupied',
        'value': kpi.icuOccupied.toString(),
        'icon': Icons.heart_broken_outlined,
        'color': const Color(0xFFC77DFF),
        'bg': const Color(0xFFC77DFF).withValues(alpha: 0.15),
      },
      {
        'title': 'ER Patients Now',
        'value': kpi.criticalCasesActive.toString(),
        'icon': Icons.personal_injury_outlined,
        'color': AppColors.error,
        'bg': AppColors.error.withValues(alpha: 0.15),
      },
      {
        'title': 'Ambulances Active',
        'value': state.ambulances.length.toString(),
        'icon': Icons.airport_shuttle_outlined,
        'color': AppColors.secondaryAccent,
        'bg': AppColors.secondaryAccent.withValues(alpha: 0.15),
      },
      {
        'title': 'Discharges Today',
        'value': (kpi.dailyAdmissions - 235).toString(),
        'icon': Icons.autorenew_rounded,
        'color': AppColors.primaryLight,
        'bg': AppColors.primaryLight.withValues(alpha: 0.15),
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 1100
            ? 6
            : (constraints.maxWidth > 768 ? 3 : 2);

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.2,
          ),
          itemCount: counters.length,
          itemBuilder: (context, index) {
            final item = counters[index];
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: item['bg'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['color'] as Color,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['value'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          (item['title'] as String).toUpperCase(),
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
