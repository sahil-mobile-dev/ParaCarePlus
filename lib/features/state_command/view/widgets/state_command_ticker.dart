import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateCommandTicker extends StatefulWidget {
  const StateCommandTicker({super.key});

  @override
  State<StateCommandTicker> createState() => _StateCommandTickerState();
}

class _StateCommandTickerState extends State<StateCommandTicker>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _pulseController;
  Timer? _scrollTimer;

  final List<Map<String, dynamic>> _tickerItems = [
    {'type': 'crit', 'text': 'ICU overflow risk — Haridwar Dist. Hospital 98% capacity'},
    {'type': 'warn', 'text': 'Dengue: 47 new cases Dehradun today — Outbreak Zone Active'},
    {'type': 'ok', 'text': 'AB Claim batch approved — AIIMS Rishikesh (₹3.2Cr)'},
    {'type': 'crit', 'text': 'Medicine shortage: Paracetamol IV — CHC Doiwala 0 stock'},
    {'type': 'warn', 'text': 'High-risk pregnancy: 12 cases flagged — Pithoragarh'},
    {'type': 'ok', 'text': 'Telemedicine today: 1,247 consultations — new state record'},
    {'type': 'warn', 'text': 'TB positives this week: 89 across 8 districts'},
    {'type': 'crit', 'text': 'Ambulance response >30 min: Chamoli — 5 incidents flagged'},
    {'type': 'ok', 'text': 'ABHA linked: 31.7L patients — 65.8% statewide coverage'},
    {'type': 'warn', 'text': 'AI Outbreak Risk Score: 7.4/10 — Nainital & Pithoragarh'},
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
        border: const Border(
          bottom: BorderSide(color: Color(0x1FFFFFFF), width: 1),
        ),
      ),
      child: Row(
        children: [
          // Left LIVE badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: double.infinity,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.error,
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
                  'LIVE TELEMETRY',
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
          // Scrolling list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              // Multiply items count to create infinite scroll illusion
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
