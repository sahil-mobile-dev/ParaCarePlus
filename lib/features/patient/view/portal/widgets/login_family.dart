import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';

/// Family login tab for Patient Portal.
/// Shows 4-column avatar grid with linked family profiles and an Add Member card.
class LoginFamily extends StatefulWidget {
  final VoidCallback onSuccess;

  const LoginFamily({super.key, required this.onSuccess});

  @override
  State<LoginFamily> createState() => _LoginFamilyState();
}

class _LoginFamilyState extends State<LoginFamily> {
  String _selectedId = 'self';

  static const _profiles = [
    _FamilyProfile(
      id: 'self',
      initial: 'R',
      name: 'Rahul Sharma',
      relation: 'Self',
      age: '34yr',
      gradientColors: [Color(0xFF00B4D8), Color(0xFF4361EE)],
    ),
    _FamilyProfile(
      id: 'spouse',
      initial: 'P',
      name: 'Priya Sharma',
      relation: 'Spouse',
      age: '31yr',
      gradientColors: [Color(0xFFF72585), Color(0xFFC77DFF)],
    ),
    _FamilyProfile(
      id: 'son',
      initial: 'A',
      name: 'Aarav',
      relation: 'Son',
      age: '8yr',
      gradientColors: [Color(0xFF00C897), Color(0xFF0D9488)],
    ),
    _FamilyProfile(
      id: 'father',
      initial: 'S',
      name: 'Suresh Sharma',
      relation: 'Father',
      age: '62yr',
      gradientColors: [Color(0xFFFF8F00), Color(0xFFF9A825)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD166).withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFD166).withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.groups_rounded,
                color: Color(0xFFFFD166),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Family Account Login',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Select a family member to sign in as',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Info strip
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 15,
                color: Color(0xFF00B4D8),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'All family members are linked to your primary mobile. '
                  'Select a profile and authenticate to continue.',
                  style: TextStyle(color: Color(0xFF7A9BBF), fontSize: 10.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // 4-column profile grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.60,
          ),
          itemCount: _profiles.length + 1, // +1 for "Add Member"
          itemBuilder: (context, i) {
            if (i < _profiles.length) {
              final p = _profiles[i];
              return _buildProfileCard(p);
            }
            return _buildAddMemberCard();
          },
        ),
        const SizedBox(height: AppSpacing.lg),

        // Selected profile info
        if (_selectedId.isNotEmpty)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.success,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Selected: ${_profiles.firstWhere((p) => p.id == _selectedId, orElse: () => _profiles[0]).name} '
                    '(${_profiles.firstWhere((p) => p.id == _selectedId, orElse: () => _profiles[0]).relation})',
                    style: const TextStyle(
                      color: AppColors.success,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpacing.md),

        AppButton(
          text: 'Continue as Selected Member',
          icon: Icons.arrow_forward_rounded,
          onPressed: widget.onSuccess,
        ),
        const SizedBox(height: AppSpacing.md),

        // ABHA family link note
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF1E3A5F)),
          ),
          child: const Row(
            children: [
              Icon(Icons.link_rounded, size: 15, color: Color(0xFF00C897)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Family profiles are linked via ABHA Family Health ID. '
                  'Each member gets individual consent and data access.',
                  style: TextStyle(color: Color(0xFF7A9BBF), fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileCard(_FamilyProfile p) {
    final isSelected = _selectedId == p.id;
    return GestureDetector(
      onTap: () => setState(() => _selectedId = p.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.success.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.success : const Color(0xFF1E3A5F),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: p.gradientColors),
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.success, width: 2)
                    : null,
              ),
              child: Center(
                child: Text(
                  p.initial,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              p.name.split(' ').first,
              style: const TextStyle(
                color: Color(0xFFE2E8F0),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              p.relation,
              style: const TextStyle(color: Color(0xFF7A9BBF), fontSize: 9),
            ),
            Text(
              p.age,
              style: const TextStyle(color: Color(0xFF4A6A8A), fontSize: 9),
            ),
            if (isSelected)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMemberCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF4A6A8A),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_circle_outline_rounded,
              color: Color(0xFF4A6A8A),
              size: 26,
            ),
            SizedBox(height: 5),
            Text(
              'Add\nMember',
              style: TextStyle(color: Color(0xFF4A6A8A), fontSize: 9),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FamilyProfile {
  final String id;
  final String initial;
  final String name;
  final String relation;
  final String age;
  final List<Color> gradientColors;

  const _FamilyProfile({
    required this.id,
    required this.initial,
    required this.name,
    required this.relation,
    required this.age,
    required this.gradientColors,
  });
}
