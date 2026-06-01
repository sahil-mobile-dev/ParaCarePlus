import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class RadiologyAiPanel extends StatelessWidget {
  const RadiologyAiPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFC77DFF).withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color(0xFFC77DFF).withValues(alpha: 0.2),
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.smart_toy_rounded,
                color: Color(0xFFC77DFF),
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'AI-Assisted Imaging Analysis',
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 800
                  ? 4
                  : (constraints.maxWidth > 500 ? 2 : 1);
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 2.2,
                children: [
                  _buildAiCard(
                    title: 'Cardiomegaly Detection',
                    percentage: '87%',
                    color: AppColors.secondaryAccent,
                    barValue: 0.87,
                    desc:
                        'CT ratio 0.51 — borderline cardiomegaly. Recommend echo for confirmation.',
                  ),
                  _buildAiCard(
                    title: 'Lung Field Clear',
                    percentage: '98%',
                    color: AppColors.success,
                    barValue: 0.98,
                    desc:
                        'No consolidation, effusion, or pneumothorax detected. Bilateral lung fields clear.',
                  ),
                  _buildAiCard(
                    title: 'No Pneumonia Signs',
                    percentage: '96%',
                    color: AppColors.success,
                    barValue: 0.96,
                    desc:
                        'No haziness or airspace opacification in any lung zone. Trachea central.',
                  ),
                  _buildAiCard(
                    title: 'Diaphragm Level Normal',
                    percentage: '94%',
                    color: AppColors.success,
                    barValue: 0.94,
                    desc:
                        'Both hemidiaphragms clearly delineated. Costophrenic angles acute.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAiCard({
    required String title,
    required String percentage,
    required Color color,
    required double barValue,
    required String desc,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    percentage,
                    style: TextStyle(
                      color: color,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 40,
                    height: 4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: barValue,
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            desc,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 8,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
