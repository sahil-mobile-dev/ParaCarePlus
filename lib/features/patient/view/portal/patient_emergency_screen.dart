import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/ambulance_tracker_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_maps.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_medical_card.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_sos_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientEmergencyScreen extends ConsumerWidget {
  const PatientEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sosStateProvider);
    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientEmergency,
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
        title: const Row(
          children: [
            Icon(
              Icons.airport_shuttle_rounded,
              color: AppColors.error,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Emergency & Ambulance',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Patient & Date Row Header
              _buildHeaderBadgeRow(todayStr),
              const SizedBox(height: AppSpacing.md),

              // SOS banner status
              _buildTopAlertBanner(state),
              const SizedBox(height: AppSpacing.lg),

              // SOS + Quick Contacts Panel
              const EmergencySosPanel(),
              const SizedBox(height: AppSpacing.lg),

              // KPIs Grid
              const EmergencyKpis(),
              const SizedBox(height: AppSpacing.lg),

              // Ambulance Tracker (Visible only if SOS active)
              if (state == SosState.active) ...[
                const AmbulanceTrackerPanel(),
                const SizedBox(height: AppSpacing.lg),
              ],

              // GIS Maps Section
              const Row(
                children: [
                  Icon(Icons.map_rounded, color: AppColors.error, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Emergency Services Map',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const EmergencyMaps(),
              const SizedBox(height: AppSpacing.lg),

              // Emergency Medical Card (At bottom)
              const EmergencyMedicalCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBadgeRow(String dateStr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.15),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.person_rounded, color: AppColors.error, size: 12),
              SizedBox(width: 4),
              Text(
                'Ramesh Kumar',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.15),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                color: AppColors.error,
                size: 10,
              ),
              const SizedBox(width: 4),
              Text(
                dateStr,
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopAlertBanner(SosState state) {
    var title = 'EMERGENCY BROADCAST INACTIVE';
    var subtitle =
        'Press the central SOS button to immediately trigger high-priority alerts to Rishikesh regional HIMS networks.';
    var color = AppColors.secondaryText;
    var border = AppColors.border;

    if (state == SosState.countdown) {
      title = 'CRITICAL COUNTDOWN IN PROGRESS';
      subtitle =
          'Preparing to broadcast GPS coordinates, blood metrics, and history to Uttarakhand dispatch teams.';
      color = AppColors.secondaryAccent;
      border = AppColors.secondaryAccent.withValues(alpha: 0.5);
    } else if (state == SosState.active) {
      title = '🔴 SOS BROADCAST ACTIVE — AMBULANCE EN ROUTE';
      subtitle =
          'UTTARAKHAND 108 Emergency Network has confirmed receipt. Paramedics have received your emergency medical profile.';
      color = AppColors.error;
      border = AppColors.error.withValues(alpha: 0.5);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            state == SosState.active
                ? Icons.crisis_alert_rounded
                : Icons.warning_amber_rounded,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primaryText,
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
