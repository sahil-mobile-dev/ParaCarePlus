import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/opd_analytics/view_model/opd_analytics_view_model.dart';

class OpdAnalyticsLiveStrip extends ConsumerWidget {
  const OpdAnalyticsLiveStrip({super.key});

  Color _getColorFromHex(String hex) {
    if (hex == 'FFD166') return AppColors.secondaryAccent;
    if (hex == '00C897') return AppColors.success;
    if (hex == '00B4D8') return AppColors.primaryLight;
    if (hex == '9B5DE5') return Colors.purpleAccent;
    if (hex == '06D6A0') return Colors.tealAccent;
    return Colors.orangeAccent;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opdAnalyticsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.flash_on,
              color: AppColors.secondaryAccent,
              size: 16,
            ),
            const SizedBox(width: 8),
            const Text(
              'LIVE OPD COUNTERS — REAL-TIME RIGHT NOW',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.secondaryAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.secondaryAccent.withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'Auto-refresh 30s',
                style: TextStyle(
                  color: AppColors.secondaryAccent,
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 2,
          children: state.liveCounters.map((counter) {
            final color = _getColorFromHex(counter.colorHex);
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF132640),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    counter.val,
                    style: TextStyle(
                      color: color,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    counter.label.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    counter.sub,
                    style: const TextStyle(
                      color: Colors.white30,
                      fontSize: 8,
                      fontFamily: AppTextStyles.fontFamily,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
