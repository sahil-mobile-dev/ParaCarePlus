import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/routes/route_names.dart';

// State Provider to manage the active login tab
final patientLoginTabProvider = StateProvider<String>((ref) => 'mobile');

// State Provider for Mobile OTP wizard steps: 0 (Mobile), 1 (OTP), 2 (Profile Selection)
final mobileOtpStepProvider = StateProvider<int>((ref) => 0);

// Selected profile within step 2
final selectedProfileProvider = StateProvider<String>((ref) => 'Self');

class PatientLoginScreen extends ConsumerStatefulWidget {
  const PatientLoginScreen({super.key});

  @override
  ConsumerState<PatientLoginScreen> createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends ConsumerState<PatientLoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  int _resendTimer = 30;
  Timer? _timer;
  bool _isSendingOtp = false;
  bool _isVerifyingOtp = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _dobController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _otpFocusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendTimer = 30;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() {
          _resendTimer--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _sendOtp() async {
    if (_mobileController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 10-digit mobile number'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    setState(() {
      _isSendingOtp = true;
    });
    // Simulate sending OTP
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() {
        _isSendingOtp = false;
      });
      ref.read(mobileOtpStepProvider.notifier).state = 1;
      _startResendTimer();
    }
  }

  Future<void> _verifyOtp() async {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 6-digit OTP sent to your phone'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    setState(() {
      _isVerifyingOtp = true;
    });
    // Simulate verifying OTP
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _isVerifyingOtp = false;
      });
      ref.read(mobileOtpStepProvider.notifier).state = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = ref.watch(patientLoginTabProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background grids & glowing orbs
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0.6, -0.6),
                  radius: 1.2,
                  colors: [Color(0x1500B4D8), Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0x0E4361EE), Colors.transparent],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xl,
                ),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 950),
                  child: Row(
                    children: [
                      // Left brand panel (visible on larger screens)
                      if (MediaQuery.of(context).size.width > 900)
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: AppSpacing.xl,
                            ),
                            child: _buildLeftBrandPanel(),
                          ),
                        ),
                      // Right form panel
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildTabSelector(activeTab),
                            const SizedBox(height: AppSpacing.md),
                            _buildLoginCard(activeTab),
                            const SizedBox(height: AppSpacing.lg),
                            _buildTrustRow(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftBrandPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.favorite_rounded,
                color: AppColors.primaryLight,
                size: 28,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ParaCare+', style: AppTextStyles.titleMedium),
                Text(
                  'Uttarakhand Health Platform',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Text(
            'Secure Patient Access Portal v4.0',
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primaryLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        RichText(
          text: TextSpan(
            style: AppTextStyles.titleLarge.copyWith(
              fontSize: 32,
              height: 1.25,
            ),
            children: const [
              TextSpan(text: 'Your Health,\n'),
              TextSpan(
                text: 'One Identity.',
                style: TextStyle(color: AppColors.primaryLight),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Access your complete health records, book appointments instantly, interact with our advanced clinical AI assistant, and coordinate secure family health management.',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.secondaryText,
            fontSize: 13,
            height: 1.6,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildFeaturePill(Icons.abc, 'ABHA ID Login'),
            _buildFeaturePill(Icons.phone_android_rounded, 'Mobile OTP'),
            _buildFeaturePill(Icons.fingerprint_rounded, 'Biometric Auth'),
            _buildFeaturePill(
              Icons.face_retouching_natural_rounded,
              'Face Recognition',
            ),
            _buildFeaturePill(Icons.groups_outlined, 'Family Accounts'),
            _buildFeaturePill(Icons.security_rounded, 'Consent Manager'),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        _buildAbdmStrip(),
      ],
    );
  }

  Widget _buildFeaturePill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.3),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryLight),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.primaryText.withValues(alpha: 0.9),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbdmStrip() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.08),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ABDM Compliant — Ayushman Bharat',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Certified under NHA national standards. Health records are compiled using FHIR R4 clinical models.',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                    fontSize: 9.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSelector(String activeTab) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _buildTabItem(
            'mobile',
            Icons.phone_android_rounded,
            'OTP',
            activeTab,
          ),
          _buildTabItem('abha', Icons.abc, 'ABHA', activeTab),
          _buildTabItem('face', Icons.face_rounded, 'Face', activeTab),
          _buildTabItem('family', Icons.groups_rounded, 'Family', activeTab),
        ],
      ),
    );
  }

  Widget _buildTabItem(
    String value,
    IconData icon,
    String label,
    String activeTab,
  ) {
    final isSelected = activeTab == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(patientLoginTabProvider.notifier).state = value;
          ref.read(mobileOtpStepProvider.notifier).state = 0; // reset steps
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 14,
                color: isSelected ? Colors.white : AppColors.secondaryText,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.labelSmall.copyWith(
                  color: isSelected ? Colors.white : AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginCard(String activeTab) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _buildActiveTabForm(activeTab),
      ),
    );
  }

  Widget _buildActiveTabForm(String tab) {
    switch (tab) {
      case 'mobile':
        return _buildMobileOtpForm();
      case 'abha':
        return _buildAbhaForm();
      case 'face':
        return _buildFaceAuthForm();
      case 'family':
        return _buildFamilyLoginForm();
      default:
        return _buildMobileOtpForm();
    }
  }

  Widget _buildMobileOtpForm() {
    final step = ref.watch(mobileOtpStepProvider);

    return Column(
      key: const ValueKey('mobile_otp_form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_android_rounded,
                color: AppColors.primaryLight,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login with Mobile OTP',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Enter mobile registered with health database',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _buildStepWizardIndicator(step),
        const SizedBox(height: AppSpacing.lg),
        if (step == 0)
          _buildOtpStep0Mobile()
        else if (step == 1)
          _buildOtpStep1Code()
        else
          _buildOtpStep2Profile(),
      ],
    );
  }

  Widget _buildStepWizardIndicator(int currentStep) {
    final steps = ['Mobile', 'Verify OTP', 'Select Profile'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(steps.length, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;

        return Row(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: isActive
                      ? AppColors.primary
                      : isCompleted
                      ? AppColors.success
                      : AppColors.border,
                  child: isCompleted
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isActive || isCompleted
                                ? Colors.white
                                : AppColors.secondaryText,
                          ),
                        ),
                ),
                const SizedBox(height: 4),
                Text(
                  steps[index],
                  style: AppTextStyles.labelSmall.copyWith(
                    fontSize: 8.5,
                    color: isActive
                        ? AppColors.primaryLight
                        : AppColors.secondaryText,
                  ),
                ),
              ],
            ),
            if (index < steps.length - 1)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 32,
                height: 1,
                color: isCompleted ? AppColors.success : AppColors.border,
              ),
          ],
        );
      }),
    );
  }

  Widget _buildOtpStep0Mobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTextField(
          label: 'Mobile Number',
          hintText: '98765 43210',
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.phone_iphone_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        AppTextField(
          label: 'Date of Birth (Optional Verification)',
          hintText: 'YYYY-MM-DD',
          controller: _dobController,
          keyboardType: TextInputType.datetime,
          prefixIcon: Icons.calendar_today_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.secondaryAccent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.secondaryAccent.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: AppColors.secondaryAccent,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'OTP will be sent via SMS & WhatsApp to your registered device.',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Send Secure OTP',
          isLoading: _isSendingOtp,
          icon: Icons.send_rounded,
          onPressed: _sendOtp,
        ),
      ],
    );
  }

  Widget _buildOtpStep1Code() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Text(
            'Enter the 6-digit verification code sent to +91 ${_mobileController.text.isNotEmpty ? _mobileController.text : "XXXXX XXXXX"}',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryText.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (index) {
            return SizedBox(
              width: 40,
              child: TextFormField(
                controller: _otpControllers[index],
                focusNode: _otpFocusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLength: 1,
                decoration: const InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty && index < 5) {
                    _otpFocusNodes[index + 1].requestFocus();
                  } else if (value.isEmpty && index > 0) {
                    _otpFocusNodes[index - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: _resendTimer > 0
              ? Text(
                  'Resend code in ${_resendTimer}s',
                  style: AppTextStyles.labelSmall,
                )
              : TextButton(
                  onPressed: _startResendTimer,
                  child: const Text('Resend Code via SMS/WhatsApp'),
                ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          text: 'Verify & Authenticate',
          isLoading: _isVerifyingOtp,
          icon: Icons.verified_user_rounded,
          onPressed: _verifyOtp,
        ),
        const SizedBox(height: AppSpacing.sm),
        TextButton(
          onPressed: () {
            ref.read(mobileOtpStepProvider.notifier).state = 0;
          },
          child: const Text('Back to Change Mobile'),
        ),
      ],
    );
  }

  Widget _buildOtpStep2Profile() {
    final selectedProfile = ref.watch(selectedProfileProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.success,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Identity Confirmed!',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const Text(
          'We found multiple linked profiles. Select who to sign in as:',
          style: AppTextStyles.bodySmall,
        ),
        const SizedBox(height: AppSpacing.md),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.sm,
          crossAxisSpacing: AppSpacing.sm,
          childAspectRatio: 2.2,
          children: [
            _buildProfileCard('Self', 'Ramesh Kumar', 'Self', selectedProfile),
            _buildProfileCard(
              'Spouse',
              'Geeta Kumar',
              'Spouse',
              selectedProfile,
            ),
            _buildProfileCard('Child', 'Aryan Kumar', 'Son', selectedProfile),
            _buildAddMemberCard(),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Enter Patient Portal',
          icon: Icons.login_rounded,
          onPressed: () {
            context.goNamed(RouteNames.patientHome);
          },
        ),
      ],
    );
  }

  Widget _buildProfileCard(
    String id,
    String name,
    String relation,
    String selected,
  ) {
    final isSelected = selected == id;

    return GestureDetector(
      onTap: () {
        ref.read(selectedProfileProvider.notifier).state = id;
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: isSelected
                  ? AppColors.primary
                  : AppColors.border,
              child: Text(
                name.substring(0, 1),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    relation,
                    style: AppTextStyles.labelSmall.copyWith(fontSize: 9),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMemberCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        border: Border.all(color: AppColors.border, style: BorderStyle.none),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          // Placeholder action
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              color: AppColors.secondaryText.withValues(alpha: 0.6),
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              'Add Member',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.secondaryText.withValues(alpha: 0.8),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbhaForm() {
    return Column(
      key: const ValueKey('abha_form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.badge_rounded, color: AppColors.success, size: 24),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login with ABHA ID',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Ayushman Bharat Health Account',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0D9488), Color(0xFF065F46)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF0D9488).withValues(alpha: 0.4),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🏥 AYUSHMAN BHARAT HEALTH ACCOUNT',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white70,
                  fontSize: 8,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '43 - 8912 - 3456 - 7890',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RAMESH KUMAR',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const Icon(
                    Icons.qr_code_2_rounded,
                    color: Colors.white70,
                    size: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const AppTextField(
          label: 'ABHA Number / Address',
          hintText: 'e.g. 43-8912-3456-7890 or ramesh@abha',
          prefixIcon: Icons.assignment_ind_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          text: 'Authenticate with ABHA',
          icon: Icons.verified_user_rounded,
          onPressed: () {
            context.goNamed(RouteNames.patientHome);
          },
        ),
      ],
    );
  }

  Widget _buildFaceAuthForm() {
    return Column(
      key: const ValueKey('face_form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.face_unlock_rounded,
              color: AppColors.primaryLight,
              size: 24,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Face Recognition Sign-In',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Secure biometric liveness scan',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surface,
              border: Border.all(color: AppColors.primaryLight, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: 0.15),
                  blurRadius: 16,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Icon(
              Icons.face_rounded,
              size: 72,
              color: AppColors.secondaryText.withValues(alpha: 0.5),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const Center(
          child: Text(
            'Keep your face in front of the camera area',
            style: AppTextStyles.bodySmall,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Scan Face & Access',
          icon: Icons.camera_front_rounded,
          onPressed: () {
            context.goNamed(RouteNames.patientHome);
          },
        ),
      ],
    );
  }

  Widget _buildFamilyLoginForm() {
    return Column(
      key: const ValueKey('family_form'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.groups_rounded,
              color: AppColors.secondaryAccent,
              size: 24,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shared Family Console',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Authenticate linked accounts together',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const AppTextField(
          label: 'Family Access ID',
          hintText: 'e.g. FAM-88912-32',
          prefixIcon: Icons.family_restroom_rounded,
        ),
        const SizedBox(height: AppSpacing.md),
        const AppTextField(
          label: 'PIN Code',
          hintText: '••••',
          isPassword: true,
          prefixIcon: Icons.lock_outline_rounded,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Access Family Hub',
          icon: Icons.groups_rounded,
          onPressed: () {
            context.goNamed(RouteNames.patientHome);
          },
        ),
      ],
    );
  }

  Widget _buildTrustRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTrustItem(Icons.lock_rounded, 'SSL Encrypted'),
        const SizedBox(width: 12),
        _buildTrustItem(Icons.verified_user_rounded, 'HIPAA Compliant'),
        const SizedBox(width: 12),
        _buildTrustItem(Icons.health_and_safety_rounded, 'NHA Certified'),
      ],
    );
  }

  Widget _buildTrustItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.success),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.labelSmall.copyWith(fontSize: 8.5)),
      ],
    );
  }
}
