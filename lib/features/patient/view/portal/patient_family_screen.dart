import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientFamilyScreen extends ConsumerWidget {
  const PatientFamilyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientFamily,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Family Health Hub'),
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
          _buildFamilySunburstCard(),
          const SizedBox(height: AppSpacing.md),
          const Text('LINKED FAMILY MEMBERS', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.sm),
          _buildRelativeCard(
            name: 'Kunal Sharma',
            relation: 'Son (Age: 3)',
            abha: 'ABHA: 88-1234-5678-0002',
            avatar: 'KS',
            iconColor: AppColors.primaryLight,
          ),
          _buildRelativeCard(
            name: 'Kiran Sharma',
            relation: 'Spouse (Age: 36)',
            abha: 'ABHA: 44-5678-1234-0003',
            avatar: 'KS',
            iconColor: AppColors.success,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildAddMemberButton(context),
        ],
      ),
    );
  }

  Widget _buildFamilySunburstCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FAMILY HEALTH NETWORK', style: AppTextStyles.labelSmall),
          SizedBox(height: 8),
          Text(
            "Keep track of your entire family's health diagnostics, schedules, and clinical prescriptions under a single centralized panel.",
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildRelativeCard({
    required String name,
    required String relation,
    required String abha,
    required String avatar,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: iconColor,
            child: Text(
              avatar,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: Colors.white,
                  ),
                ),
                Text(relation, style: AppTextStyles.bodySmall),
                const SizedBox(height: 2),
                Text(abha, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              'SWITCH',
              style: TextStyle(
                color: AppColors.primaryLight,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'LINK NEW FAMILY MEMBER',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
