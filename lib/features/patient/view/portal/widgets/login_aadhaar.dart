import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';

/// Aadhaar-based OTP login tab for the Patient Portal.
class LoginAadhaar extends StatefulWidget {
  const LoginAadhaar({required this.onSuccess, super.key});
  final VoidCallback onSuccess;

  @override
  State<LoginAadhaar> createState() => _LoginAadhaarState();
}

class _LoginAadhaarState extends State<LoginAadhaar> {
  final _aadhaarCtrl = TextEditingController();
  bool _otpSent = false;
  bool _isSending = false;
  final _otpCtrls = List.generate(6, (_) => TextEditingController());
  final _otpFoci = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    _aadhaarCtrl.dispose();
    for (final c in _otpCtrls) {
      c.dispose();
    }
    for (final f in _otpFoci) {
      f.dispose();
    }
    super.dispose();
  }

  String _maskedAadhaar() {
    final t = _aadhaarCtrl.text.replaceAll(' ', '');
    if (t.length < 12) return t;
    return 'XXXX XXXX ${t.substring(8, 12)}';
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
                color: const Color(0xFFC77DFF).withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFC77DFF).withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                Icons.fingerprint_rounded,
                color: Color(0xFFC77DFF),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Login with Aadhaar OTP',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Verify using your Aadhaar-linked mobile',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        if (!_otpSent) ...[
          // Aadhaar number input
          _buildInputLabel('Aadhaar Number *'),
          const SizedBox(height: 6),
          TextField(
            controller: _aadhaarCtrl,
            keyboardType: TextInputType.number,
            maxLength: 14,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(
              color: Color(0xFFE2E8F0),
              fontSize: 16,
              letterSpacing: 2,
            ),
            decoration: const InputDecoration(
              hintText: 'XXXX XXXX XXXX',
              hintStyle: TextStyle(
                color: Color(0xFF4A6A8A),
                letterSpacing: 1.5,
              ),
              prefixIcon: Icon(
                Icons.credit_card_rounded,
                color: Color(0xFF4A6A8A),
              ),
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.symmetric(vertical: 11),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // UIDAI consent notice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFC77DFF).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFC77DFF).withValues(alpha: 0.2),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.shield_rounded,
                      size: 15,
                      color: Color(0xFFC77DFF),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'UIDAI Privacy Notice',
                      style: TextStyle(
                        color: Color(0xFFC77DFF),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'An OTP will be sent to your Aadhaar-linked mobile. '
                  'We do not store your Aadhaar number. '
                  'Verification powered by UIDAI.',
                  style: TextStyle(
                    color: Color(0xFF7A9BBF),
                    fontSize: 10,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Consent checkbox
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: true,
                  onChanged: (_) {},
                  activeColor: const Color(0xFFC77DFF),
                  side: const BorderSide(color: Color(0xFF4A6A8A)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'I consent to Aadhaar-based identity verification as per UIDAI guidelines.',
                  style: TextStyle(color: Color(0xFF7A9BBF), fontSize: 10.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          AppButton(
            text: 'Send Aadhaar OTP',
            isLoading: _isSending,
            icon: Icons.send_rounded,
            onPressed: () async {
              if (_aadhaarCtrl.text.replaceAll(' ', '').length < 12) return;
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
          // OTP sent confirmation
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
                  size: 15,
                ),
                const SizedBox(width: 8),
                Text(
                  'OTP sent to Aadhaar-linked mobile ${_maskedAadhaar()}',
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 11.5,
                  ),
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
              fontSize: 12,
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
                        color: Color(0xFFC77DFF),
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
            text: 'Verify Aadhaar & Login',
            icon: Icons.verified_user_rounded,
            onPressed: widget.onSuccess,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton.icon(
            onPressed: () => setState(() => _otpSent = false),
            icon: const Icon(Icons.arrow_back_rounded, size: 14),
            label: const Text('Change Aadhaar'),
          ),
        ],
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF7A9BBF),
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
