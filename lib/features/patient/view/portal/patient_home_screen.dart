import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_abha_strip.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_alert_ticker.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_health_hero.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_home_header.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_kpi_grid.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_quick_actions.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientHomeScreen extends ConsumerStatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  ConsumerState<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends ConsumerState<PatientHomeScreen> {
  final Map<int, bool> _medicationStatus = {
    0: true, // Metformin morning - Taken
    1: true, // Amlodipine morning - Taken
    2: false, // Metformin afternoon - Not Taken
    3: false, // Atorvastatin night - Not Taken
    4: false, // Losartan night - Not Taken
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientHome,
      ),
      appBar: PatientHomeHeader(
        onShowQR: () => PatientAbhaStrip.showAbhaQrDialog(context),
      ),
      body: Column(
        children: [
          const PatientAlertTicker(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const PatientHealthHero(),
                  const SizedBox(height: AppSpacing.md),
                  _buildActionableBanners(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildSectionHeader(
                    'My Health at a Glance',
                    RouteNames.patientHealthAnalytics,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const PatientKpiGrid(),
                  const SizedBox(height: AppSpacing.lg),
                  const Text('QUICK ACTIONS', style: AppTextStyles.labelSmall),
                  const SizedBox(height: AppSpacing.md),
                  const PatientQuickActions(),
                  const SizedBox(height: AppSpacing.lg),
                  const PatientAbhaStrip(),
                  const SizedBox(height: AppSpacing.lg),
                  _buildGridTwoColumnSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String routeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.grid_view_rounded,
              color: AppColors.primaryLight,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => context.pushNamed(routeName),
          child: const Text(
            'Full Analytics →',
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionableBanners() {
    return Column(
      children: [
        _buildBannerCard(
          icon: Icons.warning_amber_rounded,
          color: AppColors.secondaryAccent,
          title: 'HbA1c Elevated — Action Required',
          desc:
              'Your latest HbA1c is 7.4% (target: <7.0%). Your diabetologist Dr. Priya Negi recommends a diet review and medication adjustment.',
          actions: [
            _buildBannerBtn(
              'View Report',
              true,
              () => context.pushNamed(RouteNames.patientLab),
            ),
            _buildBannerBtn(
              'Book Appointment',
              false,
              () => context.pushNamed(RouteNames.patientOPD),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildBannerCard(
          icon: Icons.vaccines_rounded,
          color: AppColors.primaryLight,
          title: 'Influenza Booster Vaccine Due',
          desc:
              'Your annual flu booster is due. Schedule at your nearest health centre or book a home visit.',
          actions: [
            _buildBannerBtn(
              'Schedule',
              true,
              () => context.pushNamed(RouteNames.patientVaccination),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBannerCard({
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
    required List<Widget> actions,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 8, children: actions),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerBtn(String label, bool isPrimary, VoidCallback onTap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? AppColors.primaryLight
            : Colors.white.withValues(alpha: 0.08),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildGridTwoColumnSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = AppSpacing.lg;
        if (constraints.maxWidth > 800) {
          // Double column for tablet/web
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildVitalsTrendCard(),
                    const SizedBox(height: spacing),
                    _buildUpcomingAppointmentsCard(),
                    const SizedBox(height: spacing),
                    _buildRecentLabReportsCard(),
                    const SizedBox(height: spacing),
                    _buildJourneyTimelineCard(),
                  ],
                ),
              ),
              const SizedBox(width: spacing),
              Expanded(
                child: Column(
                  children: [
                    _buildAiInsightsCard(),
                    const SizedBox(height: spacing),
                    _buildTodayMedsCard(),
                    const SizedBox(height: spacing),
                    _buildDiseaseRiskCard(),
                    const SizedBox(height: spacing),
                    _buildWellnessLifestyleCard(),
                    const SizedBox(height: spacing),
                    _buildInsuranceCard(),
                  ],
                ),
              ),
            ],
          );
        } else {
          // Single column for mobile
          return Column(
            children: [
              _buildVitalsTrendCard(),
              const SizedBox(height: spacing),
              _buildAiInsightsCard(),
              const SizedBox(height: spacing),
              _buildUpcomingAppointmentsCard(),
              const SizedBox(height: spacing),
              _buildTodayMedsCard(),
              const SizedBox(height: spacing),
              _buildRecentLabReportsCard(),
              const SizedBox(height: spacing),
              _buildDiseaseRiskCard(),
              const SizedBox(height: spacing),
              _buildWellnessLifestyleCard(),
              const SizedBox(height: spacing),
              _buildInsuranceCard(),
              const SizedBox(height: spacing),
              _buildJourneyTimelineCard(),
            ],
          );
        }
      },
    );
  }

  Widget _buildVitalsTrendCard() {
    return _buildChartCard(
      title: 'Vitals Trend — Last 30 Days',
      icon: Icons.stacked_line_chart_rounded,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTrendMiniCard(
                'Systolic BP',
                '128 mmHg',
                '+4 this week',
                AppColors.error,
                true,
              ),
              _buildTrendMiniCard(
                'Blood Sugar',
                '142 mg/dL',
                '+8 this week',
                AppColors.secondaryAccent,
                true,
              ),
              _buildTrendMiniCard(
                'Heart Rate',
                '76 bpm',
                'Stable',
                Colors.orange,
                false,
              ),
            ],
          ),
          const SizedBox(height: 14),
          const SizedBox(height: 160, child: CustomLineChartSimulator()),
        ],
      ),
    );
  }

  Widget _buildTrendMiniCard(
    String title,
    String val,
    String trend,
    Color color,
    bool isUp,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              val,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  isUp ? Icons.arrow_upward : Icons.remove,
                  color: isUp ? AppColors.error : AppColors.success,
                  size: 8,
                ),
                const SizedBox(width: 2),
                Text(
                  trend,
                  style: TextStyle(
                    color: isUp ? AppColors.error : AppColors.success,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAiInsightsCard() {
    return _buildChartCard(
      title: 'AI Health Insights',
      icon: Icons.psychology_rounded,
      color: const Color(0xFFC77DFF),
      child: Column(
        children: [
          _buildAiInsightItem(
            'BP Trend Alert',
            'Your systolic BP has increased by 8 mmHg over the last 7 days. Pattern suggests stress-related elevation. Consider relaxation and physician consultation.',
            '89%',
            AppColors.error,
          ),
          const SizedBox(height: 8),
          _buildAiInsightItem(
            'Dietary Recommendation',
            'Based on your HbA1c trend, reduce refined carbohydrate intake. Increase green leafy vegetables and add 20-min post-meal walks.',
            '92%',
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 8),
          _buildAiInsightItem(
            'Positive Signal',
            'Your medication adherence improved to 94% this week. SpO2 remains stable. Keep up the good work!',
            '97%',
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildAiInsightItem(
    String title,
    String body,
    String conf,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tips_and_updates, color: color, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'AI Confidence: $conf',
              style: TextStyle(
                color: color,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointmentsCard() {
    return _buildChartCard(
      title: 'Upcoming Appointments',
      icon: Icons.calendar_month_rounded,
      child: Column(
        children: [
          _buildApptItem(
            '20',
            'MAY',
            'Dr. Anjali Sharma — Cardiology',
            'AIIMS Rishikesh · 10:30 AM · OPD 4',
            'Confirmed',
            AppColors.success,
          ),
          const SizedBox(height: 8),
          _buildApptItem(
            '22',
            'MAY',
            'Dr. Rajesh Kumar — Endocrinology',
            'Video Consult · 4:00 PM · Telemedicine',
            'Teleconsult',
            AppColors.primaryLight,
          ),
          const SizedBox(height: 8),
          _buildApptItem(
            '28',
            'MAY',
            'Dr. Meena Bisht — Ophthalmology',
            'Doon Hospital · 11:00 AM · Annual Checkup',
            'Pending',
            AppColors.secondaryAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildApptItem(
    String day,
    String mon,
    String title,
    String subtitle,
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Text(
                  day,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  mon,
                  style: TextStyle(
                    color: color,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayMedsCard() {
    return _buildChartCard(
      title: "Today's Medication Schedule",
      icon: Icons.medication_rounded,
      child: Column(
        children: [
          _buildMedItem(
            0,
            'Metformin 500mg',
            '1 tablet after breakfast · T2DM',
            '8:00 AM',
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            1,
            'Amlodipine 5mg',
            '1 tablet morning · Hypertension',
            '8:00 AM',
            AppColors.error,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            2,
            'Metformin 500mg',
            '1 tablet after lunch · T2DM',
            '2:00 PM',
            AppColors.primaryLight,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            3,
            'Atorvastatin 10mg',
            '1 tablet at night · Cholesterol',
            '9:00 PM',
            AppColors.success,
          ),
          const SizedBox(height: 6),
          _buildMedItem(
            4,
            'Losartan 50mg',
            '1 tablet at night · HTN',
            '9:00 PM',
            const Color(0xFFC77DFF),
          ),
        ],
      ),
    );
  }

  Widget _buildMedItem(
    int id,
    String name,
    String instructions,
    String time,
    Color color,
  ) {
    final isDone = _medicationStatus[id] ?? false;
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.circle, color: color, size: 8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                Text(
                  instructions,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              color: AppColors.primaryLight,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              setState(() {
                _medicationStatus[id] = !isDone;
              });
            },
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? AppColors.success : Colors.transparent,
                border: Border.all(
                  color: isDone ? AppColors.success : AppColors.border,
                ),
              ),
              child: isDone
                  ? const Icon(Icons.check, color: Colors.black, size: 12)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentLabReportsCard() {
    return _buildChartCard(
      title: 'Recent Lab Reports',
      icon: Icons.science_rounded,
      child: Column(
        children: [
          _buildLabItem(
            'HbA1c — 7.4%',
            '12 May 2026 · Doon Diagnostics',
            'REVIEW',
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 6),
          _buildLabItem(
            'CBC + ESR — Complete Blood',
            '10 May 2026 · Doon Hospital Path',
            'NORMAL',
            AppColors.success,
          ),
          const SizedBox(height: 6),
          _buildLabItem(
            'Lipid Profile — LDL: 142',
            '10 May 2026 · Doon Hospital Path',
            'HIGH',
            AppColors.error,
          ),
          const SizedBox(height: 6),
          _buildLabItem(
            'Thyroid Panel (TSH/T3/T4)',
            '5 May 2026 · PathKind',
            'NORMAL',
            AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildLabItem(String name, String date, String status, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.description,
            color: AppColors.secondaryText,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: color,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseRiskCard() {
    return _buildChartCard(
      title: 'Disease Risk Assessment',
      icon: Icons.pie_chart_rounded,
      child: Column(
        children: [
          _buildRiskBarItem('Cardiovascular', 0.42, AppColors.error),
          const SizedBox(height: 8),
          _buildRiskBarItem(
            'Diabetes Complication',
            0.38,
            AppColors.secondaryAccent,
          ),
          const SizedBox(height: 8),
          _buildRiskBarItem('Kidney Disease', 0.18, AppColors.primaryLight),
          const SizedBox(height: 8),
          _buildRiskBarItem(
            'Diabetic Retinopathy',
            0.22,
            const Color(0xFFC77DFF),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskBarItem(String name, double val, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
            Text(
              '${(val * 100).round()}%',
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: val,
            color: color,
            backgroundColor: AppColors.border,
            minHeight: 4,
          ),
        ),
      ],
    );
  }

  Widget _buildWellnessLifestyleCard() {
    return _buildChartCard(
      title: 'Wellness & Lifestyle',
      icon: Icons.sports_gymnastics_rounded,
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            childAspectRatio: 1.4,
            children: [
              _buildWellnessGridTile(
                'Overall Wellness',
                '78',
                AppColors.success,
              ),
              _buildWellnessGridTile(
                'Physical Activity',
                '60%',
                AppColors.secondaryAccent,
              ),
              _buildWellnessGridTile(
                'Mental Wellness',
                '72%',
                AppColors.primaryLight,
              ),
              _buildWellnessGridTile(
                'Sleep Quality',
                '55%',
                AppColors.primaryLight,
              ),
              _buildWellnessGridTile(
                'Nutrition',
                '45%',
                AppColors.secondaryAccent,
              ),
              _buildWellnessGridTile('Med Adherence', '88%', AppColors.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWellnessGridTile(String label, String val, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            val,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInsuranceCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D9488), Color(0xFF065F46)],
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '🏥 AYUSHMAN BHARAT — PM-JAY',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Rahul Kumar Sharma',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const Text(
            'Policy: UK-ABP-2024-084210 · Active till 31 Mar 2027',
            style: TextStyle(color: Colors.white70, fontSize: 10),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInsValue('Total Cover', '₹5,00,000'),
              _buildInsValue('Used', '₹87,400'),
              _buildInsValue('Balance', '₹4,12,600'),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: const LinearProgressIndicator(
              value: 0.175,
              color: Colors.white70,
              backgroundColor: Colors.white24,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Utilised: 17.5%',
                style: TextStyle(color: Colors.white70, fontSize: 8),
              ),
              Text(
                '82.5% remaining',
                style: TextStyle(color: Colors.white70, fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInsValue(String label, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 8)),
        Text(
          val,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildJourneyTimelineCard() {
    return _buildChartCard(
      title: 'Medical Journey Timeline',
      icon: Icons.timeline_rounded,
      child: Column(
        children: [
          _buildTimelineItem(
            '12 May 2026',
            'HbA1c Lab Test',
            'Result: 7.4% — Slight elevation. Dr. Negi recommended diet modifications.',
            AppColors.error,
            Icons.science_rounded,
          ),
          _buildTimelineItem(
            '8 May 2026',
            'Teleconsultation — Endocrinology',
            'Dr. Rajesh Kumar reviewed diabetes management plan. Adjusted Metformin.',
            AppColors.primaryLight,
            Icons.video_camera_front_rounded,
          ),
          _buildTimelineItem(
            '2 Apr 2026',
            'Vaccination — COVID Booster (5th dose)',
            'Covaxin administered at Doon Hospital. No adverse reactions.',
            AppColors.success,
            Icons.vaccines_rounded,
          ),
          _buildTimelineItem(
            '15 Jan 2026',
            'Hypertension Diagnosis',
            'BP consistently 140/90. Started Amlodipine 5mg & lifestyle changes.',
            Colors.orange,
            Icons.health_and_safety_rounded,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    String date,
    String title,
    String body,
    Color color,
    IconData icon, {
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                child: Icon(icon, color: Colors.white, size: 10),
              ),
              if (!isLast)
                Expanded(child: Container(width: 1.5, color: AppColors.border)),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 8,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color color = AppColors.primaryLight,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class CustomLineChartSimulator extends StatelessWidget {
  const CustomLineChartSimulator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: _SimulatedChartPainter());
  }
}

class _SimulatedChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final axisPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.5)
      ..strokeWidth = 0.5;

    // Grid lines
    for (var i = 0; i <= 4; i++) {
      final y = size.height * (i / 4);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), axisPaint);
    }

    final bpPaint = Paint()
      ..color = AppColors.error
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final sugarPaint = Paint()
      ..color = AppColors.secondaryAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final bpPath = Path();
    final sugarPath = Path();

    // Map 30 points
    final bpPoints = [
      120,
      122,
      128,
      125,
      128,
      132,
      128,
      124,
      126,
      129,
      128,
      132,
      134,
      130,
      128,
    ];
    final sugarPoints = [
      110,
      130,
      142,
      135,
      140,
      145,
      142,
      138,
      140,
      144,
      142,
      146,
      148,
      143,
      142,
    ];

    final segmentWidth = size.width / (bpPoints.length - 1);

    for (var i = 0; i < bpPoints.length; i++) {
      final x = i * segmentWidth;
      final bpY = size.height - ((bpPoints[i] - 100) / 50) * size.height;
      final sugarY = size.height - ((sugarPoints[i] - 80) / 100) * size.height;

      if (i == 0) {
        bpPath.moveTo(x, bpY);
        sugarPath.moveTo(x, sugarY);
      } else {
        bpPath.lineTo(x, bpY);
        sugarPath.lineTo(x, sugarY);
      }
    }

    canvas
      ..drawPath(bpPath, bpPaint)
      ..drawPath(sugarPath, sugarPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
