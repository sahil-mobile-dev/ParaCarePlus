import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/family/family_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/family/family_member_card.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/family/family_risk_sunburst.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/family/family_risk_table.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'FAMILY HEALTH CENTRAL',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 1.1,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildNetworkHeader(),
              const SizedBox(height: AppSpacing.lg),
              const FamilyKpis(),
              const SizedBox(height: AppSpacing.lg),
              const FamilyRiskSunburst(),
              const SizedBox(height: AppSpacing.lg),
              const FamilyMemberCard(),
              const SizedBox(height: AppSpacing.lg),
              const FamilyRiskTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.5),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.hub_rounded, color: AppColors.primaryLight, size: 24),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CENTRALIZED FAMILY HEALTH NETWORK',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Synchronize and overview wellness indicators, genetic risk profiles, and clinical timelines for linked members from a single HIMS dashboard.',
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 11,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
