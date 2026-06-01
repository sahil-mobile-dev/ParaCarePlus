import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class FamilyMemberCard extends StatelessWidget {
  const FamilyMemberCard({super.key});

  @override
  Widget build(BuildContext context) {
    final members = <Map<String, dynamic>>[
      {
        'name': 'Ramesh Kumar',
        'relation': 'Self · 48 yrs · Male',
        'wellnessScore': 78,
        'wellnessColor': AppColors.secondaryAccent,
        'stats': [
          {'lbl': 'BP', 'val': '128/82', 'color': AppColors.secondaryAccent},
          {'lbl': 'Sugar', 'val': '142', 'color': Colors.orange},
          {'lbl': 'BMI', 'val': '26.2', 'color': AppColors.secondaryAccent},
        ],
        'conditions': ['HTN', 'Pre-DM', 'Hyperlipidemia'],
        'alertText': '3 AI alerts — review HbA1c & BP',
        'alertColor': AppColors.secondaryAccent,
        'avatarGradient': const [Color(0xFF00B4D8), Color(0xFF3A86FF)],
        'avatarIcon': Icons.person_rounded,
        'actions': [
          {'label': 'View', 'msg': 'Opening Ramesh health profile…'},
          {'label': 'EMR', 'msg': 'Opening Ramesh EMR…'},
          {'label': 'Book', 'msg': 'Booking appointment for Ramesh…'},
        ],
      },
      {
        'name': 'Geeta Kumar',
        'relation': 'Spouse · 46 yrs · Female',
        'wellnessScore': 84,
        'wellnessColor': AppColors.success,
        'stats': [
          {'lbl': 'BP', 'val': '114/74', 'color': AppColors.success},
          {'lbl': 'Hb', 'val': '11.6', 'color': AppColors.secondaryAccent},
          {'lbl': 'BMI', 'val': '23.4', 'color': AppColors.success},
        ],
        'conditions': ['Osteopenia', 'Mild Anemia'],
        'alertText': 'Calcium + Vit D supplement needed',
        'alertColor': AppColors.secondaryAccent,
        'avatarGradient': const [Color(0xFFF72585), Color(0xFFC77DFF)],
        'avatarIcon': Icons.person_3_rounded,
        'actions': [
          {'label': 'View', 'msg': 'Opening Geeta health profile…'},
          {'label': 'EMR', 'msg': 'Opening Geeta EMR…'},
          {'label': 'Book', 'msg': 'Booking appointment for Geeta…'},
        ],
      },
      {
        'name': 'Aryan Kumar',
        'relation': 'Son · 22 yrs · Male',
        'wellnessScore': 92,
        'wellnessColor': AppColors.success,
        'stats': [
          {'lbl': 'BP', 'val': '118/76', 'color': AppColors.success},
          {'lbl': 'Hb', 'val': '15.2', 'color': AppColors.success},
          {'lbl': 'BMI', 'val': '22.5', 'color': AppColors.success},
        ],
        'conditions': ['Healthy'],
        'alertText': 'No active health alerts',
        'alertColor': AppColors.success,
        'avatarGradient': const [Color(0xFF00C897), Color(0xFF0D9488)],
        'avatarIcon': Icons.person_2_rounded,
        'actions': [
          {'label': 'View', 'msg': 'Opening Aryan health profile…'},
          {'label': 'EMR', 'msg': 'Opening Aryan EMR…'},
          {'label': 'Book', 'msg': 'Booking appointment for Aryan…'},
        ],
      },
      {
        'name': 'Priya Kumar',
        'relation': 'Daughter · 18 yrs · Female',
        'wellnessScore': 88,
        'wellnessColor': AppColors.primaryLight,
        'stats': [
          {'lbl': 'BP', 'val': '110/70', 'color': AppColors.success},
          {'lbl': 'Hb', 'val': '12.4', 'color': AppColors.secondaryAccent},
          {'lbl': 'BMI', 'val': '20.6', 'color': AppColors.success},
        ],
        'conditions': ['Borderline Hb'],
        'alertText': 'Dental checkup pending',
        'alertColor': AppColors.secondaryAccent,
        'avatarGradient': const [Color(0xFFF77F00), Color(0xFFFFD166)],
        'avatarIcon': Icons.person_4_rounded,
        'actions': [
          {'label': 'View', 'msg': 'Opening Priya health profile…'},
          {'label': 'EMR', 'msg': 'Opening Priya EMR…'},
          {'label': 'Dental', 'msg': 'Booking dental for Priya…'},
        ],
      },
      {
        'name': 'Savitri Devi',
        'relation': 'Mother · 74 yrs · Female',
        'wellnessScore': 68,
        'wellnessColor': AppColors.secondaryAccent,
        'stats': [
          {'lbl': 'BP', 'val': '142/88', 'color': AppColors.error},
          {'lbl': 'Sugar', 'val': '168', 'color': Colors.orange},
          {'lbl': 'BMI', 'val': '27.8', 'color': AppColors.secondaryAccent},
        ],
        'conditions': ['T2 Diabetes', 'HTN Stage 2', 'Osteoarthritis'],
        'alertText': 'BP elevated — consult needed',
        'alertColor': AppColors.error,
        'avatarGradient': const [Color(0xFF4361EE), Color(0xFFC77DFF)],
        'avatarIcon': Icons.elderly_rounded,
        'actions': [
          {'label': 'View', 'msg': 'Opening Savitri health profile…'},
          {'label': 'EMR', 'msg': 'Opening Savitri EMR…'},
          {'label': 'Book', 'msg': 'Booking appointment for Savitri…'},
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(Icons.badge_rounded, color: AppColors.primaryLight, size: 18),
            SizedBox(width: 8),
            Text('FAMILY HEALTH PROFILES', style: AppTextStyles.labelSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final crossAxisCount = width > 1200 ? 3 : (width > 768 ? 2 : 1);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length + 1,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.45,
              ),
              itemBuilder: (context, index) {
                if (index == members.length) {
                  return _buildAddMemberCard(context);
                }

                final m = members[index];
                final gradientColors = m['avatarGradient'] as List<Color>;
                final avatarIcon = m['avatarIcon'] as IconData;
                final conditions = m['conditions'] as List<String>;
                final stats = m['stats'] as List<Map<String, dynamic>>;
                final actions = m['actions'] as List<Map<String, String>>;
                final alertColor = m['alertColor'] as Color;

                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradientColors,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                avatarIcon,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    m['name'] as String,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    m['relation'] as String,
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              children: [
                                Text(
                                  '${m['wellnessScore']}',
                                  style: TextStyle(
                                    color: m['wellnessColor'] as Color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const Text(
                                  'WELLNESS',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Stats Row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          children: stats.map((st) {
                            final sc = st['color'] as Color;
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(right: 6),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      (st['lbl'] as String?) ?? '',
                                      style: const TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 9,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      (st['val'] as String?) ?? '',
                                      style: TextStyle(
                                        color: sc,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Conditions Tags
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: conditions.map((cond) {
                            final isActive = cond != 'Healthy';
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.error.withValues(alpha: 0.12)
                                    : Colors.white.withValues(alpha: 0.06),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                cond,
                                style: TextStyle(
                                  color: isActive
                                      ? AppColors.error
                                      : AppColors.secondaryText,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const Spacer(),

                      // Alerts Strip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 4,
                        ),
                        color: Colors.white.withValues(alpha: 0.02),
                        child: Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: alertColor,
                              size: 11,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                m['alertText'] as String,
                                style: TextStyle(
                                  color: alertColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Actions Button bar
                      Container(
                        color: AppColors.surface,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: Row(
                          children: actions.map((act) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                child: OutlinedButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(act['msg'] ?? ''),
                                        backgroundColor: AppColors.primaryLight,
                                      ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                      color: AppColors.border,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                    ),
                                    minimumSize: Size.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(
                                    act['label'] ?? '',
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildAddMemberCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border, style: BorderStyle.none),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening Link New Family Member Form...'),
                backgroundColor: AppColors.primaryLight,
              ),
            );
          },
          borderRadius: BorderRadius.circular(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_add_rounded,
                  color: AppColors.primaryLight,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'LINK NEW MEMBER',
                style: TextStyle(
                  color: AppColors.primaryLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 11.5,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Add ABHA or National ID',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
