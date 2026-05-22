import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

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
  Timer? _etaTimer;
  int _etaSeconds = 240;

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
    _etaTimer?.cancel();
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
        _startEtaCountdown();
      }
    });
  }

  void _startEtaCountdown() {
    _etaSeconds = 240;
    _etaTimer?.cancel();
    _etaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_etaSeconds > 0) {
        setState(() {
          _etaSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _cancelSos() {
    _timer?.cancel();
    _etaTimer?.cancel();
    ref.read(sosStateProvider.notifier).state = SosState.idle;
    ref.read(sosCountdownProvider.notifier).state = 5;
  }

  String _formatEta() {
    final m = _etaSeconds ~/ 60;
    final s = _etaSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sosStateProvider);
    final count = ref.watch(sosCountdownProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: state == SosState.active
              ? AppColors.error.withValues(alpha: 0.5)
              : AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (state == SosState.idle)
            _buildSosIdle()
          else if (state == SosState.countdown)
            _buildSosCountdown(count)
          else
            _buildSosActive(),
        ],
      ),
    );
  }

  Widget _buildSosIdle() {
    return Column(
      children: [
        const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 20),
            SizedBox(width: 8),
            Text('EMERGENCY QUICK RESPONSE', style: AppTextStyles.labelSmall),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          'Press SOS to instantly alert emergency services, share your live location, and transmit your medical profile to the nearest hospital.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: _startCountdown,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 130 + (_pulseController.value * 50),
                    height: 130 + (_pulseController.value * 50),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(
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
                    width: 110 + (_pulseController.value * 30),
                    height: 110 + (_pulseController.value * 30),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(
                        alpha: 0.25 * (1 - _pulseController.value),
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.error.withValues(alpha: 0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                  gradient: const RadialGradient(
                    colors: [Color(0xFFEF5350), Color(0xFFC62828)],
                  ),
                ),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.crisis_alert_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'SOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSosCountdown(int secondsRemaining) {
    return Column(
      children: [
        const Text(
          'TRANSMITTING ALERT TO NEAREST BASE STATION IN...',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: 20),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondaryAccent, width: 3),
          ),
          alignment: Alignment.center,
          child: Text(
            '$secondsRemaining',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: _cancelSos,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'CANCEL BROADCAST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSosActive() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Row(
          children: [
            Icon(
              Icons.airport_shuttle_rounded,
              color: AppColors.error,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'LIVE AMBULANCE TRACKER — UNIT UK-AMB-04',
              style: TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Ambulance Grid metrics
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2.1,
          children: [
            _buildMetricTile('Status', 'En Route', AppColors.success),
            _buildMetricTile('ETA', _formatEta(), AppColors.error),
            _buildMetricTile('Distance', '2.1 km', Colors.white),
            _buildMetricTile('Type', 'Advanced Life', Colors.white),
            _buildMetricTile('Paramedic', 'Suresh Negi', Colors.white),
            _buildMetricTile('Vehicle No.', 'UK07 AMB 0142', Colors.white),
          ],
        ),
        const SizedBox(height: 16),
        // Progress Steps
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStepDot(1, 'SOS Sent', true),
            _buildStepDot(2, 'Dispatched', true),
            _buildStepDot(3, 'En Route', true, isActive: true),
            _buildStepDot(4, 'Arrived', false),
            _buildStepDot(5, 'At Hospital', false),
          ],
        ),
        const SizedBox(height: 16),
        // Paramedic stats
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vikram Rawat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Assigned Paramedic Driver',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Calling Paramedic Vikram Rawat...'),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.phone_rounded,
                    size: 12,
                    color: AppColors.success,
                  ),
                  label: const Text(
                    'CALL DRIVER',
                    style: TextStyle(color: AppColors.success, fontSize: 9.5),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.success),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: _cancelSos,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                  ),
                  child: const Text(
                    'CANCEL SOS',
                    style: TextStyle(color: Colors.white, fontSize: 9.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 8.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDot(
    int step,
    String label,
    bool isDone, {
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: isDone
                ? (isActive ? AppColors.error : AppColors.success)
                : AppColors.surface,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDone
                  ? (isActive ? AppColors.error : AppColors.success)
                  : AppColors.border,
            ),
          ),
          alignment: Alignment.center,
          child: isDone && !isActive
              ? const Icon(Icons.check, color: Colors.white, size: 10)
              : Text(
                  '$step',
                  style: TextStyle(
                    color: isDone ? Colors.white : AppColors.secondaryText,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isDone ? Colors.white : AppColors.secondaryText,
            fontSize: 8.5,
            fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
