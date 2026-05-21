import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/tpa/view/tabs/claims_tab.dart';
import 'package:paracareplus/features/tpa/view/tabs/directory_tab.dart';
import 'package:paracareplus/features/tpa/view/tabs/disputes_tab.dart';
import 'package:paracareplus/features/tpa/view/tabs/overview_tab.dart';
import 'package:paracareplus/features/tpa/view/tabs/preauth_tab.dart';
import 'package:paracareplus/features/tpa/view_model/tpa_view_model.dart';

class TpaScreen extends ConsumerWidget {
  const TpaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTab = ref.watch(tpaTabProvider);
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 1200;

    Widget bodyContent;
    switch (activeTab) {
      case 'Overview':
        bodyContent = const OverviewTab();
      case 'Pre-Auth Queue':
        bodyContent = const PreauthTab();
      case 'Claims Settlement':
        bodyContent = const ClaimsTab();
      case 'TPA Directory':
        bodyContent = const DirectoryTab();
      case 'Disputes & Rejections':
        bodyContent = const DisputesTab();
      default:
        bodyContent = const OverviewTab();
    }

    final Widget mainContent = Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            _buildHimsBanner(context),
            const SizedBox(height: AppSpacing.lg),
            _buildTelemetryGrid(),
            const SizedBox(height: AppSpacing.xl),
            _buildTpaTabBar(ref, activeTab),
            const SizedBox(height: AppSpacing.lg),
            bodyContent,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Third-Party Administrator (TPA) & Insurance Portal'),
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

  Widget _buildHimsBanner(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccent.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  'उत्तराखंड',
                  style: TextStyle(
                    color: AppColors.secondaryAccent,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GOVERNMENT OF UTTARAKHAND — HEALTH & FAMILY WELFARE',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.secondaryText,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Synergy MultiSpeciality Hospital | ParaCare+ HIMS v3.0',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (isMobile) const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _buildStatusPill('System Online', AppColors.success),
              const SizedBox(width: 8),
              _buildStatusPill('Thursday, 21 May 2026', AppColors.primary),
              const SizedBox(width: 8),
              _buildStatusPill('ABDM Synced', AppColors.secondaryAccent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPill(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTelemetryGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900
            ? 5
            : (constraints.maxWidth > 600 ? 3 : 2);
        return GridView.count(
          crossAxisCount: columns,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            _telemetryCard(
              'Co-Partnered TPAs',
              '12 Active',
              AppColors.primary,
              Icons.business_rounded,
            ),
            _telemetryCard(
              'Settled Amount',
              '₹1.84 Cr',
              AppColors.success,
              Icons.check_circle_outline_rounded,
            ),
            _telemetryCard(
              'Settlement Ratio',
              '96.2%',
              AppColors.success,
              Icons.thumb_up_rounded,
            ),
            _telemetryCard(
              'Claims Rejection',
              '3.4%',
              AppColors.error,
              Icons.gpp_bad_rounded,
            ),
            _telemetryCard(
              'Disputed Cases',
              '03 Active',
              AppColors.secondaryAccent,
              Icons.gpp_maybe_rounded,
            ),
          ],
        );
      },
    );
  }

  Widget _telemetryCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, color: color, size: 16),
            ],
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

  Widget _buildTpaTabBar(WidgetRef ref, String activeTab) {
    final tabs = <String>[
      'Overview',
      'Pre-Auth Queue',
      'Claims Settlement',
      'TPA Directory',
      'Disputes & Rejections',
    ];

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final isSelected = activeTab == tab;
            return GestureDetector(
              onTap: () {
                ref.read(tpaTabProvider.notifier).state = tab;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tab,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isSelected
                        ? AppColors.primaryText
                        : AppColors.secondaryText,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
