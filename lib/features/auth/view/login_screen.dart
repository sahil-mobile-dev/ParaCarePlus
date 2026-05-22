import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/auth/view/widgets/demo_credentials_bar.dart';
import 'package:paracareplus/features/auth/view/widgets/login_info_section.dart';
import 'package:paracareplus/features/auth/view/widgets/role_selection_grid.dart';
import 'package:paracareplus/features/auth/view_model/login_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late Timer _clockTimer;
  late Timer _tickerTimer;
  String _timeString = '';
  int _announcementIndex = 0;

  final List<String> _announcements = [
    '🔔 COVID-19 & Influenza Booster Drive: Free vaccination camps registered in all 13 districts.',
    '🩸 Critical Blood Alert: O-Negative units urgently needed at AIIMS Rishikesh Blood Bank.',
    '🚑 GIS Ambulance Network: 42 new active trauma response units deployed on NH-58 Char Dham route.',
    '🛡️ ABDM Compliance Update: Secure SHA-256 EMR locking has been activated state-wide.',
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer t) => _updateTime(),
    );
    _tickerTimer = Timer.periodic(
      const Duration(seconds: 6),
      (Timer t) => _rotateAnnouncement(),
    );
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _tickerTimer.cancel();
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    if (mounted) {
      setState(() {
        _timeString = formattedTime;
      });
    }
  }

  void _rotateAnnouncement() {
    if (mounted) {
      setState(() {
        _announcementIndex = (_announcementIndex + 1) % _announcements.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider).value;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Government of Uttarakhand Trust & Security Ribbon
            _buildGovRibbon(),

            // 2. Dynamic Live System Announcement Marquee
            _buildAnnouncementStrip(),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 950) {
                    return _buildTabletLayout(context, loginState);
                  }
                  return _buildMobileLayout(context, loginState);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGovRibbon() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF071424),
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              // Uttarakhand Gov Emblem mockup icon
              Icon(
                Icons.account_balance_rounded,
                color: AppColors.secondaryAccent,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'GOVERNMENT OF UTTARAKHAND PORTAL',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 9.5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          // SSL Status and Digital Clock
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lock_rounded,
                      color: AppColors.success,
                      size: 10,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'SECURE 256-BIT SSL',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                _timeString,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementStrip() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
            ),
            child: const Text(
              'LIVE TICKER',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: Text(
                _announcements[_announcementIndex],
                key: ValueKey<int>(_announcementIndex),
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.primaryText,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, LoginState? state) {
    return Row(
      children: [
        // Left Column: Interactive Stats Dashboard & System Health Indicators
        Expanded(
          flex: 12,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginInfoSection(),
                const SizedBox(height: AppSpacing.xl),
                const Text(
                  'SYSTEM HEALTH INDICATORS',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: AppSpacing.md),
                _buildSystemHealthGrid(),
              ],
            ),
          ),
        ),
        // Right Column: Staff Login Form Container
        Expanded(
          flex: 10,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: SizedBox(
                width: 480,
                child: _buildLoginForm(context, state),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, LoginState? state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          const LoginInfoSection(),
          const SizedBox(height: AppSpacing.lg),
          _buildLoginForm(context, state),
        ],
      ),
    );
  }

  Widget _buildSystemHealthGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 2.2,
      children: [
        _buildHealthItem('Database Server', 'Online', AppColors.success),
        _buildHealthItem('Auth Service', 'Operational', AppColors.success),
        _buildHealthItem('AI Diagnostics', 'Active', AppColors.success),
        _buildHealthItem('GIS Telemetry', 'Active', AppColors.success),
        _buildHealthItem('SMS Gateway', 'Normal', AppColors.success),
        _buildHealthItem('ABDM Sandbox', 'Online', AppColors.success),
      ],
    );
  }

  Widget _buildHealthItem(String name, String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(status, style: TextStyle(color: color, fontSize: 8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, LoginState? state) {
    if (state == null) return const Center(child: CircularProgressIndicator());

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_person_rounded,
                color: AppColors.secondaryAccent,
                size: 28,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ParaCare+ HIMS - Secure Login',
                    style: AppTextStyles.titleSmall,
                  ),
                  Text(
                    'Hospital Information Management System',
                    style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.lg),

          // 3. Majestic Patient Portal Redirect Card
          _buildPatientPortalCallout(context),

          const SizedBox(height: AppSpacing.lg),
          const Divider(color: AppColors.border),
          const SizedBox(height: AppSpacing.md),
          const Text('STAFF SECURE LOGIN', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.sm),
          const Text('SELECT YOUR ROLE', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.md),
          const RoleSelectionGrid(),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: 'Employee ID / Email',
            hintText: 'bakul@demo.com',
            prefixIcon: Icons.person_outline_rounded,
            onChanged: (v) =>
                ref.read(loginViewModelProvider.notifier).updateEmployeeId(v),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Password',
            hintText: '••••••',
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: state.isObscured,
            suffixIcon: IconButton(
              onPressed: () =>
                  ref.read(loginViewModelProvider.notifier).toggleObscure(),
              icon: Icon(
                state.isObscured
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
              iconSize: 20,
            ),
            onChanged: (v) =>
                ref.read(loginViewModelProvider.notifier).updatePassword(v),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: state.rememberMe,
                      onChanged: (v) => ref
                          .read(loginViewModelProvider.notifier)
                          .toggleRememberMe(v),
                      activeColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Remember me', style: AppTextStyles.labelSmall),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: AppTextStyles.labelSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                state.errorMessage!,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            ),
          AppButton(
            text: 'Secure Login to HIMS',
            isLoading: state.isLoading,
            onPressed: () async {
              final success = await ref
                  .read(loginViewModelProvider.notifier)
                  .login();
              if (success && context.mounted) {
                context.goNamed(RouteNames.dashboard);
              }
            },
            icon: Icons.vpn_key_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoCredentialsBar(),
        ],
      ),
    );
  }

  Widget _buildPatientPortalCallout(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.success, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withValues(alpha: 0.25),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.pushNamed(RouteNames.patientLogin),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_pin_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PATIENT PORTAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Book OPD, View EMR, Consult AI, Emergency SOS',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
