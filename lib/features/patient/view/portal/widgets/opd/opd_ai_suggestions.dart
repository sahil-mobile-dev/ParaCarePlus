import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class OpdAiSuggestions extends StatelessWidget {
  const OpdAiSuggestions({super.key});

  Widget buildAiCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required String confidence,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.04),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.purpleAccent, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 11.5,
                height: 1.35,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              confidence,
              style: const TextStyle(
                color: Colors.purpleAccent,
                fontSize: 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 600;

    final List<Map<String, dynamic>> suggestions = [
      {
        'icon': Icons.favorite_rounded,
        'title': 'Cardiology — Priority',
        'desc':
            'Your BP has risen 8 mmHg this week. AI recommends an urgent cardiology review within 5 days.',
        'conf': '94% confidence',
      },
      {
        'icon': Icons.water_drop_rounded,
        'title': 'Endocrinology',
        'desc':
            'HbA1c 7.4% needs review. Diabetologist consultation recommended this month.',
        'conf': '91% confidence',
      },
      {
        'icon': Icons.remove_red_eye_rounded,
        'title': 'Diabetic Eye Check',
        'desc':
            'Annual diabetic retinopathy screening overdue (last: Jun 2024). Schedule ophthalmology visit.',
        'conf': '88% confidence',
      },
      {
        'icon': Icons.donut_small_rounded,
        'title': 'Kidney Function',
        'desc':
            'KFT was borderline in Sep 2025. 6-monthly recheck recommended — now overdue.',
        'conf': '82% confidence',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.psychology_rounded,
                color: Colors.purpleAccent,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'AI Doctor Suggestions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWide ? 2 : 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: isWide ? 1.7 : 2.9,
            ),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              final sug = suggestions[index];
              return buildAiCard(
                context: context,
                icon: sug['icon'] as IconData,
                title: sug['title'] as String,
                description: sug['desc'] as String,
                confidence: sug['conf'] as String,
              );
            },
          ),
        ],
      ),
    );
  }
}
