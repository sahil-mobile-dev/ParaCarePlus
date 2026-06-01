import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';

class LabOrdersTab extends ConsumerWidget {
  const LabOrdersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorDashboardViewModelProvider);
    final notifier = ref.read(doctorDashboardViewModelProvider.notifier);

    final isWide = MediaQuery.of(context).size.width > 950;
    // Filter purely lab reports (starting with LAB)
    final labReports = state.labReports
        .where((r) => r.id.startsWith('LAB') && r.status == 'Pending Review')
        .toList();

    var currentReport = state.selectedReportToReview;
    // If selected is not a lab report or null, default to first lab report
    if ((currentReport == null || !currentReport.id.startsWith('LAB')) &&
        labReports.isNotEmpty) {
      currentReport = labReports[0];
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(labReports.length),
          const SizedBox(height: AppSpacing.lg),
          Expanded(
            child: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left side - LIS queue
                      Expanded(
                        flex: 10,
                        child: _buildReportsQueue(
                          labReports,
                          currentReport,
                          notifier,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      // Right side - Clinical verification desk
                      Expanded(
                        flex: 12,
                        child: _buildVerificationDesk(
                          context,
                          currentReport,
                          notifier,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                        child: _buildReportsQueue(
                          labReports,
                          currentReport,
                          notifier,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Expanded(
                        child: _buildVerificationDesk(
                          context,
                          currentReport,
                          notifier,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(int pendingCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.biotech_rounded,
              color: AppColors.primaryLight,
              size: 28,
            ),
            SizedBox(width: 10),
            Text(
              'Lab Orders & Results (LIS)',
              style: AppTextStyles.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Validate laboratory investigation outcomes. $pendingCount results awaiting clinical e-signature.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildReportsQueue(
    List<LabReport> reports,
    LabReport? currentReport,
    DoctorDashboardViewModel notifier,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PENDING SIGN-OFF (${reports.length})',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Expanded(
            child: reports.isEmpty
                ? _buildEmptyQueueState()
                : ListView.separated(
                    itemCount: reports.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, i) {
                      final r = reports[i];
                      final isSelected = currentReport?.id == r.id;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.surface
                              : AppColors.background.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : r.isUrgent
                                ? AppColors.error.withValues(alpha: 0.5)
                                : AppColors.border,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          onTap: () => notifier.selectReportToReview(r),
                          leading: CircleAvatar(
                            backgroundColor: isSelected
                                ? AppColors.primary
                                : r.isUrgent
                                ? AppColors.error.withValues(alpha: 0.15)
                                : AppColors.card,
                            child: Icon(
                              Icons.science_outlined,
                              color: isSelected
                                  ? Colors.white
                                  : r.isUrgent
                                  ? AppColors.error
                                  : AppColors.secondaryText,
                              size: 18,
                            ),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  r.patientName,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (r.isUrgent)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withValues(
                                      alpha: 0.15,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.error,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: const Text(
                                    'CRITICAL',
                                    style: TextStyle(
                                      color: AppColors.error,
                                      fontSize: 7.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                r.testName,
                                style: AppTextStyles.bodySmall.copyWith(
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationDesk(
    BuildContext context,
    LabReport? report,
    DoctorDashboardViewModel notifier,
  ) {
    if (report == null) return _buildEmptyVerificationState();

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.surface,
                child: Icon(
                  Icons.biotech_rounded,
                  color: AppColors.primaryLight,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.patientName,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'LIS Order ID: ${report.id} · Sample Drawn: ${report.orderedDate}',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 20),
          Expanded(
            child: ListView(
              children: [
                _buildSectionHeader('Lab Panel Investigation'),
                const SizedBox(height: 6),
                Text(
                  report.testName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('Laboratory Quantifications & Readings'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: report.isUrgent
                          ? AppColors.error.withValues(alpha: 0.3)
                          : AppColors.border,
                      width: report.isUrgent ? 1.2 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.science_outlined,
                            color: report.isUrgent
                                ? AppColors.error
                                : AppColors.primaryLight,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Laboratory Output Log',
                            style: AppTextStyles.labelSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        report.resultSummary,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('LIS Timeline & Logs'),
                const SizedBox(height: 8),
                _buildTimelineItem('Sample Drawn', '08:30 AM', true),
                _buildTimelineItem(
                  'Accessioned in LIS Analyzer',
                  '09:05 AM',
                  true,
                ),
                _buildTimelineItem(
                  'Quantified & Verified by Pathologist',
                  '09:40 AM',
                  true,
                ),
                const SizedBox(height: 16),
                _buildSectionHeader('Validation Compliance'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.verified_user_rounded,
                      color: AppColors.success,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'ABDM compliant electronic signature queued',
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border, height: 20),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  icon: const Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: Colors.orange,
                  ),
                  label: const Text(
                    'Re-Verify Sample',
                    style: TextStyle(color: Colors.orange),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Verification order queued: Re-test requested for Patient ${report.patientName}.',
                        ),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.gesture_rounded, size: 18),
                  label: const Text('Approve & E-Sign'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    notifier.approveReport(report.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Lab Report ${report.id} electronically signed & approved.',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.labelSmall.copyWith(
        color: AppColors.secondaryText,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildTimelineItem(String title, String time, bool isDone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isDone
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: isDone ? AppColors.success : AppColors.border,
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 11,
                color: isDone ? AppColors.primaryText : AppColors.secondaryText,
              ),
            ),
          ),
          Text(
            time,
            style: AppTextStyles.bodySmall.copyWith(
              fontSize: 10,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyQueueState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.verified_rounded, size: 48, color: AppColors.success),
          SizedBox(height: 12),
          Text(
            'Lab Results Queue Clear',
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'All clinical laboratory tests have been signed off.',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyVerificationState() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.science_outlined,
              size: 48,
              color: AppColors.secondaryText,
            ),
            SizedBox(height: 12),
            Text(
              'Select Lab Result',
              style: TextStyle(
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Choose a report from LIS queue to display readings.',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
