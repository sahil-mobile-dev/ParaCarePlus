import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientPrescriptionScreen extends ConsumerWidget {
  const PatientPrescriptionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientPrescription,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('My Prescriptions'),
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
          _buildInteractionSafetyHeader(),
          const SizedBox(height: AppSpacing.md),
          const Text('ACTIVE PRESCRIBED MEDS', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.sm),
          _buildMedicationCard(
            title: 'Metformin 500mg',
            dose: '1 tablet after breakfast & after lunch',
            indication: 'Type-2 Diabetes Mellitus',
            doctor: 'Dr. Rajesh Kumar · Endocrinology',
            refills: '3 refills left · Next refill: 15 Jun 2026',
            status: 'ACTIVE',
            statusColor: AppColors.success,
          ),
          _buildMedicationCard(
            title: 'Amlodipine 5mg',
            dose: '1 tablet in the morning',
            indication: 'Essential Hypertension',
            doctor: 'Dr. Anjali Sharma · Cardiology',
            refills: '6 refills left · Next refill: 10 Jun 2026',
            status: 'ACTIVE',
            statusColor: AppColors.success,
          ),
          _buildMedicationCard(
            title: 'Atorvastatin 10mg',
            dose: '1 tablet at night',
            indication: 'Hypercholesterolemia (LDL Limit)',
            doctor: 'Dr. Anjali Sharma · Cardiology',
            refills: '2 refills left · Next refill: 01 Jun 2026',
            status: 'ACTIVE',
            statusColor: AppColors.success,
          ),
          _buildMedicationCard(
            title: 'Losartan 50mg',
            dose: '1 tablet at night',
            indication: 'Secondary HTN Guard',
            doctor: 'Dr. Anjali Sharma · Cardiology',
            refills: '0 refills left · Schedule Consult',
            status: 'REFILL DUE',
            statusColor: AppColors.secondaryAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionSafetyHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
      ),
      child: const Row(
        children: [
          Icon(Icons.verified_user_rounded, color: AppColors.success),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Medication Safety Check',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'No adverse drug-drug interactions found among your 4 active medications.',
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

  Widget _buildMedicationCard({
    required String title,
    required String dose,
    required String indication,
    required String doctor,
    required String refills,
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
                  style: AppTextStyles.labelLarge.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
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
          const SizedBox(height: AppSpacing.sm),
          Text(
            dose,
            style: const TextStyle(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text('Indication: $indication', style: AppTextStyles.bodySmall),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(doctor, style: AppTextStyles.bodySmall),
              Text(
                refills,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
