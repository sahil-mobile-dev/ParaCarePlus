import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';

/// Mobile OTP login form — 4-step wizard
/// Step 0: Enter mobile + DOB
/// Step 1: Enter OTP (6 digits)
/// Step 2: Select profile from family grid
/// Step 3: Access granted (navigate to dashboard)
class LoginMobileOtp extends StatefulWidget {
  final VoidCallback onSuccess;
  final ValueChanged<String> onSwitchTab;

  const LoginMobileOtp({
    super.key,
    required this.onSuccess,
    required this.onSwitchTab,
  });

  @override
  State<LoginMobileOtp> createState() => _LoginMobileOtpState();
}

class _LoginMobileOtpState extends State<LoginMobileOtp> {
  int _step = 0;
  final _mobileCtrl = TextEditingController();
  final _dobCtrl = TextEditingController();
  final _otpCtrls = List.generate(6, (_) => TextEditingController());
  final _otpFoci = List.generate(6, (_) => FocusNode());
  int _resendTimer = 30;
  Timer? _timer;
  bool _isSending = false;
  bool _isVerifying = false;
  String _selectedProfile = 'Self';

  @override
  void dispose() {
    _mobileCtrl.dispose();
    _dobCtrl.dispose();
    for (final c in _otpCtrls) {
      c.dispose();
    }
    for (final f in _otpFoci) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() => _resendTimer = 30);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        t.cancel();
      }
    });
  }

  Future<void> _sendOtp() async {
    if (_mobileCtrl.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid 10-digit mobile number'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    setState(() => _isSending = true);
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() {
      _isSending = false;
      _step = 1;
    });
    _startTimer();
  }

  Future<void> _verifyOtp() async {
    final otp = _otpCtrls.map((c) => c.text).join();
    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter the 6-digit OTP'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
    setState(() => _isVerifying = true);
    await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() {
      _isVerifying = false;
      _step = 2;
    });
  }

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
                color: AppColors.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.phone_android_rounded,
                color: Color(0xFF00B4D8),
                size: 22,
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
                  'Enter your registered mobile number to receive OTP',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Step indicator (4 steps)
        _buildStepIndicator(),
        const SizedBox(height: AppSpacing.lg),

        // Step content
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _step == 0
              ? _buildStep0()
              : _step == 1
              ? _buildStep1()
              : _buildStep2(),
        ),
      ],
    );
  }

  Widget _buildStepIndicator() {
    final labels = ['Mobile', 'OTP', 'Profile', 'Access'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (i) {
        final isDone = i < _step;
        final isActive = i == _step;
        return Row(
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isDone
                        ? AppColors.success
                        : isActive
                        ? AppColors.primary
                        : const Color(0xFF1E3A5F),
                    shape: BoxShape.circle,
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              blurRadius: 12,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: isDone
                        ? const Icon(Icons.check, size: 13, color: Colors.white)
                        : Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: isActive || isDone
                                  ? Colors.white
                                  : const Color(0xFF4A6A8A),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  labels[i],
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF00B4D8)
                        : const Color(0xFF7A9BBF),
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
            if (i < labels.length - 1)
              Container(
                width: 40,
                height: 1,
                margin: const EdgeInsets.only(bottom: 20, left: 4, right: 4),
                color: i < _step ? AppColors.success : const Color(0xFF1E3A5F),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildStep0() {
    return Column(
      key: const ValueKey('step0'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.sm),
        _buildInputRow(
          label: 'Mobile Number *',
          child: TextField(
            controller: _mobileCtrl,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            style: const TextStyle(color: Color(0xFFE2E8F0)),
            decoration: InputDecoration(
              hintText: '98765 43210',

              hintStyle: const TextStyle(color: Color(0xFF4A6A8A)),
              border: InputBorder.none,
              counterText: '',
              prefixIcon: Icon(Icons.phone),
              contentPadding: const EdgeInsets.symmetric(vertical: 11),
            ),
          ),
        ),
        SizedBox(height: 10),
        _buildInputRow(
          label: 'Date of Birth (for verification)',
          child: TextField(
            controller: _dobCtrl,
            style: const TextStyle(color: Color(0xFFE2E8F0)),
            decoration: const InputDecoration(
              hintText: 'YYYY-MM-DD',
              hintStyle: TextStyle(color: Color(0xFF4A6A8A)),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Color(0xFF4A6A8A),
              ),

              contentPadding: EdgeInsets.symmetric(vertical: 11),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD166).withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFFFD166).withValues(alpha: 0.2),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 15,
                color: Color(0xFFFFD166),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'OTP will be sent via SMS & WhatsApp in English/हिंदी',
                  style: TextStyle(color: Color(0xFFFFD166), fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          text: 'Send Secure OTP',
          isLoading: _isSending,
          icon: Icons.send_rounded,
          onPressed: _sendOtp,
        ),
        const SizedBox(height: AppSpacing.md),
        _buildOrDivider('or sign in with'),
        const SizedBox(height: AppSpacing.sm),
        // Alt methods 2×2 grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 2.6,
          children: [
            _buildAltBtn(
              Icons.credit_card_rounded,
              'ABHA ID',
              const Color(0xFF00C897),
              () => widget.onSwitchTab('abha'),
            ),
            _buildAltBtn(
              Icons.fingerprint_rounded,
              'Aadhaar OTP',
              const Color(0xFFC77DFF),
              () => widget.onSwitchTab('aadhaar'),
            ),
            _buildAltBtn(
              Icons.face_rounded,
              'Face Auth',
              const Color(0xFF00B4D8),
              () => widget.onSwitchTab('face'),
            ),
            _buildAltBtn(
              Icons.groups_rounded,
              'Family Login',
              const Color(0xFFFFD166),
              () => widget.onSwitchTab('family'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
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
              Text(
                'OTP sent to +91 ${_mobileCtrl.text.isNotEmpty ? _mobileCtrl.text : 'XXXXXXXXXX'}',
                style: const TextStyle(color: AppColors.success, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const Text(
          'Enter 6-digit OTP',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF7A9BBF),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(6, (i) {
            return SizedBox(
              width: 42,
              height: 52,
              child: TextField(
                controller: _otpCtrls[i],
                focusNode: _otpFoci[i],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF1E3A5F),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF00B4D8),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Color(0xFF1E3A5F),
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (v) {
                  if (v.isNotEmpty && i < 5) {
                    _otpFoci[i + 1].requestFocus();
                  } else if (v.isEmpty && i > 0) {
                    _otpFoci[i - 1].requestFocus();
                  }
                },
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: _resendTimer > 0
              ? Text(
                  'Resend code in ${_resendTimer}s',
                  style: const TextStyle(
                    color: Color(0xFF7A9BBF),
                    fontSize: 11.5,
                  ),
                )
              : TextButton(
                  onPressed: _startTimer,
                  child: const Text('Resend OTP'),
                ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppButton(
          text: 'Verify & Login',
          isLoading: _isVerifying,
          icon: Icons.verified_user_rounded,
          onPressed: _verifyOtp,
        ),
        const SizedBox(height: AppSpacing.sm),
        TextButton.icon(
          onPressed: () => setState(() => _step = 0),
          icon: const Icon(Icons.arrow_back_rounded, size: 14),
          label: const Text('Change Number'),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    final profiles = [
      (
        initial: 'R',
        name: 'Rahul Sharma',
        rel: 'Self',
        colors: [const Color(0xFF00B4D8), const Color(0xFF4361EE)],
      ),
      (
        initial: 'P',
        name: 'Priya Sharma',
        rel: 'Spouse',
        colors: [const Color(0xFFF72585), const Color(0xFFC77DFF)],
      ),
      (
        initial: 'A',
        name: 'Aarav',
        rel: 'Son, 8yr',
        colors: [const Color(0xFF00C897), const Color(0xFF0D9488)],
      ),
    ];

    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.success.withValues(alpha: 0.25),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.success,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Identity Verified! Select your profile.',
                style: TextStyle(color: AppColors.success, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            ...profiles.map(
              (p) => Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedProfile = p.rel),
                  child: _buildProfileCard(
                    p.initial,
                    p.name,
                    p.rel,
                    p.colors,
                    _selectedProfile == p.rel,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(child: _buildAddMemberCard()),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        AppButton(
          text: 'Proceed to Dashboard',
          icon: Icons.arrow_forward_rounded,
          onPressed: widget.onSuccess,
        ),
      ],
    );
  }

  Widget _buildProfileCard(
    String initial,
    String name,
    String rel,
    List<Color> colors,
    bool isSelected,
  ) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.success.withValues(alpha: 0.07)
            : Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.success : const Color(0xFF1E3A5F),
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.success, width: 2)
                  : null,
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
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
            rel,
            style: const TextStyle(color: Color(0xFF7A9BBF), fontSize: 9),
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
    );
  }

  Widget _buildAddMemberCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4A6A8A),
          style: BorderStyle.solid,
          width: 1.5,
        ),
      ),
      child: const Column(
        children: [
          Icon(Icons.add_rounded, color: Color(0xFF4A6A8A), size: 22),
          SizedBox(height: 4),
          Text(
            'Add\nMember',
            style: TextStyle(color: Color(0xFF4A6A8A), fontSize: 9),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7A9BBF),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildAltBtn(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF1E3A5F)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: color.withValues(alpha: 0.9),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrDivider(String label) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFF1E3A5F))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFF4A6A8A), fontSize: 11),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFF1E3A5F))),
      ],
    );
  }
}
