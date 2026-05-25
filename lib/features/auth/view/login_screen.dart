import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
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
  // Live stats that update periodically
  int _livePatients = 247;
  int _todayOpd = 48;

  final List<String> _announcements = [
    '🏥 ParaCare+ HIMS v3.0 — Fully Integrated Hospital Information Management System',
    '💉 National Vaccination Drive ongoing — Update records in the Certificate module',
    '📋 Ayushman Bharat PMJAY integration active — Verify beneficiary status in Billing',
    '🩸 Blood Bank Alert: O− stock critically low — Please arrange donations',
    '📞 System Support: 1800-XXX-XXXX (Toll Free) | helpdesk@hims.uk.gov.in',
    '⚕️ All clinical workflows now ABDM compliant | PHR linked records active',
  ];

  @override
  void initState() {
    super.initState();
    _updateTime();
    _clockTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateTime(),
    );
    _tickerTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _cycleAnnouncement(),
    );
    Timer.periodic(const Duration(seconds: 5), (_) => _updateStats());
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    _tickerTimer.cancel();
    super.dispose();
  }

  void _updateTime() {
    if (!mounted) return;
    final now = DateTime.now();
    setState(() {
      _timeString =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')} IST';
    });
  }

  void _cycleAnnouncement() {
    if (!mounted) return;
    setState(() {
      _announcementIndex = (_announcementIndex + 1) % _announcements.length;
    });
  }

  void _updateStats() {
    if (!mounted) return;
    setState(() {
      _livePatients = 240 + (DateTime.now().second % 15);
      _todayOpd = 44 + (DateTime.now().second % 10);
    });
  }

  // ─────────────────────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider).value;

    return Scaffold(
      backgroundColor: const Color(0xFF071221),
      body: Stack(
        children: [
          // Animated bg glows
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x141565C0), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 350,
              height: 350,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x0E00695C), Colors.transparent],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildGovRibbon(),
                _buildAnnouncementStrip(),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 950) {
                        return _buildTabletLayout(loginState);
                      }
                      return _buildMobileLayout(loginState);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  GOV RIBBON
  // ─────────────────────────────────────────────────────────────
  Widget _buildGovRibbon() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xF2071221),
        border: Border(bottom: BorderSide(color: Color(0xFFE65100), width: 3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Column(
            children: [
              // Container(
              //   width: 44,
              //   height: 44,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: const Color(0xFFC8A84B),
              //       width: 1.5,
              //     ),
              //     color: AppColors.primary.withValues(alpha: 0.7),
              //   ),
              //   child: const Center(
              //     child: Text(
              //       'अ',
              //       style: TextStyle(
              //         color: Color(0xFFF9A825),
              //         fontSize: 18,
              //         fontWeight: FontWeight.w900,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: AppSpacing.sm),
              const Text(
                'GOVERNMENT OF UTTARAKHAND — DEPT. OF HEALTH & FAMILY WELFARE',
                style: TextStyle(
                  color: Color(0xFFCCE0F0),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              const Text(
                'उत्तराखण्ड शासन · स्वास्थ्य एवं परिवार कल्याण विभाग',
                style: TextStyle(
                  color: Color(0xFFA0C0D8),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text(
                'State Health Information Management System (SHIMS) | ABDM Compliant',
                style: TextStyle(color: Color(0xFFE2EFF8), fontSize: 10),
              ),
              const Text(
                'Designed & Developed by Parakore Enterprises Pvt Ltd Uttarakhand | v3.0.0',
                style: TextStyle(
                  color: Color(0xFF6A8A9E),
                  fontSize: 9,
                  fontStyle: FontStyle.italic,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  _buildRibbonBadge(
                    label: 'All Systems Online',
                    color: const Color(0xFF43A047),
                    showLiveDot: true,
                  ),
                  // const SizedBox(width: 6),
                  _buildRibbonBadge(
                    label: '🔒 256-bit SSL',
                    color: const Color(0xFF90CAF9),
                  ),
                  // const SizedBox(width: 6),
                  _buildRibbonBadge(
                    label: '⏰ $_timeString',
                    color: const Color(0xFFFFD54F),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRibbonBadge({
    required String label,
    required Color color,
    bool showLiveDot = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLiveDot) ...[
            _LiveDot(color: color),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  ANNOUNCEMENT STRIP
  // ─────────────────────────────────────────────────────────────
  Widget _buildAnnouncementStrip() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0x26E65100), Color(0x1AF9A825)],
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE65100).withValues(alpha: 0.2),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          const Text('📢', style: TextStyle(fontSize: 13)),
          const SizedBox(width: 10),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                _announcements[_announcementIndex],
                key: ValueKey<int>(_announcementIndex),
                style: const TextStyle(
                  color: Color(0xFFFFCC80),
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFE65100).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE65100).withValues(alpha: 0.3),
              ),
            ),
            child: const Text(
              'LIVE',
              style: TextStyle(
                color: Color(0xFFFF8A65),
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  LAYOUTS
  // ─────────────────────────────────────────────────────────────
  Widget _buildTabletLayout(LoginState? state) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Left panel
        Expanded(
          flex: 12,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginInfoSection(),
                const SizedBox(height: AppSpacing.xl),
                _buildStatsTickerRow(),
                const SizedBox(height: AppSpacing.lg),
                _buildSystemStatusPanel(),
              ],
            ),
          ),
        ),
        // Divider
        Container(width: 1, color: Colors.white.withValues(alpha: 0.06)),
        // Right panel
        Expanded(
          flex: 10,
          child: Container(
            color: Colors.white.withValues(alpha: 0.03),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: _buildLoginForm(state),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(LoginState? state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          const LoginInfoSection(),
          const SizedBox(height: AppSpacing.md),
          _buildStatsTickerRow(),
          const SizedBox(height: AppSpacing.lg),
          _buildLoginForm(state),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Expanded(child: _buildPageFooter())],
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  STATS TICKER
  // ─────────────────────────────────────────────────────────────
  Widget _buildStatsTickerRow() {
    final items = [
      (_livePatients.toString(), 'Live Patients'),
      (_todayOpd.toString(), 'Today OPD'),
      ('12', 'Lab Pending'),
      ('3', 'Ambulances'),
      ('86%', 'Bed Occupancy'),
    ];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items
            .map(
              (i) => Column(
                children: [
                  Text(
                    i.$1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    i.$2,
                    style: const TextStyle(
                      color: Color(0xFF5A7A8E),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  SYSTEM STATUS PANEL
  // ─────────────────────────────────────────────────────────────
  Widget _buildSystemStatusPanel() {
    final services = [
      ('Core HIMS', 'Operational', true),
      ('ABDM Gateway', 'Synced', true),
      ('Lab Interface', 'Connected', true),
      ('Pharmacy LIS', 'Active', true),
      ('RIS/PACS', 'Partial', false),
      ('Ambulance GPS', 'Live', true),
      ('Billing Engine', 'Active', true),
      ('Backup (Last)', '02:00 AM', true),
    ];
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🟢  SYSTEM STATUS',
            style: TextStyle(
              color: Color(0xFF5A7A8E),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 4.5,
            ),
            itemCount: services.length,
            itemBuilder: (context, i) {
              final svc = services[i];
              final dotColor = svc.$3
                  ? const Color(0xFF43A047)
                  : const Color(0xFFFFA000);
              return Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: dotColor.withValues(alpha: 0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      svc.$1,
                      style: const TextStyle(
                        color: Color(0xFF8AB0C8),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    svc.$2,
                    style: const TextStyle(
                      color: Color(0xFF5A7A8E),
                      fontSize: 9,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  LOGIN FORM CARD
  // ─────────────────────────────────────────────────────────────
  Widget _buildLoginForm(LoginState? state) {
    if (state == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // Card with dark-navy header + saffron top-border
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 64,
                offset: const Offset(0, 16),
              ),
            ],
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            children: [
              // Dark navy header
              _buildCardHeader(),
              // White body
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.errorMessage != null)
                      _buildErrorAlert(state.errorMessage!),
                    // Role grid
                    const Text(
                      'SELECT YOUR ROLE',
                      style: TextStyle(
                        color: Color(0xFF5A7894),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const RoleSelectionGrid(),
                    const SizedBox(height: AppSpacing.md),
                    // Credentials
                    const Text(
                      'Employee ID / Username',
                      style: TextStyle(
                        color: Color(0xFF2C4460),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      onChanged: (value) {
                        ref
                            .read(loginViewModelProvider.notifier)
                            .updateEmployeeId(value);
                      },
                      style: const TextStyle(
                        color: Color(0xFF0D1B2A),
                        fontSize: 13,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Enter your employee ID',
                        fillColor: Colors.white,
                        prefixIcon: Icon(Icons.person, color: AppColors.border),
                        hintStyle: TextStyle(color: AppColors.border),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    const Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF2C4460),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),
                    TextField(
                      obscureText: state.isObscured,
                      onChanged: (value) {
                        ref
                            .read(loginViewModelProvider.notifier)
                            .updatePassword(value);
                      },
                      style: const TextStyle(
                        color: Color(0xFF0D1B2A),
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: AppColors.border,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.isObscured
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.border,
                          ),
                          onPressed: () {
                            ref
                                .read(loginViewModelProvider.notifier)
                                .toggleObscure();
                          },
                        ),
                        hintStyle: const TextStyle(color: AppColors.border),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                      ),
                    ),

                    // _buildLightTextField(
                    //   label: 'Employee ID / Username',
                    //   hint: 'e.g. EMP-00123 or admin',
                    //   prefixEmoji: '👤',
                    //   onChanged: (v) => ref
                    //       .read(loginViewModelProvider.notifier)
                    //       .updateEmployeeId(v),
                    // ),
                    // const SizedBox(height: AppSpacing.sm),
                    // _buildLightTextField(
                    //   label: 'Password',
                    //   hint: 'Enter your password',
                    //   prefixEmoji: '🔒',
                    //   isPassword: state.isObscured,
                    //   onChanged: (v) => ref
                    //       .read(loginViewModelProvider.notifier)
                    //       .updatePassword(v),
                    //   trailing: GestureDetector(
                    //     onTap: () => ref
                    //         .read(loginViewModelProvider.notifier)
                    //         .toggleObscure(),
                    //     child: Text(
                    //       state.isObscured ? '👁️' : '🙈',
                    //       style: const TextStyle(fontSize: 16),
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 18,
                              height: 18,
                              child: Checkbox(
                                value: state.rememberMe,
                                onChanged: (v) => ref
                                    .read(loginViewModelProvider.notifier)
                                    .toggleRememberMe(v),
                                activeColor: AppColors.primary,
                                side: const BorderSide(
                                  color: Color(0xFFCCD8E8),
                                ),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: Color(0xFF5A7894),
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Color(0xFF1565C0),
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Main login button
                    _buildLoginBtn(state),
                    const SizedBox(height: AppSpacing.sm),
                    // Public quick-access buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildPublicBtn('📅 Quick Appointment', const [
                            Color(0xFF00695C),
                            Color(0xFF00897B),
                          ], () {}),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildPublicBtn('🔀 Transfer Portal', const [
                            Color(0xFF4527A0),
                            Color(0xFF5E35B1),
                          ], () {}),
                        ),
                      ],
                    ),
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          '👆 Public portals — no login needed',
                          style: TextStyle(
                            color: Color(0xFF7A9AB5),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    // Dashboard Ecosystem button
                    _buildDashboardEcosystemBtn(),
                    const SizedBox(height: 8),
                    // Patient Portal button
                    _buildPatientPortalBtn(),
                    const SizedBox(height: 6),
                    const Center(
                      child: Text(
                        '☝️ ABHA · Health Records · OPD · Lab · AI Assistant · Telemedicine',
                        style: TextStyle(
                          color: Color(0xFF7A9AB5),
                          fontSize: 9.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildDivider('Quick Demo Access'),
                    const SizedBox(height: AppSpacing.sm),
                    const DemoCredentialsBar(),
                  ],
                ),
              ),
              // Footer bar
              _buildCardFooterBar(),
            ],
          ),
        ),
        // Version info
        const SizedBox(height: AppSpacing.md),
        const Center(
          child: Text(
            'ParaCare+ HIMS v3.0.0 — ABDM Compliant | ISO 27001\nParakore Enterprises Pvt Ltd Uttarakhand | Last Updated: April 2026',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF5A7A8E),
              fontSize: 9.5,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardHeader() {
    return Container(
      width: 568,
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF071221), Color(0xFF0B2A52)],
        ),
        border: Border(bottom: BorderSide(color: Color(0xFFE65100), width: 3)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadiusGeometry.vertical(
              top: Radius.circular(30),
              bottom: Radius.circular(20),
            ),
            child: Image.asset(
              'assets/images/para_care_logo.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 8),
          const Text(
            'ParaCare+ HIMS — Secure Login',
            style: TextStyle(
              color: Color(0xFFE8F4FD),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Hospital Information Management System',
            style: TextStyle(color: Color(0xFF7A9AB8), fontSize: 11),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
              ),
            ),
            child: const Text(
              '🏥 District Hospital Dehradun | ID: DHD-01',
              style: TextStyle(
                color: Color(0xFF90CAF9),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorAlert(String message) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFC62828).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          const Text('⚠️', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Color(0xFF7F0000), fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLightTextField({
    required String label,
    required String hint,
    required String prefixEmoji,
    bool isPassword = false,
    required void Function(String) onChanged,
    Widget? trailing,
  }) {
    return SizedBox(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextField(
                obscureText: isPassword,
                onChanged: onChanged,
                style: const TextStyle(color: Color(0xFF0D1B2A), fontSize: 13),
                decoration: InputDecoration(
                  hintText: hint,
                  fillColor: Colors.white,
                  prefixIcon: Text(
                    prefixEmoji,
                    style: const TextStyle(fontSize: 20, color: Colors.black26),
                    // color: Colors.black,
                  ),
                  hintStyle: const TextStyle(color: Colors.white24),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  suffixIcon: trailing != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: trailing,
                        )
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn(LoginState state) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B4EA8), Color(0xFF1565C0)],
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1565C0).withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: state.isLoading
              ? null
              : () async {
                  final success = await ref
                      .read(loginViewModelProvider.notifier)
                      .login();
                  if (success && context.mounted) {
                    context.goNamed(RouteNames.dashboard);
                  }
                },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13),
            child: Center(
              child: state.isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      '🔐 Secure Login to HIMS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPublicBtn(String label, List<Color> colors, VoidCallback onTap) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardEcosystemBtn() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF071221), Color(0xFF0F2137)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF00B4D8).withValues(alpha: 0.35),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🏥', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                const Text(
                  'ParaCare+ Dashboard Ecosystem',
                  style: TextStyle(
                    color: Color(0xFF00B4D8),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Text(
                    '40+ Dashboard',
                    style: TextStyle(
                      color: Color(0xFF00B4D8),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPatientPortalBtn() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A0618), Color(0xFF14083A)],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFC77DFF).withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.pushNamed(RouteNames.patientLogin),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('🧑‍⚕️', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                const Text(
                  'Patient Portal Login',
                  style: TextStyle(
                    color: Color(0xFFC77DFF),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC77DFF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFC77DFF).withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Text(
                    '✦ NEW · Phase C',
                    style: TextStyle(
                      color: Color(0xFFC77DFF),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(String label) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFCCD8E8))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF5A7894),
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFCCD8E8))),
      ],
    );
  }

  Widget _buildCardFooterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: const BoxDecoration(
        color: Color(0xFFF7FAFD),
        border: Border(top: BorderSide(color: Color(0xFFCCD8E8))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink('🔑 Reset Password'),
              const SizedBox(width: 12),
              _buildFooterLink('📞 IT Support'),
              const SizedBox(width: 12),
              _buildFooterLink('📋 User Manual'),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_rounded, size: 11, color: Color(0xFF5A7894)),
              SizedBox(width: 4),
              Text(
                'AES-256 Encrypted',
                style: TextStyle(color: Color(0xFF5A7894), fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String label) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        label,
        style: const TextStyle(color: Color(0xFF5A7894), fontSize: 10.5),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  //  PAGE FOOTER
  // ─────────────────────────────────────────────────────────────
  Widget _buildPageFooter() {
    return Container(
      color: const Color(0xEB071221),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '© 2026 Government of Uttarakhand, Department of Health & Family Welfare.',
            style: TextStyle(color: Color(0xFF5A7A8E), fontSize: 9.5),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children:
                    [
                          'Privacy Policy',
                          'Terms of Use',
                          'Accessibility',
                          'Contact',
                          'Sitemap',
                        ]
                        .map(
                          (l) => Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                l,
                                style: const TextStyle(
                                  color: Color(0xFF5A7A8E),
                                  fontSize: 9.5,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  Live dot animation widget
// ─────────────────────────────────────────────────────────────
class _LiveDot extends StatefulWidget {
  final Color color;
  const _LiveDot({required this.color});

  @override
  State<_LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<_LiveDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.3, end: 1).animate(_controller),
      child: Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
