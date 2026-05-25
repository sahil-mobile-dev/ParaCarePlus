import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
    final currentDateStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientFamily,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page Header Row
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 600;

                  final titleRow = Row(
                    children: [
                      const Icon(
                        Icons.verified_user,
                        color: AppColors.primaryLight,
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Family Health Dashboard',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isMobile) ...[
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.15,
                            ),
                            border: Border.all(
                              color: AppColors.primaryLight.withValues(
                                alpha: 0.3,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'ABHA Linked',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  );

                  final actionsRow = Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withValues(alpha: 0.15),
                          border: Border.all(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.person_rounded,
                              color: AppColors.primaryLight,
                              size: 11,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Ramesh Kumar (Head)',
                              style: TextStyle(
                                color: AppColors.primaryLight,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight.withValues(alpha: 0.15),
                          border: Border.all(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          currentDateStr,
                          style: const TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Opening add family member flow…'),
                              backgroundColor: AppColors.primaryLight,
                            ),
                          );
                        },
                        icon: const Icon(Icons.person_add_rounded, size: 12),
                        label: const Text(
                          'Add Member',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryLight.withValues(
                            alpha: 0.2,
                          ),
                          foregroundColor: AppColors.primaryLight,
                          elevation: 0,
                          side: BorderSide(
                            color: AppColors.primaryLight.withValues(
                              alpha: 0.4,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  );

                  return Column(
                    children: [
                      titleRow,
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [actionsRow],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // KPI Cards
              const FamilyKpis(),
              const SizedBox(height: AppSpacing.lg),

              // Family Profiles
              const FamilyMemberCard(),
              const SizedBox(height: AppSpacing.lg),

              // Family Risk Table
              const FamilyRiskTable(),
              const SizedBox(height: AppSpacing.lg),

              // Dual Sunburst Charts
              const FamilyRiskSunburst(),
            ],
          ),
        ),
      ),
    );
  }
}
