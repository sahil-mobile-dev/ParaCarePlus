import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/tele/available_specialists.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/tele/consultation_chat_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/tele/consultation_history_table.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/tele/tele_charts.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/tele/tele_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/tele/live_consultation_video.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientTeleScreen extends ConsumerWidget {
  const PatientTeleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayStr = DateFormat('dd MMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientTele,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.video_camera_back_rounded,
              color: Color(0xFF00B4D8),
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Telemedicine Hub',
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
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Page Header
              _buildPageHeader(context, todayStr),
              const SizedBox(height: AppSpacing.md),

              // KPI Grid
              const TeleKpis(),
              const SizedBox(height: AppSpacing.lg),

              // Live section header
              const Row(
                children: [
                  Icon(Icons.sensors_rounded, color: AppColors.error, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Live Consultation — Dr. Rajesh Kumar (Cardiologist)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),

              // Responsive video & chat row
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 900) {
                    return const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: LiveConsultationVideo()),
                        SizedBox(width: AppSpacing.md),
                        Expanded(flex: 2, child: ConsultationChatPanel()),
                      ],
                    );
                  } else {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LiveConsultationVideo(),
                        SizedBox(height: AppSpacing.md),
                        ConsultationChatPanel(),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              // Specialists Grid Section
              const Row(
                children: [
                  Icon(
                    Icons.people_rounded,
                    color: Color(0xFF00B4D8),
                    size: 16,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Available Specialists',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const AvailableSpecialists(),
              const SizedBox(height: AppSpacing.lg),

              // Consultation history
              const ConsultationHistoryTable(),
              const SizedBox(height: AppSpacing.lg),

              // Tele charts
              const TeleCharts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context, String dateStr) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        final elements = [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B4D8).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      color: Color(0xFF00B4D8),
                      size: 12,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Ramesh Kumar',
                      style: TextStyle(
                        color: Color(0xFF00B4D8),
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B4D8).withValues(alpha: 0.15),
                  border: Border.all(
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      color: Color(0xFF00B4D8),
                      size: 10,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateStr,
                      style: const TextStyle(
                        color: Color(0xFF00B4D8),
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMobile) const SizedBox(height: AppSpacing.sm),

              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Joining consultation queue…'),
                      backgroundColor: AppColors.primaryLight,
                    ),
                  );
                },
                icon: const Icon(Icons.video_call_rounded, size: 14),
                label: const Text(
                  'Start Consultation',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success.withValues(alpha: 0.15),
                  foregroundColor: AppColors.success,
                  elevation: 0,
                  side: BorderSide(
                    color: AppColors.success.withValues(alpha: 0.3),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ];

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: elements,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Telemedicine Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
