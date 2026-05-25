import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class RadiologyKpiGrid extends StatelessWidget {
  const RadiologyKpiGrid({super.key});

  static final List<Map<String, dynamic>> _kpis = [
    {
      'label': 'Total Imaging Studies',
      'val': '14',
      'sub': 'Last 3 years',
      'icon': Icons.photo_library_rounded,
      'badge': 'OK',
      'badgeType': 'ok',
      'color': const Color(0xFF00B4D8),
    },
    {
      'label': 'Abnormal Findings',
      'val': '2',
      'sub': 'Needs follow-up',
      'icon': Icons.warning_amber_rounded,
      'badge': 'FOLLOW UP',
      'badgeType': 'alert',
      'color': AppColors.error,
    },
    {
      'label': 'Pending Reports',
      'val': '1',
      'sub': 'MRI report awaited',
      'icon': Icons.hourglass_empty_rounded,
      'badge': 'WAITING',
      'badgeType': 'warn',
      'color': AppColors.secondaryAccent,
    },
    {
      'label': 'Normal Findings',
      'val': '11',
      'sub': 'Within normal limits',
      'icon': Icons.check_circle_outline_rounded,
      'badge': 'NORMAL',
      'badgeType': 'ok',
      'color': AppColors.success,
    },
    {
      'label': 'AI Detection Accuracy',
      'val': '94.2%',
      'sub': 'Last 10 scans',
      'icon': Icons.psychology_rounded,
      'badge': 'ACCURATE',
      'badgeType': 'ok',
      'color': const Color(0xFFC77DFF),
    },
    {
      'label': 'Last Imaging Date',
      'val': '28 Apr',
      'sub': 'Chest X-Ray done',
      'icon': Icons.calendar_month_rounded,
      'badge': 'RECENT',
      'badgeType': 'due',
      'color': AppColors.primaryLight,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900
            ? 6
            : (constraints.maxWidth > 600 ? 3 : 2);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.45,
          ),
          itemCount: _kpis.length,
          itemBuilder: (context, index) {
            final k = _kpis[index];
            return _buildKpiCard(k);
          },
        );
      },
    );
  }

  Widget _buildKpiCard(Map<String, dynamic> kpi) {
    final color = kpi['color'] as Color;
    final icon = kpi['icon'] as IconData;
    final val = kpi['val'] as String;
    final label = kpi['label'] as String;
    final sub = kpi['sub'] as String;
    final badge = kpi['badge'] as String;
    final badgeType = kpi['badgeType'] as String;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 3,
              child: Container(color: color),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(icon, color: color, size: 16),
                      _buildBadge(badge, badgeType),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
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
                            color: Colors.white,
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
                  ),
                ],
              ),
            ),
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1.5),
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
