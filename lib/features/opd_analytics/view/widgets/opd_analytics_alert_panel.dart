import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/opd_analytics/model/opd_analytics_model.dart';
import 'package:paracareplus/features/opd_analytics/view_model/opd_analytics_view_model.dart';

class OpdAnalyticsAlertPanel extends ConsumerWidget {
  const OpdAnalyticsAlertPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(opdAnalyticsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildPanel(
                      title: 'Critical OPD Alerts',
                      titleColor: AppColors.error,
                      icon: Icons.cancel,
                      alerts: state.criticalAlerts,
                      dotColor: AppColors.error,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _buildPanel(
                      title: 'Watch & Advisory Alerts',
                      titleColor: AppColors.secondaryAccent,
                      icon: Icons.warning,
                      alerts: state.watchAlerts,
                      dotColor: AppColors.secondaryAccent,
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _buildPanel(
                    title: 'Critical OPD Alerts',
                    titleColor: AppColors.error,
                    icon: Icons.cancel,
                    alerts: state.criticalAlerts,
                    dotColor: AppColors.error,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildPanel(
                    title: 'Watch & Advisory Alerts',
                    titleColor: AppColors.secondaryAccent,
                    icon: Icons.warning,
                    alerts: state.watchAlerts,
                    dotColor: AppColors.secondaryAccent,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildPanel({
    required String title,
    required Color titleColor,
    required IconData icon,
    required List<OpdOperationalAlert> alerts,
    required Color dotColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: titleColor, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: alerts.length,
            separatorBuilder: (context, idx) =>
                const Divider(color: Color(0x0AFFFFFF), height: 1),
            itemBuilder: (context, idx) {
              final alert = alerts[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4, right: 10),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            alert.msg,
                            style: const TextStyle(
                              color: AppColors.primaryText,
                              fontSize: 11,
                              height: 1.4,
                              fontFamily: AppTextStyles.fontFamily,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 10,
                                color: AppColors.secondaryText,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                alert.time,
                                style: const TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 9.5,
                                  fontFamily: AppTextStyles.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
