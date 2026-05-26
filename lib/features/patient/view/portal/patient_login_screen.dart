import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_aadhaar.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_abha.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_face_auth.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_family.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_left_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_mobile_otp.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/login_tab_selector.dart';
import 'package:paracareplus/routes/route_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Patient Portal Login Screen — orchestrates the left brand panel,
/// 5-tab selector, and the active login method widget.
class PatientLoginScreen extends StatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  State<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  String _activeTab = 'mobile';

  void _switchTab(String tab) {
    setState(() => _activeTab = tab);
  }

  Future<void> _onLoginSuccess() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('user_role', 'patient');
    } catch (_) {}
    if (mounted) {
      context.goNamed(RouteNames.patientHome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071221),
      body: Stack(
        children: [
          // Background glowing orbs
          Positioned(
            top: -100,
            right: -80,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x1500B4D8), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -60,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x0E4361EE), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            left: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x0900C897), Colors.transparent],
                ),
              ),
            ),
          ),
          // Grid dot overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: CustomPaint(painter: _GridDotPainter()),
            ),
          ),
          // Content
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 900) {
                  return _buildTabletLayout();
                }
                return _buildMobileLayout();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  LAYOUTS
  // ─────────────────────────────────────────────────────────────

  Widget _buildTabletLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left brand panel
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xF30F2137), Color(0xF9071221)],
              ),
              border: Border(
                right: BorderSide(
                    color: Color(0xFF1E3A5F)),
              ),
            ),
            padding: const EdgeInsets.all(48),
            child: const LoginLeftPanel(),
          ),
        ),
        // Right login panel
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(48),
            child: _buildRightPanel(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.xl,
      ),
      child: _buildRightPanel(),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  RIGHT PANEL (tab selector + login card + trust row + footer)
  // ─────────────────────────────────────────────────────────────

  Widget _buildRightPanel() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tab selector
        LoginTabSelector(
          activeTab: _activeTab,
          onTabChanged: _switchTab,
        ),
        const SizedBox(height: AppSpacing.md),

        // Login card
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: const Color(0xE60F2137),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF1E3A5F)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 60,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 280),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(anim),
                child: child,
              ),
            ),
            child: _buildActiveForm(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Trust row
        _buildTrustRow(),
        const SizedBox(height: AppSpacing.sm),

        // Footer
        const Center(
          child: Text(
            'By logging in you agree to our Privacy Policy & Terms of Use',
            style: TextStyle(color: Color(0xFF4A6A8A), fontSize: 10.5),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveForm() {
    switch (_activeTab) {
      case 'abha':
        return LoginAbha(
          key: const ValueKey('abha'),
          onSuccess: _onLoginSuccess,
        );
      case 'aadhaar':
        return LoginAadhaar(
          key: const ValueKey('aadhaar'),
          onSuccess: _onLoginSuccess,
        );
      case 'face':
        return LoginFaceAuth(
          key: const ValueKey('face'),
          onSuccess: _onLoginSuccess,
        );
      case 'family':
        return LoginFamily(
          key: const ValueKey('family'),
          onSuccess: _onLoginSuccess,
        );
      default:
        return LoginMobileOtp(
          key: const ValueKey('mobile'),
          onSuccess: _onLoginSuccess,
          onSwitchTab: _switchTab,
        );
    }
  }

  Widget _buildTrustRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTrustItem(Icons.lock_rounded, 'SSL Encrypted'),
        const SizedBox(width: 20),
        _buildTrustItem(Icons.security_rounded, 'HIPAA Compliant'),
        const SizedBox(width: 20),
        _buildTrustItem(Icons.verified_rounded, 'NHA Certified'),
      ],
    );
  }

  Widget _buildTrustItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.success),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7A9BBF),
            fontSize: 10.5,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Background grid dot painter
// ─────────────────────────────────────────────────────────────
class _GridDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00B4D8).withValues(alpha: 0.07)
      ..style = PaintingStyle.fill;
    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
