import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class MchFunnelCharts extends StatelessWidget {
  const MchFunnelCharts({super.key});

  @override
  Widget build(BuildContext context) {
    final ancFunnel = [
      {'name': 'ANC Registration', 'val': 100},
      {'name': '1st ANC Visit', 'val': 88},
      {'name': '1st Trimester', 'val': 76},
      {'name': '4+ ANC Visits', 'val': 72},
      {'name': 'TT Vaccinated', 'val': 64},
      {'name': 'Inst. Delivery', 'val': 94},
      {'name': 'PNC Within 48h', 'val': 88},
    ];

    final childFunnel = [
      {'name': 'Live Births', 'val': 100},
      {'name': 'Birth Registered', 'val': 96},
      {'name': 'BCG Given', 'val': 94},
      {'name': 'EBF 6 Months', 'val': 92},
      {'name': 'DPT3 Complete', 'val': 89},
      {'name': 'Vit-A Supplement', 'val': 82},
      {'name': 'Full Immunised', 'val': 68},
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 900;
        final content = [
          // ANC Funnel
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ANC CARE CASCADE — FUNNEL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ancFunnel.map((item) {
                        final val = item['val'] as int;
                        final name = item['name'] as String;

                        return Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                name,
                                style: const TextStyle(color: Colors.white70, fontSize: 10),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Center(
                                child: FractionallySizedBox(
                                  widthFactor: val / 100,
                                  child: Container(
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF72585).withValues(alpha: 0.15 + (val / 100) * 0.75),
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: const Color(0xFFF72585).withValues(alpha: 0.3)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$val%',
                                      style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isWide) const SizedBox(width: 14) else const SizedBox(height: 14),
          // Child Funnel
          Expanded(
            flex: isWide ? 1 : 0,
            child: Container(
              height: 300,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border.withValues(alpha: 0.4)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CHILD HEALTH CASCADE — FUNNEL',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: AppColors.secondaryText,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: childFunnel.map((item) {
                        final val = item['val'] as int;
                        final name = item['name'] as String;

                        return Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                name,
                                style: const TextStyle(color: Colors.white70, fontSize: 10),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Center(
                                child: FractionallySizedBox(
                                  widthFactor: val / 100,
                                  child: Container(
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight.withValues(alpha: 0.15 + (val / 100) * 0.75),
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: AppColors.primaryLight.withValues(alpha: 0.3)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '$val%',
                                      style: const TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];

        return isWide
            ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: content)
            : Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: content);
      },
    );
  }
}
