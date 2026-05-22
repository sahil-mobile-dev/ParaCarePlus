import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientEMRScreen extends ConsumerWidget {
  const PatientEMRScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.background,
        drawer: const PatientPortalDrawer(
          activeRouteName: RouteNames.patientEMR,
        ),
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          title: const Text('Electronic Medical Records'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: AppColors.primaryText,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primaryLight,
            tabs: [
              Tab(text: 'Vitals & Profile'),
              Tab(text: 'Allergies & Conditions'),
              Tab(text: 'Medications'),
              Tab(text: 'Pathology & LIS'),
              Tab(text: 'ABDM Health Locker'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _VitalsTab(),
            _AllergiesTab(),
            _MedicationsTab(),
            _LabTab(),
            _LockerTab(),
          ],
        ),
      ),
    );
  }
}

class _VitalsTab extends StatelessWidget {
  const _VitalsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildInfoCard(),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'HISTORICAL VITALS RECORD',
            style: AppTextStyles.labelSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildVitalRow(
            'Blood Pressure',
            '122/78 mmHg',
            'Normal',
            AppColors.success,
          ),
          _buildVitalRow('Heart Rate', '72 bpm', 'Optimal', AppColors.success),
          _buildVitalRow(
            'Fasting Sugar',
            '98 mg/dL',
            'Healthy',
            AppColors.success,
          ),
          _buildVitalRow(
            'Body Temperature',
            '98.4 °F',
            'Optimal',
            AppColors.success,
          ),
          _buildVitalRow(
            'Blood Oxygen (SpO2)',
            '99%',
            'Perfect',
            AppColors.success,
          ),
          _buildVitalRow(
            'Respiratory Rate',
            '16/min',
            'Normal',
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PATIENT METADATA', style: AppTextStyles.labelSmall),
          SizedBox(height: 8),
          Text('Full Name: Ramesh Kumar', style: AppTextStyles.labelMedium),
          SizedBox(height: 4),
          Text('Age: 48 | DOB: 12 March 1978', style: AppTextStyles.bodySmall),
          SizedBox(height: 4),
          Text(
            'Location: Rishikesh, Uttarakhand',
            style: AppTextStyles.bodySmall,
          ),
          SizedBox(height: 4),
          Text(
            'Gender: Male | Height: 172 cm | Weight: 74 kg',
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildVitalRow(
    String title,
    String value,
    String status,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.5),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.labelMedium),
          Row(
            children: [
              Text(
                value,
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: color,
                    fontSize: 8,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AllergiesTab extends StatelessWidget {
  const _AllergiesTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const Text('DRUG & FOOD ALLERGIES', style: AppTextStyles.labelSmall),
        const SizedBox(height: AppSpacing.sm),
        _buildAllergyCard(
          'Penicillin Allergy',
          'Severe drug allergy, causes skin hives & swelling',
          'High Severity',
          AppColors.error,
        ),
        _buildAllergyCard(
          'Sulfonamides Allergy',
          'Hypersensitivity to sulfa drugs, causes rashes',
          'Moderate Severity',
          AppColors.secondaryAccent,
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'DIAGNOSED MEDICAL CONDITIONS',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildConditionCard(
          'Essential Hypertension',
          'Under active treatment. BP monitored daily.',
          'Active',
          AppColors.success,
        ),
        _buildConditionCard(
          'Borderline Pre-Diabetes',
          'Managed via lifestyle guidelines & diet routine.',
          'Monitored',
          AppColors.secondaryAccent,
        ),
        _buildConditionCard(
          'Hyperlipidemia',
          'Cholesterol limits managed through mild statins.',
          'Stable',
          AppColors.success,
        ),
      ],
    );
  }

  Widget _buildAllergyCard(String title, String desc, String tag, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  tag,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: color,
                    fontSize: 8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(desc, style: AppTextStyles.bodySmall),
        ],
      ),
    );
  }

  Widget _buildConditionCard(
    String title,
    String desc,
    String tag,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.primaryLight,
            size: 16,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(desc, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: AppTextStyles.labelSmall.copyWith(
                color: color,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicationsTab extends StatelessWidget {
  const _MedicationsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const Text(
          'CURRENT ACTIVE PRESCRIPTIONS',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildMedicationRow(
          'Metformin 500mg',
          '1 tablet - Twice daily',
          'Post breakfast & dinner',
          'Pre-Diabetes',
          AppColors.secondaryAccent,
        ),
        _buildMedicationRow(
          'Amlodipine 5mg',
          '1 tablet - Once daily',
          'Morning, post food',
          'Hypertension',
          AppColors.success,
        ),
        _buildMedicationRow(
          'Atorvastatin 10mg',
          '1 tablet - Once daily',
          'Night, before sleep',
          'Hyperlipidemia',
          AppColors.success,
        ),
        _buildMedicationRow(
          'Aspirin 75mg',
          '1 tablet - Once daily',
          'Afternoon, post lunch',
          'Prophylaxis',
          AppColors.success,
        ),
      ],
    );
  }

  Widget _buildMedicationRow(
    String medName,
    String dosage,
    String timing,
    String indication,
    Color indColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.medication_rounded,
              color: AppColors.primaryLight,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medName,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text('$dosage | $timing', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: indColor.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: indColor.withValues(alpha: 0.3)),
            ),
            child: Text(
              indication,
              style: AppTextStyles.labelSmall.copyWith(
                color: indColor,
                fontSize: 8.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabTab extends StatelessWidget {
  const _LabTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const Text(
          'LABORATORY REPORT SUMMARIES',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildLabItem(
          'Complete Blood Count (CBC)',
          'Hb: 14.2 g/dL | WBC: 6,800 /uL | Platelets: 2.2L',
          '15 May 2026',
          'Normal',
        ),
        _buildLabItem(
          'Lipid Profile Profile',
          'Cholesterol: 198 mg/dL | Triglycerides: 142 mg/dL',
          '08 May 2026',
          'Stable',
        ),
        _buildLabItem(
          'Thyroid Stimulating Hormone (TSH)',
          'TSH: 2.4 uIU/mL',
          '20 Apr 2026',
          'Normal',
        ),
      ],
    );
  }

  Widget _buildLabItem(
    String labName,
    String result,
    String date,
    String status,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labName,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                date,
                style: AppTextStyles.labelSmall.copyWith(fontSize: 8.5),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(result, style: AppTextStyles.bodySmall),
          const SizedBox(height: 4),
          Text(
            'Status: $status',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.success,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _LockerTab extends StatelessWidget {
  const _LockerTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        const Text(
          'ABDM CENTRAL HEALTH LOCKER (FHIR R4)',
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildLockerDocument(
          'OpdPrescription_RishikeshPHC.fhir.json',
          'FHIR R4 Resource Document',
          '14 May 2026',
          '2.8 KB',
        ),
        _buildLockerDocument(
          'LabReport_CompleteBloodCount.fhir.json',
          'FHIR R4 Lab Record Document',
          '15 May 2026',
          '3.1 KB',
        ),
        _buildLockerDocument(
          'RadiologyAI_FindingsSummary.pdf',
          'Signed Diagnostic Summary PDF',
          '08 May 2026',
          '422 KB',
        ),
      ],
    );
  }

  Widget _buildLockerDocument(
    String docName,
    String type,
    String date,
    String size,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.file_present_rounded,
              color: AppColors.success,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  docName,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text('$type | $date', style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Text(size, style: AppTextStyles.labelSmall.copyWith(fontSize: 9)),
        ],
      ),
    );
  }
}
