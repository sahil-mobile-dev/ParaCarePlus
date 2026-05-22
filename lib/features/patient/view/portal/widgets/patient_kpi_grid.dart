import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientKpiGrid extends StatelessWidget {
  const PatientKpiGrid({super.key});

  static final List<Map<String, dynamic>> _kpis = [
    {
      'label': 'Upcoming Appointments',
      'val': '3',
      'sub': 'Next: 20 May, Cardiology',
      'icon': Icons.calendar_month_rounded,
      'badge': 'SCHEDULED',
      'badgeType': 'due',
      'color': AppColors.primaryLight,
      'route': RouteNames.patientOPD,
    },
    {
      'label': 'Active Prescriptions',
      'val': '5',
      'sub': '2 due today',
      'icon': Icons.medication_rounded,
      'badge': 'DUE',
      'badgeType': 'warn',
      'color': AppColors.secondaryAccent,
      'route': RouteNames.patientPrescription,
    },
    {
      'label': 'Lab Reports',
      'val': '7',
      'sub': '1 abnormal finding',
      'icon': Icons.science_rounded,
      'badge': 'REVIEW',
      'badgeType': 'alert',
      'color': AppColors.secondaryAccent,
      'route': RouteNames.patientLab,
    },
    {
      'label': 'Teleconsultations',
      'val': '2',
      'sub': 'Last: 8 May 2026',
      'icon': Icons.video_call_rounded,
      'badge': 'DONE',
      'badgeType': 'ok',
      'color': AppColors.primaryLight,
      'route': RouteNames.patientTele,
    },
    {
      'label': 'Cardiovascular Risk',
      'val': '42%',
      'sub': 'Moderate — AI assessed',
      'icon': Icons.favorite_rounded,
      'badge': 'MODERATE',
      'badgeType': 'alert',
      'color': AppColors.error,
      'route': RouteNames.patientHealthAnalytics,
    },
    {
      'label': 'Vaccinations Done',
      'val': '12/14',
      'sub': '2 boosters pending',
      'icon': Icons.shield_rounded,
      'badge': 'PENDING',
      'badgeType': 'due',
      'color': AppColors.success,
      'route': RouteNames.patientVaccination,
    },
    {
      'label': 'Insurance Coverage',
      'val': '₹5L',
      'sub': 'AB-PMJAY active',
      'icon': Icons.verified_user_rounded,
      'badge': 'ACTIVE',
      'badgeType': 'ok',
      'color': AppColors.primaryLight,
      'route': RouteNames.patientFinance,
    },
    {
      'label': 'Current Medications',
      'val': '5',
      'sub': 'No interactions found',
      'icon': Icons.medical_information_rounded,
      'badge': 'SAFE',
      'badgeType': 'ok',
      'color': const Color(0xFFC77DFF),
      'route': RouteNames.patientPrescription,
    },
    {
      'label': 'Pending Bills',
      'val': '₹2,400',
      'sub': '1 overdue > 30 days',
      'icon': Icons.receipt_long_rounded,
      'badge': 'OVERDUE',
      'badgeType': 'warn',
      'color': AppColors.error,
      'route': RouteNames.patientFinance,
    },
    {
      'label': 'Wellness Score',
      'val': '78',
      'sub': 'Good · +3 this month',
      'icon': Icons.emoji_emotions_rounded,
      'badge': 'GOOD',
      'badgeType': 'ok',
      'color': AppColors.success,
      'route': RouteNames.patientWellness,
    },
    {
      'label': 'BMI',
      'val': '26.2',
      'sub': 'Normal · 78kg / 173cm',
      'icon': Icons.accessibility_new_rounded,
      'badge': 'NORMAL',
      'badgeType': 'ok',
      'color': AppColors.primaryLight,
      'route': RouteNames.patientHealthAnalytics,
    },
    {
      'label': 'Blood Pressure',
      'val': '128/82',
      'sub': 'Stage 1 HTN',
      'icon': Icons.heart_broken_rounded,
      'badge': 'ELEVATED',
      'badgeType': 'warn',
      'color': AppColors.error,
      'route': RouteNames.patientHealthAnalytics,
    },
    {
      'label': 'Fasting Blood Sugar',
      'val': '142',
      'sub': 'mg/dL · Pre-diabetic',
      'icon': Icons.water_drop_rounded,
      'badge': 'HIGH',
      'badgeType': 'warn',
      'color': AppColors.secondaryAccent,
      'route': RouteNames.patientHealthAnalytics,
    },
    {
      'label': 'SpO2',
      'val': '98%',
      'sub': 'Normal saturation',
      'icon': Icons.air_rounded,
      'badge': 'NORMAL',
      'badgeType': 'ok',
      'color': AppColors.success,
      'route': RouteNames.patientHealthAnalytics,
    },
    {
      'label': 'Heart Rate (bpm)',
      'val': '76',
      'sub': 'Resting · Normal range',
      'icon': Icons.monitor_heart_rounded,
      'badge': 'NORMAL',
      'badgeType': 'ok',
      'color': Colors.orange,
      'route': RouteNames.patientHealthAnalytics,
    },
    {
      'label': 'Sleep (last night)',
      'val': '6.2h',
      'sub': 'Target: 7-8h',
      'icon': Icons.nightlight_round,
      'badge': 'LOW',
      'badgeType': 'warn',
      'color': const Color(0xFFC77DFF),
      'route': RouteNames.patientWellness,
    },
    {
      'label': 'Steps Today',
      'val': '4,820',
      'sub': 'Target: 8,000 steps',
      'icon': Icons.directions_walk_rounded,
      'badge': 'BELOW',
      'badgeType': 'warn',
      'color': AppColors.success,
      'route': RouteNames.patientWellness,
    },
    {
      'label': 'Water Intake',
      'val': '1.4L',
      'sub': 'Target: 2.5L',
      'icon': Icons.local_drink_rounded,
      'badge': 'LOW',
      'badgeType': 'warn',
      'color': AppColors.primaryLight,
      'route': RouteNames.patientWellness,
    },
    {
      'label': 'AI Health Alerts',
      'val': '3',
      'sub': '1 high-priority',
      'icon': Icons.psychology_rounded,
      'badge': 'ACTION',
      'badgeType': 'alert',
      'color': const Color(0xFFF72585),
      'route': RouteNames.patientAI,
    },
    {
      'label': 'Mental Wellness',
      'val': '72',
      'sub': 'PHQ-9 Score: Mild',
      'icon': Icons.spa_rounded,
      'badge': 'MILD',
      'badgeType': 'ok',
      'color': AppColors.success,
      'route': RouteNames.patientWellness,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 5 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.35,
          ),
          itemCount: _kpis.length,
          itemBuilder: (context, index) {
            final k = _kpis[index];
            return _buildKpiCard(context, k);
          },
        );
      },
    );
  }

  Widget _buildKpiCard(BuildContext context, Map<String, dynamic> kpi) {
    final route = kpi['route'] as String;
    final color = kpi['color'] as Color;
    final icon = kpi['icon'] as IconData;
    final val = kpi['val'] as String;
    final label = kpi['label'] as String;
    final sub = kpi['sub'] as String;
    final badge = kpi['badge'] as String;
    final badgeType = kpi['badgeType'] as String;

    return GestureDetector(
      onTap: () {
        context.pushNamed(route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Stack(
            children: [
              // Top border color line matching eCharts silhouette
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 3,
                child: Container(color: color),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(icon, color: color, size: 18),
                        _buildBadge(badge, badgeType),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          val,
                          style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          sub,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 8,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, String type) {
    var bg = AppColors.primary.withValues(alpha: 0.15);
    var fg = AppColors.primaryText;

    switch (type) {
      case 'ok':
        bg = AppColors.success.withValues(alpha: 0.15);
        fg = AppColors.success;
      case 'warn':
        bg = AppColors.secondaryAccent.withValues(alpha: 0.15);
        fg = AppColors.secondaryAccent;
      case 'alert':
        bg = AppColors.error.withValues(alpha: 0.15);
        fg = AppColors.error;
      case 'due':
        bg = AppColors.primaryLight.withValues(alpha: 0.15);
        fg = AppColors.primaryLight;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 7, fontWeight: FontWeight.bold),
      ),
    );
  }
}
