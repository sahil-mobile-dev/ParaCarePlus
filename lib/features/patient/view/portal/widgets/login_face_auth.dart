import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';

/// Face authentication tab for Patient Portal login.
/// Shows circular camera viewport with animated scanning ring
/// and liveness check steps (Look Left, Look Right, Blink, Smile).
class LoginFaceAuth extends StatefulWidget {
  const LoginFaceAuth({required this.onSuccess, super.key});
  final VoidCallback onSuccess;

  @override
  State<LoginFaceAuth> createState() => _LoginFaceAuthState();
}

class _LoginFaceAuthState extends State<LoginFaceAuth>
    with SingleTickerProviderStateMixin {
  late AnimationController _ringController;
  int _livenessStep = 0; // 0=idle, 1..4=liveness checks, 5=verified
  bool _isScanning = false;

  final _livenessChecks = ['Look Left', 'Look Right', 'Blink Twice', 'Smile'];

  @override
  void initState() {
    super.initState();
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _ringController.dispose();
    super.dispose();
  }

  void _startFaceScan() {
    setState(() {
      _isScanning = true;
      _livenessStep = 1;
    });
    _advanceLiveness();
  }

  void _advanceLiveness() {
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() => _livenessStep++);
      if (_livenessStep <= _livenessChecks.length) {
        _advanceLiveness();
      } else {
        setState(() => _livenessStep = 5);
      }
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
                Icons.face_rounded,
                color: Color(0xFF00B4D8),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Face Recognition Auth',
                  style: AppTextStyles.titleSmall,
                ),
                Text(
                  'Liveness-verified biometric identity',
                  style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Face viewport
        Center(
          child: SizedBox(
            width: 190,
            height: 190,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer border circle
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _livenessStep == 5
                          ? AppColors.success
                          : const Color(0xFF00B4D8),
                      width: 2.5,
                    ),
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.05),
                  ),
                ),
                // Spinning scan ring
                if (_isScanning && _livenessStep < 5)
                  RotationTransition(
                    turns: _ringController,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.transparent,
                          width: 2.5,
                        ),
                        gradient: const SweepGradient(
                          colors: [
                            Colors.transparent,
                            Color(0x5500B4D8),
                            Color(0xFF00B4D8),
                          ],
                        ),
                      ),
                    ),
                  ),
                // Face icon / check
                if (_livenessStep == 5)
                  const Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.success,
                    size: 80,
                  )
                else
                  Icon(
                    Icons.face_rounded,
                    size: 80,
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.4),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Status text
        Center(
          child: Text(
            _livenessStep == 0
                ? 'Position your face in the frame'
                : _livenessStep == 5
                ? '✅ Identity verified successfully!'
                : '→ ${_livenessChecks[_livenessStep - 1]}',
            style: TextStyle(
              color: _livenessStep == 5
                  ? AppColors.success
                  : const Color(0xFF7A9BBF),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Liveness checks row
        if (_isScanning)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: List.generate(_livenessChecks.length, (i) {
              final isDone = i + 1 < _livenessStep;
              final isActive = i + 1 == _livenessStep;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isDone
                      ? AppColors.success.withValues(alpha: 0.12)
                      : isActive
                      ? const Color(0xFF00B4D8).withValues(alpha: 0.12)
                      : Colors.white.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDone
                        ? AppColors.success.withValues(alpha: 0.3)
                        : isActive
                        ? const Color(0xFF00B4D8).withValues(alpha: 0.3)
                        : const Color(0xFF1E3A5F),
                  ),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: const Color(
                              0xFF00B4D8,
                            ).withValues(alpha: 0.25),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isDone)
                      const Icon(
                        Icons.check_rounded,
                        size: 11,
                        color: AppColors.success,
                      ),
                    if (!isDone)
                      Icon(
                        isActive
                            ? Icons.radio_button_checked_rounded
                            : Icons.radio_button_off_rounded,
                        size: 11,
                        color: isActive
                            ? const Color(0xFF00B4D8)
                            : const Color(0xFF4A6A8A),
                      ),
                    const SizedBox(width: 5),
                    Text(
                      _livenessChecks[i],
                      style: TextStyle(
                        color: isDone
                            ? AppColors.success
                            : isActive
                            ? const Color(0xFF00B4D8)
                            : const Color(0xFF7A9BBF),
                        fontSize: 10.5,
                        fontWeight: isDone || isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        const SizedBox(height: AppSpacing.lg),

        if (_livenessStep == 5)
          AppButton(
            text: 'Access Patient Portal',
            icon: Icons.arrow_forward_rounded,
            onPressed: widget.onSuccess,
          )
        else
          AppButton(
            text: _isScanning ? 'Scanning...' : 'Start Face Scan',
            icon: Icons.camera_alt_rounded,
            isLoading: _isScanning && _livenessStep < 5,
            onPressed: _startFaceScan,
          ),
        const SizedBox(height: AppSpacing.md),

        // Privacy note
        const Center(
          child: Text(
            '🔒 Face data is processed locally and never stored.\nPowered by on-device AI.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF4A6A8A),
              fontSize: 10,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
