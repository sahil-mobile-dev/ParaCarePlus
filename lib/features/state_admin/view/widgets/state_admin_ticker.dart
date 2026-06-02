import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StateAdminTicker extends StatefulWidget {
  const StateAdminTicker({super.key});

  @override
  State<StateAdminTicker> createState() => _StateAdminTickerState();
}

class _StateAdminTickerState extends State<StateAdminTicker> {
  late final ScrollController _scrollController;
  Timer? _scrollTimer;

  final List<Map<String, String>> _tickerItems = [
    {
      'tag': 'ALERT',
      'text': 'Dengue cases surge +34% in Haridwar — 47 new cases this week',
    },
    {
      'tag': 'CRITICAL',
      'text':
          'Blood O− stock critically low in 3 facilities: AIIMS Rishikesh, Doon Hospital, Haldwani',
    },
    {
      'tag': 'ALERT',
      'text': 'Chamoli CHC oxygen supply below 20% — resupply scheduled 14 Apr',
    },
    {
      'tag': 'INFO',
      'text':
          'Ayushman Bharat claims pending >30 days: 1,247 cases requiring SHA review',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 55), (timer) {
      if (!mounted || !_scrollController.hasClients) return;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (currentScroll >= maxScroll) {
        _scrollController.jumpTo(0);
      } else {
        _scrollController.animateTo(
          currentScroll + 1.2,
          duration: const Duration(milliseconds: 55),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: const Color(
          0xFFC62828,
        ).withValues(alpha: 0.05), // Red administrative alarm tint
        border: Border.all(color: const Color(0x33C62828)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            color: const Color(0xFFC62828),
            alignment: Alignment.center,
            child: const Row(
              children: [
                Icon(Icons.notifications_active, color: Colors.white, size: 13),
                SizedBox(width: 6),
                Text(
                  'HEALTH ALERT BULLETIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w900,
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
              itemCount: _tickerItems.length * 10,
              itemBuilder: (context, index) {
                final item = _tickerItems[index % _tickerItems.length];
                final tag = item['tag']!;
                final isCrit = tag == 'CRITICAL';

                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Color(0x1aFFFFFF))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isCrit
                              ? Colors.red.withValues(alpha: 0.3)
                              : Colors.orange.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: isCrit ? Colors.red : Colors.orange,
                            fontSize: 8.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item['text']!,
                        style: const TextStyle(
                          color: Colors.white38,
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
