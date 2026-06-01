import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';

/// ABHA (Ayushman Bharat Health Account) login tab.
/// Shows live ABHA card preview + input + OTP flow.
class LoginAbha extends StatefulWidget {
  const LoginAbha({required this.onSuccess, super.key});
  final VoidCallback onSuccess;

  @override
  State<LoginAbha> createState() => _LoginAbhaState();
}

class _LoginAbhaState extends State<LoginAbha> {
  final _abhaCtrl = TextEditingController();
  bool _otpSent = false;
  bool _isSending = false;
  final _otpCtrls = List.generate(6, (_) => TextEditingController());
  final _otpFoci = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    _abhaCtrl.dispose();
    for (final c in _otpCtrls) {
      c.dispose();
    }
    for (final f in _otpFoci) {
      f.dispose();
    }
    super.dispose();
  }

  String _formatAbha(String raw) {
    final digits = raw.replaceAll(RegExp('[^0-9]'), '');
    if (digits.length <= 2) return digits;
    if (digits.length <= 6) {
      return '${digits.substring(0, 2)}-${digits.substring(2)}';
    }
    if (digits.length <= 10) {
      return '${digits.substring(0, 2)}-${digits.substring(2, 6)}-${digits.substring(6)}';
    }
    return '${digits.substring(0, 2)}-${digits.substring(2, 6)}-${digits.substring(6, 10)}-${digits.substring(10, digits.length.clamp(0, 14))}';
  }

  @override
  Widget build(BuildContext context) {
    final abhaDisplay = _abhaCtrl.text.isEmpty
        ? 'XX-XXXX-XXXX-XXXX'
        : _formatAbha(_abhaCtrl.text);

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
                color: AppColors.success.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.credit_card_rounded,
                color: Color(0xFF00C897),
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Login with ABHA', style: AppTextStyles.titleSmall),
                Text(
                  'Ayushman Bharat Health Account',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // ABHA card preview
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0D9488), Color(0xFF065F46)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00C897).withValues(alpha: 0.3),
            ),
          ),
          child: Stack(
            children: [
              // Decorative circle
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🏥 AYUSHMAN BHARAT HEALTH ACCOUNT',
                    style: TextStyle(
                      color: Color(0xB3FFFFFF),
                      fontSize: 9.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      abhaDisplay,
                      key: ValueKey<String>(abhaDisplay),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _abhaCtrl.text.isEmpty
                        ? 'Enter your ABHA number below'
                        : 'ABHA Verified Member',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              // QR icon
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.qr_code_rounded,
                        size: 30,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        if (!_otpSent) ...[
          // ABHA input
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ABHA Number *',
                style: TextStyle(
                  color: Color(0xFF7A9BBF),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _abhaCtrl,
                keyboardType: TextInputType.number,
                maxLength: 17,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontSize: 14,
                  letterSpacing: 1.5,
                ),
                decoration: const InputDecoration(
                  hintText: 'XX-XXXX-XXXX-XXXX',
                  hintStyle: TextStyle(
                    color: Color(0xFF4A6A8A),
                    letterSpacing: 1,
                  ),
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.symmetric(vertical: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          // ABHA Features
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3.2,
            children: const [
              _AbhaFeat(
                icon: Icons.medical_information_rounded,
                title: 'Health Records',
                sub: 'All hospital visits linked',
              ),
              _AbhaFeat(
                icon: Icons.science_rounded,
                title: 'Lab Reports',
                sub: 'Digital reports access',
              ),
              _AbhaFeat(
                icon: Icons.medication_rounded,
                title: 'Prescriptions',
                sub: 'E-prescription history',
              ),
              _AbhaFeat(
                icon: Icons.shield_rounded,
                title: 'Consent Manager',
                sub: 'Control data sharing',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppButton(
            text: 'Verify ABHA & Send OTP',
            isLoading: _isSending,
            icon: Icons.verified_rounded,
            onPressed: () async {
              if (_abhaCtrl.text.length < 8) return;
              setState(() => _isSending = true);
              await Future<void>.delayed(const Duration(milliseconds: 1200));
              if (!mounted) return;
              setState(() {
                _isSending = false;
                _otpSent = true;
              });
            },
          ),
        ] else ...[
          // OTP entry
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
                  size: 15,
                ),
                SizedBox(width: 8),
                Text(
                  'ABHA verified! OTP sent to linked mobile.',
                  style: TextStyle(color: AppColors.success, fontSize: 11.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Enter 6-digit OTP',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF7A9BBF), fontSize: 12),
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
                        color: Color(0xFF00C897),
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
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            text: 'Verify & Access Portal',
            icon: Icons.login_rounded,
            onPressed: widget.onSuccess,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: () => setState(() => _otpSent = false),
            icon: const Icon(Icons.arrow_back_rounded, size: 14),
            label: const Text('Change ABHA Number'),
          ),
        ],
      ],
    );
  }
}

class _AbhaFeat extends StatelessWidget {
  const _AbhaFeat({required this.icon, required this.title, required this.sub});
  final IconData icon;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF1E3A5F)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF00C897)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFE2E8F0),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(color: Color(0xFF7A9BBF), fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
