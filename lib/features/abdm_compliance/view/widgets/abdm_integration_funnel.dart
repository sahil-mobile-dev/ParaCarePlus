import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/abdm_compliance/view_model/abdm_compliance_view_model.dart';

class AbdmIntegrationFunnel extends ConsumerWidget {
  const AbdmIntegrationFunnel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(abdmComplianceProvider);

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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Digital Health Record Journey — ABHA Creation → Health Locker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Funnel showing adoption at each ABDM integration stage across all Uttarakhand facilities',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(state.journeySteps.length, (idx) {
                final step = state.journeySteps[idx];
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 140, child: _buildStepItem(step)),
                    if (idx < state.journeySteps.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Color(0xFF00B4D8),
                          size: 16,
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(dynamic step) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF132640),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: (step.color as Color).withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: (step.color as Color).withValues(alpha: 0.3),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              step.icon as String,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.label as String,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            step.count as String,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            step.pct as String,
            style: TextStyle(
              color: step.color as Color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
