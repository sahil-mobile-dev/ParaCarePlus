import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientLabScreen extends ConsumerWidget {
  const PatientLabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(activeRouteName: RouteNames.patientLab),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Lab & Pathology Reports'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildAlertStrip(),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'RECENT DIAGNOSTICS TESTS',
            style: AppTextStyles.labelSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildLabCard(
            title: 'HbA1c (Glycated Haemoglobin)',
            value: '7.4%',
            reference: 'Target: < 7.0%',
            lab: 'Doon Diagnostics Center',
            date: '12 May 2026',
            status: 'REVIEW',
            statusColor: AppColors.error,
          ),
          _buildLabCard(
            title: 'Lipid Profile (LDL Cholesterol)',
            value: '142 mg/dL',
            reference: 'Normal: < 100 mg/dL',
            lab: 'Doon Hospital Pathology',
            date: '10 May 2026',
            status: 'HIGH',
            statusColor: AppColors.secondaryAccent,
          ),
          _buildLabCard(
            title: 'Complete Blood Count (CBC)',
            value: 'Hemoglobin: 14.2 g/dL',
            reference: 'Normal: 13.5 - 17.5 g/dL',
            lab: 'Doon Hospital Pathology',
            date: '10 May 2026',
            status: 'NORMAL',
            statusColor: AppColors.success,
          ),
          _buildLabCard(
            title: 'Thyroid Panel (TSH)',
            value: '2.4 mIU/L',
            reference: 'Normal: 0.4 - 4.5 mIU/L',
            lab: 'PathKind Labs',
            date: '05 May 2026',
            status: 'NORMAL',
            statusColor: AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertStrip() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: AppColors.error),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Critical Findings Available',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your HbA1c and LDL metrics require active clinical review.',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabCard({
    required String title,
    required String value,
    required String reference,
    required String lab,
    required String date,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(reference, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.business_rounded,
                    color: AppColors.secondaryText,
                    size: 12,
                  ),
                  const SizedBox(width: 4),
                  Text(lab, style: AppTextStyles.bodySmall),
                ],
              ),
              Text(date, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
