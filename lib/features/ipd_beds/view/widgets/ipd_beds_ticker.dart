import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/ipd_beds/view_model/ipd_beds_view_model.dart';

class IpdBedsTicker extends ConsumerStatefulWidget {
  const IpdBedsTicker({super.key});

  @override
  ConsumerState<IpdBedsTicker> createState() => _IpdBedsTickerState();
}

class _IpdBedsTickerState extends ConsumerState<IpdBedsTicker>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _pulseController;
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ipdBedsProvider);
    final kpi = state.kpiData;

    final List<Map<String, dynamic>> items = [
      {'text': 'Total Beds Statewide: ${kpi.totalBeds}', 'color': AppColors.primaryLight, 'icon': Icons.bed},
      {'text': 'ICU Occupancy: ${(kpi.icuOccupied / kpi.icuBeds * 100).toStringAsFixed(1)}% — AIIMS Rishikesh FULL', 'color': AppColors.error, 'icon': Icons.warning},
      {'text': 'Active Ambulances En Route: ${state.ambulances.length}', 'color': AppColors.secondaryAccent, 'icon': Icons.airport_shuttle_rounded},
      {'text': 'MCI Alert: Roorkee Highway Pile-Up — 14 casualties', 'color': AppColors.error, 'icon': Icons.emergency},
      {'text': 'Available Beds Now: ${kpi.availableBeds}', 'color': AppColors.success, 'icon': Icons.check_circle},
      {'text': 'ER Avg Wait Time: ${kpi.erWaitMinutes} min', 'color': AppColors.secondaryAccent, 'icon': Icons.timer_outlined},
      {'text': 'Critical Cases in ER: ${kpi.criticalCasesActive}', 'color': AppColors.error, 'icon': Icons.heart_broken_rounded},
      {'text': 'Discharges Today: ${kpi.dailyAdmissions - 235}', 'color': AppColors.success, 'icon': Icons.autorenew},
    ];

    return Container(
      height: 38,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.35),
        border: const Border(bottom: BorderSide(color: AppColors.border)),
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
                  'IPD TELEMETRY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
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
              itemCount: items.length * 10,
              itemBuilder: (context, idx) {
                final item = items[idx % items.length];
                return Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        size: 13,
                        color: item['color'] as Color,
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
