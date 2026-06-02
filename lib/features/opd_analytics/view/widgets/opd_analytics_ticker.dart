import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class OpdAnalyticsTicker extends StatefulWidget {
  const OpdAnalyticsTicker({super.key});

  @override
  State<OpdAnalyticsTicker> createState() => _OpdAnalyticsTickerState();
}

class _OpdAnalyticsTickerState extends State<OpdAnalyticsTicker>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _pulseController;
  Timer? _scrollTimer;

  final List<Map<String, dynamic>> _tickerItems = [
    {
      'type': 'warn',
      'text': 'Doon Hospital OPD — Queue length 142 · Avg wait 48 min · 3 counters open',
    },
    {
      'type': 'ok',
      'text': 'AIIMS Rishikesh — 3,200 patients served today · ABHA scan rate 78%',
    },
    {
      'type': 'warn',
      'text': 'Haridwar DH — General Medicine OPD at 140% capacity · Overflow triage active',
    },
    {
      'type': 'ok',
      'text': 'Haldwani Base — Token system operational · Avg wait 22 min',
    },
    {
      'type': 'ok',
      'text': 'Total state OPD today: 52,840 · +4.7% vs 30-day avg',
    },
    {
      'type': 'warn',
      'text': 'Orthopaedics OPD Srinagar — Doctor absent · Patients being redirected',
    },
    {
      'type': 'ok',
      'text': 'Telemedicine OPD today: 4,218 consultations · eSanjeevani platform',
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
              color: Color(0xFF00838F),
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
                  'OPD LIVE',
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
