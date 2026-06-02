import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/state_admin/view_model/state_admin_view_model.dart';

class StateAdminSidebar extends ConsumerWidget {
  const StateAdminSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(stateAdminProvider.select((s) => s.activeTab));

    Widget buildNavItem(
      String tab,
      String label,
      IconData icon, {
      String? badge,
    }) {
      final isActive = activeTab == tab;

      return InkWell(
        onTap: () => ref.read(stateAdminProvider.notifier).changeTab(tab),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary.withValues(alpha: 0.18)
                : Colors.transparent,
            border: Border(
              left: BorderSide(
                color: isActive ? AppColors.primary : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive
                    ? AppColors.primaryLight
                    : AppColors.secondaryText,
                size: 14,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive
                        ? AppColors.primaryLight
                        : AppColors.secondaryText,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 210,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.account_balance,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ParaCare+ HMIS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'COMMAND CENTRE',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // User Badge
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4FC3F7),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Uttarakhand State Health',
                        style: TextStyle(
                          color: Color(0xFF4FC3F7),
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Office of Health Secretary',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(14, 12, 14, 6),
                    child: Text(
                      'OVERVIEW',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white30,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  buildNavItem('overview', 'State Dashboard', Icons.dashboard),
                  buildNavItem('map', 'Health Heatmap', Icons.map),
                  buildNavItem('districts', 'District Scorecard', Icons.score),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(14, 16, 14, 6),
                    child: Text(
                      'CLINICAL',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white30,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  buildNavItem(
                    'opd',
                    'OPD / IPD Analytics',
                    Icons.personal_injury,
                  ),
                  buildNavItem(
                    'disease',
                    'Disease Surveillance',
                    Icons.bug_report,
                    badge: '3',
                  ),
                  buildNavItem(
                    'mch',
                    'MCH & Immunisation',
                    Icons.baby_changing_station,
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(14, 16, 14, 6),
                    child: Text(
                      'FINANCE',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white30,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  buildNavItem(
                    'revenue',
                    'Revenue & Billing',
                    Icons.monetization_on,
                  ),
                  buildNavItem(
                    'ab',
                    'Ayushman Bharat',
                    Icons.medical_services,
                    badge: '12',
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(14, 16, 14, 6),
                    child: Text(
                      'OPERATIONS',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.white30,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  buildNavItem(
                    'facilities',
                    'Facilities Register',
                    Icons.domain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
