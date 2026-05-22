import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class PatientAlertTicker extends StatefulWidget {
  const PatientAlertTicker({super.key});

  @override
  State<PatientAlertTicker> createState() => _PatientAlertTickerState();
}

class _PatientAlertTickerState extends State<PatientAlertTicker> {
  late final ScrollController _scrollController;
  Timer? _timer;

  final List<String> _alerts = [
    '💊 Metformin 500mg due in 2 hours — 2:00 PM',
    '🩸 HbA1c Report ready — Slight elevation noted — View Now',
    '📅 Dr. Sharma (Cardiology) appointment confirmed — 20 May 10:30 AM',
    '💉 Flu Vaccine Booster due — Schedule now',
    '🏥 AB-PMJAY claim ₹12,400 approved for knee surgery',
    '🤖 AI Alert: BP readings trending upward — Review recommended',
    '📋 Annual health checkup pending — Last done 14 months ago',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    if (!_scrollController.hasClients) return;
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_scrollController.hasClients) return;
      final maxExtent = _scrollController.position.maxScrollExtent;
      final currentOffset = _scrollController.offset;
      if (currentOffset >= maxExtent) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(currentOffset + 0.8);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                right: BorderSide(color: AppColors.border, width: 0.5),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.campaign_rounded,
                  color: AppColors.secondaryAccent,
                  size: 14,
                ),
                SizedBox(width: 4),
                Text(
                  'ALERTS',
                  style: TextStyle(
                    color: AppColors.secondaryAccent,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _alerts.length * 2, // Double for seamless loop
              itemBuilder: (context, index) {
                final text = _alerts[index % _alerts.length];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Center(
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
