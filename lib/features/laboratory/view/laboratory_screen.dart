import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/laboratory/view/tabs/analyzer_config_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/critical_values_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/reports_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/result_entry_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/sample_queue_tab.dart';
import 'package:paracareplus/features/laboratory/view/tabs/urgent_stat_tab.dart';
import 'package:paracareplus/features/laboratory/view_model/laboratory_view_model.dart';

class LaboratoryScreen extends ConsumerWidget {
  const LaboratoryScreen({super.key});

  // Method to open specimen collection registration dialog
  void _showNewSampleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Register Specimen Collection',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.secondaryText,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(color: AppColors.border, height: 1),
                const SizedBox(height: 16),
                const Text(
                  'PATIENT INFORMATION',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildModalTextField(
                  'Patient MRN / Search Name',
                  'e.g. MRN-99812',
                ),
                const SizedBox(height: 16),
                const Text(
                  'TEST DETAILS',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildModalTextField(
                  'Select Prescribed Test Profile',
                  'e.g. Complete Blood Count (CBC)',
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildModalTextField(
                        'Container Type',
                        'e.g. Lavender EDTA',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildModalTextField(
                        'Specimen Volume',
                        'e.g. 3.0 mL',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        foregroundColor: AppColors.secondaryText,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('CANCEL'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.success,
                            content: Text(
                              'Specimen Registered Successfully! Barcode label printed and sent to queue.',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'REGISTER SPECIMEN',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 11),
        ),
        const SizedBox(height: 6),
        TextField(
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 12,
            ),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(laboratoryTabProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (activeTab) {
      case 'Sample Queue':
        bodyContent = const SampleQueueTab();
      case 'Urgent / STAT':
        bodyContent = const UrgentStatTab();
      case 'Result Entry':
        bodyContent = const ResultEntryTab();
      case 'Critical Values':
        bodyContent = const CriticalValuesTab();
      case 'Reports':
        bodyContent = const ReportsTab();
      case 'Analyzer Config':
        bodyContent = const AnalyzerConfigTab();
      default:
        bodyContent = const SampleQueueTab();
    }

    final Widget mainContent = Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),

            // 2. Pathology Quick Actions Toolbar
            _buildQuickActionsToolbar(context, ref),
            const SizedBox(height: AppSpacing.lg),

            // 3. Telemetry HIMS Analytics counters
            _buildTelemetryAnalyticsGrid(),
            const SizedBox(height: AppSpacing.xl),

            // 4. Tab selection selector
            _buildLaboratoryTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),

            // 5. Active Sub-Tab view content
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Laboratory / Pathology'),
        backgroundColor: AppColors.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [if (isWide) const AppSidebar(), mainContent],
        ),
      ),
    );
  }

  Widget _buildQuickActionsToolbar(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    title: '🚨 Urgent Test',
                    subtitle: 'Clinical Priority Dispatch',
                    color: AppColors.secondaryAccent,
                    onTap: () {
                      ref.read(laboratoryTabProvider.notifier).state =
                          'Urgent / STAT';
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    title: '➕ New Sample',
                    subtitle: 'Specimen Barcode Entry',
                    color: AppColors.primary,
                    onTap: () => _showNewSampleDialog(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    title: '📊 Enter Result',
                    subtitle: 'Write Diagnostics Values',
                    color: AppColors.success,
                    onTap: () {
                      ref.read(laboratoryTabProvider.notifier).state =
                          'Result Entry';
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 36,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.secondaryText,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTelemetryAnalyticsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900
            ? 6
            : (constraints.maxWidth > 600 ? 3 : 2);
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: [
            _buildTelemetryCard('Samples In Queue', '12', AppColors.primary),
            _buildTelemetryCard('Urgent / STAT', '02', AppColors.error),
            _buildTelemetryCard(
              'Critical Values',
              '02',
              AppColors.secondaryAccent,
            ),
            _buildTelemetryCard('Completed', '145', AppColors.success),
            _buildTelemetryCard('Avg TAT', '42 min', AppColors.primary),
            _buildTelemetryCard('Quality Score', '99.4%', AppColors.success),
          ],
        );
      },
    );
  }

  Widget _buildTelemetryCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: AppTextStyles.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLaboratoryTabBar(WidgetRef ref, String activeTab) {
    final tabs = <String>[
      'Sample Queue',
      'Urgent / STAT',
      'Result Entry',
      'Critical Values',
      'Reports',
      'Analyzer Config',
    ];

    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final tab = tabs[index];
          final isSelected = activeTab == tab;
          final isUrgent = tab == 'Urgent / STAT';

          return GestureDetector(
            onTap: () {
              ref.read(laboratoryTabProvider.notifier).state = tab;
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  if (isUrgent)
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.notifications_active_rounded,
                        color: isSelected
                            ? AppColors.error
                            : AppColors.secondaryText,
                        size: 14,
                      ),
                    ),
                  Text(
                    tab,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: isSelected
                          ? AppColors.primaryText
                          : AppColors.secondaryText,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
