import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class LoginInfoSection extends StatefulWidget {
  const LoginInfoSection({super.key});

  @override
  State<LoginInfoSection> createState() => _LoginInfoSectionState();
}

class _LoginInfoSectionState extends State<LoginInfoSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  static const _features = [
    (
      icon: '🩺',
      title: 'Complete OPD/IPD',
      sub: 'Registration, tokens, bed management, ADT',
    ),
    (
      icon: '💊',
      title: 'Integrated Pharmacy',
      sub: 'Dispensing, inventory, expiry alerts, MAR',
    ),
    (
      icon: '🧪',
      title: 'LIS / Pathology',
      sub: 'Sample lifecycle, auto-flagging, alerts',
    ),
    (
      icon: '🩻',
      title: 'Radiology RIS/PACS',
      sub: 'Worklist, reporting, AI findings, DICOM',
    ),
    (
      icon: '💳',
      title: 'Financial Management',
      sub: 'Billing, insurance, AB-PMJAY analytics',
    ),
    (
      icon: '🚑',
      title: 'Live Ambulance Map',
      sub: 'GPS tracking, dispatch, ETA, fleet mgmt',
    ),
    (
      icon: '🩸',
      title: 'Blood Bank',
      sub: '8-group inventory, cross-match, donors',
    ),
    (
      icon: '👥',
      title: 'HR & Payroll',
      sub: 'Staff, attendance, rosters, salary, leave',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Floating hospital logo
        ClipRRect(
          borderRadius: const BorderRadiusGeometry.vertical(
            top: Radius.circular(30),
            bottom: Radius.circular(20),
          ),
          child: Image.asset(
            'assets/images/para_care_logo.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Version badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: const Text(
            '● ParaCare+ HIMS v3.0 — Enterprise Edition',
            style: TextStyle(
              color: Color(0xFF90CAF9),
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Hero title with gradient
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.15,
              letterSpacing: -0.5,
            ),
            children: [
              const TextSpan(text: 'World-Class\nABDM-Compliant '),
              TextSpan(
                text: 'HIMS',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFFFF8F00), Color(0xFFF9A825)],
                    ).createShader(const Rect.fromLTWH(0, 0, 120, 48)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        const Text(
          'An end-to-end, AI-enabled Hospital Information System for the '
          'Government of Uttarakhand — integrating all clinical, financial, '
          'and administrative workflows into a single unified platform.',
          style: TextStyle(
            color: Color(0xFF8AB0D0),
            fontSize: 13.5,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 8-card feature grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 3.2,
          children: _features.map(_buildFeatureCard).toList(),
        ),
      ],
    );
  }

  Widget _buildFeatureCard(({String icon, String title, String sub}) f) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Text(f.icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  f.title,
                  style: const TextStyle(
                    color: Color(0xFFC8DFF0),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  f.sub,
                  style: const TextStyle(
                    color: Color(0xFF5A7A8E),
                    fontSize: 9.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
