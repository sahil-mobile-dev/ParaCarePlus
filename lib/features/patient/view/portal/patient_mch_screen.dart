import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/mch/antenatal_history_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/mch/child_growth_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/mch/mch_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/mch/nutrition_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/mch/womens_health_tab.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientMchScreen extends ConsumerStatefulWidget {
  const PatientMchScreen({super.key});

  @override
  ConsumerState<PatientMchScreen> createState() => _PatientMchScreenState();
}

class _PatientMchScreenState extends ConsumerState<PatientMchScreen> {
  int _activeTabIndex = 0;

  final List<String> _tabNames = [
    'Child Growth',
    'Antenatal History',
    "Women's Health",
    'Nutrition',
  ];

  final List<IconData> _tabIcons = [
    Icons.child_care_rounded,
    Icons.pregnant_woman_rounded,
    Icons.female_rounded,
    Icons.apple_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());
    const mchPink = Color(0xFFF72585);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(activeRouteName: RouteNames.patientMch),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            const Icon(Icons.female_rounded, color: mchPink, size: 20),
            const SizedBox(width: 8),
            Text(
              'Women & Child Health (MCH)',
              style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
        actions: [],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppRadius.md),
              child: Row(
                children: [
                  // MCH Module Info Tag
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: mchPink.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: mchPink.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite_rounded,
                          color: mchPink,
                          size: 11,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'MCH Module',
                          style: AppTextStyles.labelSmall.copyWith(
                            color: mchPink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Today's Date Badge
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      todayStr,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.secondaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Book ANC Button
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening ANC booking…'),
                          backgroundColor: AppColors.surface,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: mchPink,
                    ),
                    label: const Text(
                      'Book ANC',
                      style: TextStyle(
                        color: mchPink,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: mchPink.withValues(alpha: 0.15),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: mchPink.withValues(alpha: 0.3)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KPI metrics grid at top (does not scroll with tabs)
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                0,
              ),
              child: MchKpis(),
            ),
            const SizedBox(height: AppSpacing.md),

            // Tab bar selector
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: List.generate(_tabNames.length, (index) {
                  final isActive = _activeTabIndex == index;
                  return Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _activeTabIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isActive ? mchPink : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _tabIcons[index],
                              size: 14,
                              color: isActive
                                  ? mchPink
                                  : AppColors.secondaryText,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                _tabNames[index],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isActive
                                      ? mchPink
                                      : AppColors.secondaryText,
                                  fontSize: 11.5,
                                  fontWeight: isActive
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Tab content area (scrollable)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: _buildActiveTabContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return const ChildGrowthTab();
      case 1:
        return const AntenatalHistoryTab();
      case 2:
        return const WomensHealthTab();
      case 3:
        return const NutritionTab();
      default:
        return const ChildGrowthTab();
    }
  }
}
