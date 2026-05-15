import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/model/dashboard_models.dart';
import 'package:intl/intl.dart';

class ActivityFeed extends StatelessWidget {
  final List<ActivityFeedItem> items;

  const ActivityFeed({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Live Activity Feed', style: AppTextStyles.titleMedium),
            TextButton(
              onPressed: () {},
              child: const Text('View All', style: AppTextStyles.labelSmall),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(color: AppColors.border, height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ActivityIcon(type: item.type),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                            Text(
                              DateFormat('HH:mm').format(item.timestamp),
                              style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.description,
                          style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ActivityIcon extends StatelessWidget {
  final ActivityType type;

  const _ActivityIcon({required this.type});

  @override
  Widget build(BuildContext context) {
    Color color;
    IconData icon;

    switch (type) {
      case ActivityType.registration:
        color = AppColors.primary;
        icon = Icons.person_add;
        break;
      case ActivityType.emergency:
        color = AppColors.error;
        icon = Icons.emergency;
        break;
      case ActivityType.labResult:
        color = AppColors.secondaryAccent;
        icon = Icons.science;
        break;
      case ActivityType.admission:
        color = AppColors.success;
        icon = Icons.hotel;
        break;
      default:
        color = AppColors.secondaryText;
        icon = Icons.info;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }
}
