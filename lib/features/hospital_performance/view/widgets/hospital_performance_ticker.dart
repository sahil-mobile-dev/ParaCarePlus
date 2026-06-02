import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class HospitalPerformanceTicker extends StatefulWidget {
  const HospitalPerformanceTicker({super.key});

  @override
  State<HospitalPerformanceTicker> createState() => _HospitalPerformanceTickerState();
}

class _HospitalPerformanceTickerState extends State<HospitalPerformanceTicker>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _pulseController;
  Timer? _scrollTimer;

  final List<Map<String, dynamic>> _tickerItems = [
    {
      'type': 'ok',
      'text': 'AIIMS Rishikesh — OT utilisation 94% · All critical care beds occupied',
    },
    {
      'type': 'crit',
      'text': 'Doon Hospital — Bed occupancy 103% · Overflow protocol activated',
    },
    {
      'type': 'ok',
      'text': 'Haldwani Base Hospital — NABH accreditation renewal completed',
    },
    {
      'type': 'warn',
      'text': 'Haridwar Dist. Hospital — 2 ventilators offline · Maintenance scheduled',
    },
    {
      'type': 'ok',
      'text': 'State OPD total today: 52,840 · Within normal range',
    },
    {
      'type': 'crit',
      'text': 'Pithoragarh Dist. Hospital — MRI machine down · Referral protocol active',
    },
    {
      'type': 'ok',
      'text': 'Readmission rate 4.2% — below 5% NHM benchmark',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    WidgetsBinding.instance.addPostFrameCallback((_) => _startAutoScrolling());
  }

  void _startAutoScrolling() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(currentScroll + 1.0);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  Color _getDotColor(String type) {
    if (type == 'crit') return AppColors.error;
    if (type == 'warn') return AppColors.secondaryAccent;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        border: const Border(bottom: BorderSide(color: Color(0x1FFFFFFF))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _pulseController,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'HOSPITAL ALERTS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tickerItems.length * 10,
              itemBuilder: (context, idx) {
                final item = _tickerItems[idx % _tickerItems.length];
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: _getDotColor(item['type'] as String),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['text'] as String,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11.5,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                      ),
                    ],
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
