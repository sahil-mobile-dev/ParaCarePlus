import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

/// Left branding panel for the Patient Portal login page.
/// Matches patient-login.html left panel design.
class LoginLeftPanel extends StatelessWidget {
  const LoginLeftPanel({super.key});

  static const _pills = [
    (icon: Icons.credit_card_rounded, label: 'ABHA ID Login'),
    (icon: Icons.phone_android_rounded, label: 'Mobile OTP'),
    (icon: Icons.fingerprint_rounded, label: 'Biometric Auth'),
    (icon: Icons.face_retouching_natural_rounded, label: 'Face Recognition'),
    (icon: Icons.groups_rounded, label: 'Family Accounts'),
    (icon: Icons.shield_rounded, label: 'Consent Manager'),
    (icon: Icons.qr_code_scanner_rounded, label: 'Scan & Share'),
    (icon: Icons.lock_rounded, label: 'Emergency PIN'),
  ];

  static const _abdmBadges = [
    'ABHA 2.0', 'HIP/HIU', 'FHIR R4', 'PHR App', 'Health Locker',
    'Consent Mgr',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBrand(),
        const SizedBox(height: AppSpacing.xl),
        _buildHeroSection(),
        const SizedBox(height: AppSpacing.lg),
        _buildAbdmStrip(),
      ],
    );
  }

  Widget _buildBrand() {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00B4D8), Color(0xFF4361EE)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00B4D8).withValues(alpha: 0.35),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(Icons.favorite_rounded, color: Colors.white, size: 22),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ParaCare+',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              'Govt. of Uttarakhand · Dept. of Health',
              style: TextStyle(color: Color(0xFF7A9BBF), fontSize: 11),
            ),
            const Text(
              'By Parakore Enterprises Pvt Ltd',
              style: TextStyle(
                color: Color(0xFF4A6A8A),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text(
              'ParaCare — Patient Portal',
              style: TextStyle(color: Color(0xFF4A6A8A), fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Live badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF00B4D8).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                color: const Color(0xFF00B4D8).withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulseDot(color: const Color(0xFF00C897)),
              const SizedBox(width: 8),
              const Text(
                'Secure Patient Access Portal v4.0',
                style: TextStyle(
                  color: Color(0xFF00B4D8),
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Hero title
        RichText(
          text: TextSpan(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
            children: [
              const TextSpan(text: 'Your Health,\n'),
              TextSpan(
                text: 'One Identity.',
                style: TextStyle(
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFF00B4D8), Color(0xFF4361EE)],
                    ).createShader(const Rect.fromLTWH(0, 0, 240, 40)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),

        // Hero sub (with Devanagari)
        const Text(
          'Access your complete health records, appointments, lab reports and more.',
          style: TextStyle(
            color: Color(0xFF7A9BBF),
            fontSize: 13,
            height: 1.7,
          ),
        ),
        const Text(
          'अपने स्वास्थ्य रिकॉर्ड, अपॉइंटमेंट और दवाइयों तक तुरंत पहुँचें।',
          style: TextStyle(
            color: Color(0xFF4A6A8A),
            fontSize: 12,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Feature pills (8)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _pills.map(_buildPill).toList(),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Stats row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _StatItem(value: '42L+', label: 'Registered\nPatients'),
            _StatItem(value: '3,200+', label: 'Health\nFacilities'),
            _StatItem(value: '99.8%', label: 'Uptime\nSLA'),
            _StatItem(value: '256-bit', label: 'Encryption'),
          ],
        ),
      ],
    );
  }

  Widget _buildPill(({IconData icon, String label}) pill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        border: Border.all(color: const Color(0xFF1E3A5F)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(pill.icon, size: 14, color: const Color(0xFF00B4D8)),
          const SizedBox(width: 7),
          Text(
            pill.label,
            style: const TextStyle(color: Color(0xFFE2E8F0), fontSize: 11.5),
          ),
        ],
      ),
    );
  }

  Widget _buildAbdmStrip() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF00C897).withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: const Color(0xFF00C897).withValues(alpha: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded,
              color: Color(0xFF00C897), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ABDM Compliant — Ayushman Bharat Digital Mission',
                  style: TextStyle(
                    color: Color(0xFF00C897),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Certified under NHA standards. All data stored as FHIR R4 resources.',
                  style: TextStyle(color: Color(0xFF7A9BBF), fontSize: 10.5),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: _abdmBadges
                      .map(
                        (b) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C897).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: const Color(0xFF00C897).withValues(alpha: 0.25)),
                          ),
                          child: Text(
                            b,
                            style: const TextStyle(
                              color: Color(0xFF00C897),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────
// Helper widgets
// ────────────────────────────
class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1).animate(_ctrl),
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF00B4D8),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF7A9BBF),
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
