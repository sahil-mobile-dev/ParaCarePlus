import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/abdm_compliance/model/abdm_compliance_model.dart';
import 'package:paracareplus/features/abdm_compliance/view_model/abdm_compliance_view_model.dart';

class AbdmAlertPanel extends ConsumerWidget {
  const AbdmAlertPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(abdmComplianceProvider);
    final width = MediaQuery.of(context).size.width;
    final isCompact = width < 760;

    if (isCompact) {
      return Column(
        children: [
          _buildPanel(
            'Critical Alerts',
            state.criticalAlerts,
            AppColors.error,
            Icons.cancel_rounded,
          ),
          const SizedBox(height: 16),
          _buildPanel(
            'Watch Alerts',
            state.watchAlerts,
            AppColors.secondaryAccent,
            Icons.warning_rounded,
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildPanel(
            'Critical Alerts',
            state.criticalAlerts,
            AppColors.error,
            Icons.cancel_rounded,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPanel(
            'Watch Alerts',
            state.watchAlerts,
            AppColors.secondaryAccent,
            Icons.warning_rounded,
          ),
        ),
      ],
    );
  }

  Widget _buildPanel(
    String title,
    List<ComplianceAlert> alerts,
    Color accentColor,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (alerts.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'No active alerts in this category',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: alerts.length,
              separatorBuilder: (context, idx) => Divider(
                color: Colors.white.withValues(alpha: 0.05),
                height: 1,
              ),
              itemBuilder: (context, idx) {
                final alert = alerts[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: accentColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              alert.message,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              alert.time,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9.5,
                              ),
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
