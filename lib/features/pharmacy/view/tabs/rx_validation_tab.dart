import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/pharmacy/model/pharmacy_model.dart';
import 'package:paracareplus/features/pharmacy/view_model/pharmacy_view_model.dart';

class RxValidationTab extends ConsumerStatefulWidget {
  const RxValidationTab({super.key});

  @override
  ConsumerState<RxValidationTab> createState() => _RxValidationTabState();
}

class _RxValidationTabState extends ConsumerState<RxValidationTab> {
  @override
  Widget build(BuildContext context) {
    final validations = ref.watch(pharmacyProvider.select((s) => s.rxValidations));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Clinical Safety Validation Queue',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${validations.length} Pending Validation',
                  style: AppTextStyles.labelSmall.copyWith(
                     color: AppColors.error,
                     fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (validations.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 48,
                    color: AppColors.success,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'All prescriptions validated. Safety checks complete!',
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: validations.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final val = validations[index];
              final categoryColor = val.color;

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    // Warning Header Bar
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: categoryColor.withValues(alpha: 0.08),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        border: const Border(
                          bottom: BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            val.icon,
                            color: categoryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            val.category.toUpperCase(),
                            style: AppTextStyles.labelSmall.copyWith(
                              color: categoryColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'RX No: ${val.rxNo}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Warning Body Details
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      val.patient,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        val.drug,
                                        style: AppTextStyles.labelSmall
                                            .copyWith(
                                              color: AppColors.primaryText,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  val.warning,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(color: AppColors.border, height: 1),
                    // Action Buttons Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildActionBtn(
                            context,
                            'Reject',
                            AppColors.error,
                            () => _handleAction(val, 'Rejected'),
                          ),
                          const SizedBox(width: 8),
                          _buildActionBtn(
                            context,
                            'Escalate',
                            AppColors.primary,
                            () => _handleAction(val, 'Escalated'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () => _handleAction(val, 'Approved'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              textStyle: AppTextStyles.labelSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Approve'),
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
    );
  }

  Widget _buildActionBtn(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        textStyle: AppTextStyles.labelSmall.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      child: Text(label),
    );
  }

  void _handleAction(RxValidationItem val, String status) {
    ref.read(pharmacyProvider.notifier).resolveRxValidation(val.id, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: status == 'Approved'
            ? AppColors.success
            : status == 'Rejected'
            ? AppColors.error
            : AppColors.primary,
        content: Text('Prescription ${val.rxNo} is $status!'),
      ),
    );
  }
}
