import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class OpdQueueMonitor extends StatefulWidget {
  const OpdQueueMonitor({super.key});

  @override
  State<OpdQueueMonitor> createState() => _OpdQueueMonitorState();
}

class _OpdQueueMonitorState extends State<OpdQueueMonitor> {
  int _serving = 38;
  Timer? _timer;
  late StreamController<bool> _blinkController;
  Timer? _blinkTimer;
  bool _blinkState = true;

  @override
  void initState() {
    super.initState();
    _blinkController = StreamController<bool>.broadcast();
    _blinkTimer = Timer.periodic(const Duration(milliseconds: 750), (timer) {
      _blinkState = !_blinkState;
      if (!_blinkController.isClosed) {
        _blinkController.add(_blinkState);
      }
    });

    // Simulated queue movements
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted && _serving < 47) {
        setState(() {
          _serving++;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blinkTimer?.cancel();
    _blinkController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ahead = 47 - _serving;
    final waitText = ahead > 0
        ? '⏱ Estimated wait: ~${ahead * 3} minutes (AI)'
        : '🔔 Almost your turn!';
    final waitColor = ahead > 0 ? AppColors.secondaryAccent : AppColors.success;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'Live Queue Monitor — Dr. Anjali Sharma',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              StreamBuilder<bool>(
                stream: _blinkController.stream,
                initialData: true,
                builder: (context, snapshot) {
                  final visible = snapshot.data ?? true;
                  return Row(
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: visible ? 1.0 : 0.2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: AppColors.success,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Queue number big box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.12),
                  Colors.indigo.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Text(
                  'Your Queue Number',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '47',
                  style: TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: 48,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                    ),
                    children: [
                      const TextSpan(text: 'Currently Serving: '),
                      TextSpan(
                        text: '$_serving',
                        style: const TextStyle(
                          color: AppColors.primaryLight,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  waitText,
                  style: TextStyle(
                    color: waitColor,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Scrollable queue spots list
          const Text('Inline Patients', style: AppTextStyles.labelSmall),
          const SizedBox(height: 8),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border, width: 0.5),
            ),
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                _buildQueueItem(
                  token: _serving,
                  title: 'Patient in consultation',
                  status: 'IN ROOM',
                  statusBg: AppColors.primary.withValues(alpha: 0.15),
                  statusTextCol: AppColors.primaryLight,
                  isActive: true,
                ),
                if (_serving + 1 < 47)
                  _buildQueueItem(
                    token: _serving + 1,
                    title: 'Next patient up',
                    status: 'WAITING',
                    statusBg: Colors.white.withValues(alpha: 0.05),
                    statusTextCol: AppColors.secondaryText,
                  ),
                if (_serving + 2 < 47)
                  _buildQueueItem(
                    token: _serving + 2,
                    title: 'Waiting outside room',
                    status: 'WAITING',
                    statusBg: Colors.white.withValues(alpha: 0.05),
                    statusTextCol: AppColors.secondaryText,
                  ),
                if (_serving + 3 < 47)
                  _buildQueueItem(
                    token: _serving + 3,
                    title: 'Not arrived yet',
                    status: 'PENDING',
                    statusBg: Colors.white.withValues(alpha: 0.05),
                    statusTextCol: AppColors.secondaryText.withValues(
                      alpha: 0.5,
                    ),
                  ),
                if (_serving + 4 < 47)
                  _buildQueueItem(
                    token: _serving + 4,
                    title: 'Not arrived yet',
                    status: 'PENDING',
                    statusBg: Colors.white.withValues(alpha: 0.05),
                    statusTextCol: AppColors.secondaryText.withValues(
                      alpha: 0.5,
                    ),
                  ),
                if (47 - _serving > 5)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.02),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '...',
                            style: TextStyle(color: AppColors.secondaryText),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${47 - _serving - 2} more patients in front of you',
                          style: TextStyle(
                            color: AppColors.secondaryText.withValues(
                              alpha: 0.6,
                            ),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                _buildQueueItem(
                  token: 47,
                  title: 'You (Rahul Sharma)',
                  status: 'MY TURN',
                  statusBg: AppColors.success.withValues(alpha: 0.15),
                  statusTextCol: AppColors.success,
                  isMine: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem({
    required int token,
    required String title,
    required String status,
    required Color statusBg,
    required Color statusTextCol,
    bool isActive = false,
    bool isMine = false,
  }) {
    Color itemBg = Colors.white.withValues(alpha: 0.02);
    Color itemBorder = AppColors.border;

    if (isActive) {
      itemBg = AppColors.primary.withValues(alpha: 0.08);
      itemBorder = AppColors.primary.withValues(alpha: 0.25);
    } else if (isMine) {
      itemBg = AppColors.success.withValues(alpha: 0.08);
      itemBorder = AppColors.success.withValues(alpha: 0.25);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: itemBg,
        border: Border.all(color: itemBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isMine
                  ? AppColors.success
                  : (isActive ? AppColors.primaryLight : AppColors.border),
            ),
            alignment: Alignment.center,
            child: Text(
              '$token',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isMine
                    ? AppColors.success
                    : (isActive ? Colors.white : AppColors.secondaryText),
                fontSize: 12,
                fontWeight: (isActive || isMine)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: statusBg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusTextCol,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
