import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientQuickActions extends StatelessWidget {
  const PatientQuickActions({super.key});

  static final List<Map<String, dynamic>> _actions = [
    {
      'label': 'Book Appointment',
      'icon': Icons.calendar_today_rounded,
      'color': AppColors.primaryLight,
      'route': RouteNames.patientOPD,
    },
    {
      'label': 'Start Video Call',
      'icon': Icons.video_call_rounded,
      'color': Colors.blue,
      'route': RouteNames.patientTele,
    },
    {
      'label': 'View Lab Reports',
      'icon': Icons.science_rounded,
      'color': AppColors.secondaryAccent,
      'route': RouteNames.patientLab,
    },
    {
      'label': 'My Medications',
      'icon': Icons.medication_rounded,
      'color': Colors.orange,
      'route': RouteNames.patientPrescription,
    },
    {
      'label': 'Emergency SOS',
      'icon': Icons.emergency_rounded,
      'color': AppColors.error,
      'route': RouteNames.patientEmergency,
    },
    {
      'label': 'Health Records',
      'icon': Icons.file_copy_rounded,
      'color': AppColors.success,
      'route': RouteNames.patientEMR,
    },
    {
      'label': 'Radiology',
      'icon': Icons.biotech_rounded,
      'color': const Color(0xFFC77DFF),
      'route': RouteNames.patientRadiology,
    },
    {
      'label': 'Vaccines',
      'icon': Icons.vaccines_rounded,
      'color': const Color(0xFF4361EE),
      'route': RouteNames.patientVaccination,
    },
    {
      'label': 'Pay Bills',
      'icon': Icons.account_balance_wallet_rounded,
      'color': const Color(0xFF0D9488),
      'route': RouteNames.patientFinance,
    },
    {
      'label': 'AI Assistant',
      'icon': Icons.smart_toy_rounded,
      'color': const Color(0xFFF72585),
      'route': RouteNames.patientAI,
    },
    {
      'label': 'Find Hospital',
      'icon': Icons.map_rounded,
      'color': AppColors.primaryLight,
      'route': RouteNames.patientMaps,
    },
    {
      'label': 'Family Health',
      'icon': Icons.groups_rounded,
      'color': AppColors.secondaryAccent,
      'route': RouteNames.patientFamily,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 6 : 3;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.1,
          ),
          itemCount: _actions.length,
          itemBuilder: (context, index) {
            final a = _actions[index];
            return _buildQuickActionCard(context, a);
          },
        );
      },
    );
  }

  Widget _buildQuickActionCard(BuildContext context, Map<String, dynamic> act) {
    final route = act['route'] as String;
    final color = act['color'] as Color;
    final icon = act['icon'] as IconData;
    final label = act['label'] as String;

    return GestureDetector(
      onTap: () {
        context.pushNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
