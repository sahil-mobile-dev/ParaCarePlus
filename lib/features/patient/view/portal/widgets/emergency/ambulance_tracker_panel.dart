import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/emergency/emergency_sos_panel.dart';

class AmbulanceTrackerPanel extends ConsumerStatefulWidget {
  const AmbulanceTrackerPanel({super.key});

  @override
  ConsumerState<AmbulanceTrackerPanel> createState() => _AmbulanceTrackerPanelState();
}

class _AmbulanceTrackerPanelState extends ConsumerState<AmbulanceTrackerPanel> {
  Timer? _etaTimer;
  int _etaSeconds = 240;

  @override
  void initState() {
    super.initState();
    _startEtaCountdown();
  }

  @override
  void dispose() {
    _etaTimer?.cancel();
    super.dispose();
  }

  void _startEtaCountdown() {
    _etaSeconds = 240;
    _etaTimer?.cancel();
    _etaTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_etaSeconds > 0) {
        if (mounted) {
          setState(() {
            _etaSeconds--;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  String _formatEta() {
    final m = _etaSeconds ~/ 60;
    final s = _etaSeconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  void _cancelSos() {
    ref.read(sosStateProvider.notifier).state = SosState.idle;
    ref.read(sosCountdownProvider.notifier).state = 5;
    
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Emergency SOS alert cancelled.'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(
                Icons.airport_shuttle_rounded,
                color: AppColors.error,
                size: 18,
              ),
              SizedBox(width: 8),
              Text(
                'Live Ambulance Tracker — Unit UK-AMB-04',
                style: TextStyle(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Metrics Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 6 : 3;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: constraints.maxWidth > 600 ? 1.8 : 2.1,
                children: [
                  _buildMetricTile('Status', 'En Route', AppColors.success),
                  _buildMetricTile('ETA', _formatEta(), AppColors.error),
                  _buildMetricTile('Distance', '2.1 km', Colors.white),
                  _buildMetricTile('Type', 'Advanced Life Support', Colors.white),
                  _buildMetricTile('Paramedic', 'Suresh Negi', Colors.white),
                  _buildMetricTile('Vehicle No.', 'UK07 AMB 0142', Colors.white),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          
          // Progress Steps
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepDot(1, 'SOS Sent', true),
                _buildStepLine(true),
                _buildStepDot(2, 'Dispatched', true),
                _buildStepLine(true),
                _buildStepDot(3, 'En Route', true, isActive: true),
                _buildStepLine(false),
                _buildStepDot(4, 'Arrived', false),
                _buildStepLine(false),
                _buildStepDot(5, 'At Hospital', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suresh Negi',
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
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Calling Paramedic Suresh Negi...'),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.phone_rounded,
                      size: 11,
                      color: AppColors.success,
                    ),
                    label: const Text(
                      'Call Paramedic',
                      style: TextStyle(color: AppColors.success, fontSize: 9.5, fontWeight: FontWeight.bold),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.success),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
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
                        vertical: 6,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Cancel SOS',
                      style: TextStyle(color: Colors.white, fontSize: 9.5, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine(bool done) {
    return Container(
      width: 30,
      height: 2,
      color: done ? AppColors.success : AppColors.border,
    );
  }

  Widget _buildMetricTile(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
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
                : const Color(0xFF112240),
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
