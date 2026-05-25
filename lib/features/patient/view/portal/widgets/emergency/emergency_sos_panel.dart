import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_contacts.dart';

enum SosState { idle, countdown, active }

final sosStateProvider = StateProvider<SosState>((ref) => SosState.idle);
final sosCountdownProvider = StateProvider<int>((ref) => 5);

class EmergencySosPanel extends ConsumerStatefulWidget {
  const EmergencySosPanel({super.key});

  @override
  ConsumerState<EmergencySosPanel> createState() => _EmergencySosPanelState();
}

class _EmergencySosPanelState extends ConsumerState<EmergencySosPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    ref.read(sosStateProvider.notifier).state = SosState.countdown;
    ref.read(sosCountdownProvider.notifier).state = 5;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = ref.read(sosCountdownProvider);
      if (current > 1) {
        ref.read(sosCountdownProvider.notifier).state = current - 1;
      } else {
        timer.cancel();
        ref.read(sosStateProvider.notifier).state = SosState.active;
      }
    });
  }

  void _cancelSos() {
    _timer?.cancel();
    ref.read(sosStateProvider.notifier).state = SosState.idle;
    ref.read(sosCountdownProvider.notifier).state = 5;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Emergency SOS broadcast cancelled.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sosStateProvider);
    final count = ref.watch(sosCountdownProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isLargeScreen = constraints.maxWidth > 900;

        final sosButtonWidget = _buildSosButtonWidget(state, count);
        final sosInfoWidget = _buildSosInfoWidget();

        if (isLargeScreen) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Center(child: sosButtonWidget),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: sosInfoWidget),
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Center(child: sosButtonWidget),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              sosInfoWidget,
            ],
          );
        }
      },
    );
  }

  Widget _buildSosButtonWidget(SosState state, int count) {
    if (state == SosState.countdown) {
      return GestureDetector(
        onTap: _cancelSos,
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondaryAccent, width: 3),
            boxShadow: [
              BoxShadow(
                color: AppColors.secondaryAccent.withValues(alpha: 0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'CANCEL',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final isRed = state == SosState.idle;
    final primaryGrad = isRed ? const Color(0xFFEF4444) : AppColors.success;
    final secondaryGrad = isRed
        ? const Color(0xFFCC1A35)
        : const Color(0xFF0F9F4A);
    final glowColor = isRed ? AppColors.error : AppColors.success;
    final labelText = isRed ? 'SOS' : 'ACTIVE';

    return GestureDetector(
      onTap: isRed ? _startCountdown : _cancelSos,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer pulse rings
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 120 + (_pulseController.value * 36),
                height: 120 + (_pulseController.value * 36),
                decoration: BoxDecoration(
                  color: glowColor.withValues(
                    alpha: 0.15 * (1 - _pulseController.value),
                  ),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Container(
                width: 105 + (_pulseController.value * 22),
                height: 105 + (_pulseController.value * 22),
                decoration: BoxDecoration(
                  color: glowColor.withValues(
                    alpha: 0.25 * (1 - _pulseController.value),
                  ),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
          // Center SOS button
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
              gradient: RadialGradient(colors: [primaryGrad, secondaryGrad]),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isRed
                      ? Icons.circle_notifications_rounded
                      : Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(height: 2),
                Text(
                  labelText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSosInfoWidget() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 18),
            SizedBox(width: 8),
            Text(
              'Emergency Quick Response',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 6),
        Text(
          'Press SOS to instantly alert emergency services, share your live location, and transmit your medical profile to the nearest hospital. Your ABHA health card data will be auto-sent to the receiving ER team.',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
        SizedBox(height: 12),
        EmergencyContacts(),
      ],
    );
  }
}
