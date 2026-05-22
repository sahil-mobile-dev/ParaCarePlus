import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_contacts.dart';
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
        title: const Text(
          'EMERGENCY TELEMETRY SOS',
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
              _buildTopAlertBanner(state),
              const SizedBox(height: AppSpacing.lg),
              const EmergencySosPanel(),
              const SizedBox(height: AppSpacing.lg),
              const EmergencyKpis(),
              const SizedBox(height: AppSpacing.lg),
              const EmergencyMedicalCard(),
              const SizedBox(height: AppSpacing.lg),
              const EmergencyContacts(),
              const SizedBox(height: AppSpacing.lg),
              const EmergencyMaps(),
            ],
          ),
        ),
      ),
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
