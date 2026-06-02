import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class DiseaseSurveillanceTicker extends StatefulWidget {
  const DiseaseSurveillanceTicker({super.key});

  @override
  State<DiseaseSurveillanceTicker> createState() => _DiseaseSurveillanceTickerState();
}

class _DiseaseSurveillanceTickerState extends State<DiseaseSurveillanceTicker> {
  late final ScrollController _scrollController;
  Timer? _scrollTimer;

  final List<Map<String, dynamic>> _tickerItems = [
    {
      'text': 'ALERT: Dengue outbreak — Haridwar · 84 new cases today · RAPID RESPONSE ACTIVATED',
      'type': 'crit'
    },
    {
      'text': 'Malaria (P. falciparum) cluster — Udham Singh Nagar · 23 cases in 3 days · Spray ops initiated',
      'type': 'warn'
    },
    {
      'text': 'Typhoid containment — Pauri Garhwal · No new cases since May 10 · Surveillance active',
      'type': 'ok'
    },
    {
      'text': 'Seasonal influenza surge — Dehradun · ILI count up 34% · All PHCs on alert',
      'type': 'warn'
    },
    {
      'text': 'Scrub Typhus — Almora · 18 confirmed cases · 2 ICU admissions',
      'type': 'crit'
    },
    {
      'text': 'COVID-19 surveillance — All districts GREEN · No hospitalisations reported',
      'type': 'ok'
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted || !_scrollController.hasClients) return;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (currentScroll >= maxScroll) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.animateTo(
          currentScroll + 1.2,
          duration: const Duration(milliseconds: 50),
          curve: Curves.linear,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'crit':
        return AppColors.error;
      case 'warn':
        return AppColors.secondaryAccent;
      case 'ok':
        return AppColors.success;
      default:
        return AppColors.primaryLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: const BoxDecoration(
        color: Color(0xFF1D0B12), // Subtle dark red tint matching mockup
        border: Border(
          bottom: BorderSide(color: Color(0x33FF4D6D)),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            color: AppColors.error,
            alignment: Alignment.center,
            child: const Text(
              '🚨 DISEASE ALERTS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              // Render multiple iterations to create seamless looping feel
              itemCount: _tickerItems.length * 10,
              itemBuilder: (context, index) {
                final item = _tickerItems[index % _tickerItems.length];
                final col = _getColorForType(item['type']! as String);

                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0x22FFFFFF)),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item['type'] == 'crit' ? '☣️' : '⚠️',
                        style: TextStyle(color: col, fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['text']! as String,
                        style: TextStyle(
                          color: col.withValues(alpha: 0.95),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
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
