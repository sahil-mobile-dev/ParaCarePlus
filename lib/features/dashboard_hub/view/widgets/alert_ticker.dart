import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AlertTicker extends StatefulWidget {
  const AlertTicker({super.key});

  @override
  State<AlertTicker> createState() => _AlertTickerState();
}

class _AlertTickerState extends State<AlertTicker> {
  late ScrollController _scrollController;

  final List<TickerItemData> _items = const [
    TickerItemData(
      'ICU bed critical in Haridwar Dist. Hospital — 98% occupancy',
      Colors.red,
    ),
    TickerItemData(
      'Dengue surge: 47 new cases in Dehradun today',
      Colors.orange,
    ),
    TickerItemData(
      'AB Claim batch ₹3.2Cr settled — AIIMS Rishikesh',
      Colors.green,
    ),
    TickerItemData(
      'Medicine shortage: Paracetamol IV at CHC Doiwala — 0 stock',
      Colors.red,
    ),
    TickerItemData(
      'High-risk pregnancy alert: Pithoragarh — 12 cases flagged',
      Colors.orange,
    ),
    TickerItemData(
      'Telemedicine consultations today: 1,247 — new record',
      Colors.green,
    ),
    TickerItemData(
      'TB positive cases this week: 89 across 8 districts',
      Colors.orange,
    ),
    TickerItemData(
      'Ambulance response >30min: Chamoli — 5 incidents flagged',
      Colors.red,
    ),
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
    if (!mounted) return;
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final minScroll = _scrollController.position.minScrollExtent;

    _scrollController
        .animateTo(
          maxScroll,
          duration: Duration(seconds: _items.length * 5),
          curve: Curves.linear,
        )
        .then((_) {
          if (mounted) {
            _scrollController.jumpTo(minScroll);
            _startScrolling();
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      height: 38,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: 6,
            ),
            color: AppColors.error,
            alignment: Alignment.center,
            child: const Text(
              '🔴 LIVE ALERTS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: [
                  ..._items.map(_buildTickerItem),
                  ..._items.map(_buildTickerItem),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTickerItem(TickerItemData item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxl),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: item.color.withValues(alpha: 0.5),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.text,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class TickerItemData {
  const TickerItemData(this.text, this.color);
  final String text;
  final Color color;
}
