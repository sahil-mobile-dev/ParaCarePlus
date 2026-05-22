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
        'name': 'Ramesh Kumar (Self)',
        'relation': 'Self · Male · 48 yrs',
        'wellnessIndex': 0.82,
        'wellnessText': '82%',
        'primaryRisk': 'Hypertension, Pre-DM',
        'lastCheckup': '15 May 2026',
        'avatar': 'RK',
        'avatarColor': AppColors.primaryLight,
        'alert': false,
      },
      {
        'name': 'Geeta Kumar',
        'relation': 'Spouse · Female · 44 yrs',
        'wellnessIndex': 0.89,
        'wellnessText': '89%',
        'primaryRisk': 'None (Healthy)',
        'lastCheckup': '18 May 2026',
        'avatar': 'GK',
        'avatarColor': AppColors.success,
        'alert': false,
      },
      {
        'name': 'Savitri Devi',
        'relation': 'Mother · Female · 72 yrs',
        'wellnessIndex': 0.68,
        'wellnessText': '68%',
        'primaryRisk': 'Cardiac, Severe Arthritis',
        'lastCheckup': '22 Apr 2026',
        'avatar': 'SD',
        'avatarColor': AppColors.error,
        'alert': true,
      },
      {
        'name': 'Aryan Kumar',
        'relation': 'Son · Male · 14 yrs',
        'wellnessIndex': 0.94,
        'wellnessText': '94%',
        'primaryRisk': 'Seasonal Allergies',
        'lastCheckup': '05 Apr 2026',
        'avatar': 'AK',
        'avatarColor': Colors.teal,
        'alert': false,
      },
      {
        'name': 'Priya Kumar',
        'relation': 'Daughter · Female · 10 yrs',
        'wellnessIndex': 0.96,
        'wellnessText': '96%',
        'primaryRisk': 'None (Healthy)',
        'lastCheckup': '12 May 2026',
        'avatar': 'PK',
        'avatarColor': Colors.purpleAccent,
        'alert': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('FAMILY MEMBER DIRECTORY', style: AppTextStyles.labelSmall),
            Text(
              '5 ACTIVE',
              style: TextStyle(
                color: AppColors.success,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            final isLargeScreen = constraints.maxWidth > 900;
            final isMediumScreen = constraints.maxWidth > 600 && !isLargeScreen;

            if (isLargeScreen) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildMemberTile(context, members[0]),
                        const SizedBox(height: 8),
                        _buildMemberTile(context, members[1]),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      children: [
                        _buildMemberTile(context, members[2]),
                        const SizedBox(height: 8),
                        _buildMemberTile(context, members[3]),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      children: [
                        _buildMemberTile(context, members[4]),
                        const SizedBox(height: 8),
                        _buildAddMemberCard(context),
                      ],
                    ),
                  ),
                ],
              );
            } else if (isMediumScreen) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildMemberTile(context, members[0]),
                        const SizedBox(height: 8),
                        _buildMemberTile(context, members[1]),
                        const SizedBox(height: 8),
                        _buildMemberTile(context, members[2]),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      children: [
                        _buildMemberTile(context, members[3]),
                        const SizedBox(height: 8),
                        _buildMemberTile(context, members[4]),
                        const SizedBox(height: 8),
                        _buildAddMemberCard(context),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  for (final member in members) ...[
                    _buildMemberTile(context, member),
                    const SizedBox(height: 8),
                  ],
                  _buildAddMemberCard(context),
                ],
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildMemberTile(BuildContext context, Map<String, dynamic> m) {
    final wellnessVal = m['wellnessIndex'] as double;
    final wellnessColor = wellnessVal > 0.9
        ? AppColors.success
        : (wellnessVal > 0.8
              ? AppColors.primaryLight
              : AppColors.secondaryAccent);
    final strokeColor = (m['alert'] as bool)
        ? AppColors.error
        : AppColors.border;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: strokeColor,
          width: (m['alert'] as bool) ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: m['avatarColor'] as Color?,
                child: Text(
                  m['avatar'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            m['name'] as String,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (m['alert'] as bool) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error.withValues(alpha: 0.15),
                              border: Border.all(color: AppColors.error),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'ATTENTION',
                              style: TextStyle(
                                color: AppColors.error,
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      m['relation'] as String,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Circular progress score
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      value: wellnessVal,
                      strokeWidth: 3,
                      backgroundColor: AppColors.surface,
                      valueColor: AlwaysStoppedAnimation<Color>(wellnessColor),
                    ),
                  ),
                  Text(
                    m['wellnessText'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PRIMARY HEALTH METRICS',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 7.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    m['primaryRisk'] as String,
                    style: TextStyle(
                      color: (m['alert'] as bool)
                          ? AppColors.error
                          : Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'LAST CHECKUP',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 7.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    m['lastCheckup'] as String,
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Viewing Telemetry for ${m['name']}...'),
                        backgroundColor: AppColors.primaryLight,
                      ),
                    );
                  },
                  icon: const Icon(Icons.analytics_rounded, size: 12),
                  label: const Text(
                    'TELEMETRY',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Switched workspace context to ${m['name']}.',
                        ),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'FOCUS',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddMemberCard(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, style: BorderStyle.none),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Opening Link New Family Member Form...'),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
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
                  fontSize: 12,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Add ABHA or National ID',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
