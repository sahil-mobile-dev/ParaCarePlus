import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/disease_surveillance/model/disease_surveillance_model.dart';

class DiseaseSurveillanceAlertPanel extends StatelessWidget {
  const DiseaseSurveillanceAlertPanel({required this.alerts, super.key});

  final List<SurveillanceAlert> alerts;

  @override
  Widget build(BuildContext context) {
    final criticals = alerts.where((a) => a.severity == 'crit').toList();
    final warnings = alerts.where((a) => a.severity != 'crit').toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final isMobile = w < 760;

        final panels = [
          _buildAlertBox(
            '🔴 Critical Outbreaks & Rapid Response',
            criticals,
            AppColors.error,
          ),
          if (isMobile) const SizedBox(height: AppSpacing.md),
          _buildAlertBox(
            '🟡 Syndromic Watch & Public Health Advisories',
            warnings,
            AppColors.secondaryAccent,
          ),
        ];

        return isMobile
            ? Column(children: panels)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: panels[0]),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: panels[2]),
                ],
              );
      },
    );
  }

  Widget _buildAlertBox(
    String title,
    List<SurveillanceAlert> items,
    Color dotCol,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: dotCol,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.04),
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),
            itemBuilder: (context, index) {
              final a = items[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: dotCol.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a.msg,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            height: 1.4,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 9,
                              color: AppColors.secondaryText,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              a.time,
                              style: const TextStyle(
                                fontSize: 9.5,
                                color: AppColors.secondaryText,
                                fontFamily: AppTextStyles.fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
