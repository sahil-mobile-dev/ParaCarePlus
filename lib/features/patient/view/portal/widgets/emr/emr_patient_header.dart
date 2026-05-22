import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRPatientHeader extends StatelessWidget {
  const EMRPatientHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLight.withValues(alpha: 0.12),
            const Color(0xFF4361EE).withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.25),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar Circle
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00B4D8), Color(0xFF4361EE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.5),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00B4D8).withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'R',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Patient Primary Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rahul Kumar Sharma',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Male · 38 years · DOB: 12 Aug 1987 · Blood: B+ · Dehradun',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // Health Tag Chips Grid
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _buildTagChip(
                icon: Icons.water_drop_rounded,
                label: 'B+',
                textColor: AppColors.error,
                bgColor: AppColors.error.withValues(alpha: 0.15),
              ),
              _buildTagChip(
                label: 'Hypertension',
                textColor: AppColors.error,
                bgColor: AppColors.error.withValues(alpha: 0.12),
              ),
              _buildTagChip(
                label: 'Type 2 Diabetes',
                textColor: AppColors.secondaryAccent,
                bgColor: AppColors.secondaryAccent.withValues(alpha: 0.12),
              ),
              _buildTagChip(
                icon: Icons.warning_amber_rounded,
                label: 'Penicillin Allergy',
                textColor: const Color(0xFFC77DFF),
                bgColor: const Color(0xFFC77DFF).withValues(alpha: 0.15),
              ),
              _buildTagChip(
                label: 'Aspirin — caution',
                textColor: AppColors.secondaryAccent,
                bgColor: AppColors.secondaryAccent.withValues(alpha: 0.1),
              ),
              _buildTagChip(
                icon: Icons.shield_rounded,
                label: 'AB-PMJAY Beneficiary',
                textColor: AppColors.success,
                bgColor: AppColors.success.withValues(alpha: 0.12),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // const Divider(color: AppColors.border, height: 1),
          // const SizedBox(height: AppSpacing.sm),

          // Clinical Metadata & Verification Details

          // LayoutBuilder(
          //   builder: (context, constraints) {
          //     final isWide = constraints.maxWidth > 400;
          //     final kids = [
          //       // ABHA ID Badge
          //       Container(
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 10,
          //           vertical: 6,
          //         ),
          //         decoration: BoxDecoration(
          //           color: AppColors.success.withValues(alpha: 0.1),
          //           border: Border.all(
          //             color: AppColors.success.withValues(alpha: 0.25),
          //           ),
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             const Icon(
          //               Icons.badge_rounded,
          //               color: AppColors.success,
          //               size: 14,
          //             ),
          //             const SizedBox(width: 6),
          //             Text(
          //               'ABHA: 12-3456-7890-0001',
          //               style: AppTextStyles.labelSmall.copyWith(
          //                 color: AppColors.success,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 10.5,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       if (!isWide) const SizedBox(height: 8),

          //       // Extra Clinical Numbers
          //       Column(
          //         crossAxisAlignment: isWide
          //             ? CrossAxisAlignment.end
          //             : CrossAxisAlignment.start,
          //         children: [
          //           _buildMetaText('UHID', 'UHD-2021-08421'),
          //           const SizedBox(height: 2),
          //           _buildMetaText('First Visit', '14 Mar 2018'),
          //           const SizedBox(height: 2),
          //           _buildMetaText('Total Records', '84 files'),
          //           const SizedBox(height: 2),
          //           Row(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               const Text(
          //                 'Consent: ',
          //                 style: TextStyle(
          //                   color: AppColors.secondaryText,
          //                   fontSize: 10.5,
          //                 ),
          //               ),
          //               Text(
          //                 'Active',
          //                 style: AppTextStyles.labelSmall.copyWith(
          //                   color: AppColors.success,
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 10.5,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ];

          //     return isWide
          //         ? Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: kids,
          //           )
          //         : Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: kids,
          //           );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildTagChip({
    required String label,
    required Color textColor,
    required Color bgColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: 10),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
