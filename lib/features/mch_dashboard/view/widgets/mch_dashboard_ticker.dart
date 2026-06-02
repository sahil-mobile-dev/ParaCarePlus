import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/mch_dashboard/view_model/mch_dashboard_view_model.dart';

class MchDashboardTicker extends ConsumerStatefulWidget {
  const MchDashboardTicker({super.key});

  @override
  ConsumerState<MchDashboardTicker> createState() => _MchDashboardTickerState();
}

class _MchDashboardTickerState extends ConsumerState<MchDashboardTicker>
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
      duration: const Duration(milliseconds: 1300),
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
    final state = ref.watch(mchDashboardProvider);
    final kpi = state.kpiData;

    final List<Map<String, dynamic>> items = [
      {'text': 'Institutional Deliveries MTD: ${kpi.jsyBeneficiaries + 4435}', 'color': const Color(0xFFF72585), 'icon': Icons.pregnant_woman},
      {'text': 'Maternal Deaths MTD: ${kpi.neonatalDeathsMtd - 34} — MMR Target: <100/LB', 'color': AppColors.error, 'icon': Icons.warning},
      {'text': 'Live Births Today: 487', 'color': AppColors.primaryLight, 'icon': Icons.child_care},
      {'text': 'Full Immunisation Coverage: ${kpi.fullImmunisationPercent}%', 'color': AppColors.success, 'icon': Icons.local_activity},
      {'text': 'High-Risk Pregnancies Under Monitoring: ${kpi.hrPregnancies}', 'color': AppColors.secondaryAccent, 'icon': Icons.warning_amber_rounded},
      {'text': 'Severe Acute Malnutrition (SAM): ${kpi.samChildren}', 'color': const Color(0xFFC77DFF), 'icon': Icons.health_and_safety},
      {'text': 'JSY Beneficiaries MTD: ${kpi.jsyBeneficiaries}', 'color': AppColors.primaryLight, 'icon': Icons.check_circle},
      {'text': 'SNCU Admissions Today: 84', 'color': const Color(0xFFF72585), 'icon': Icons.medical_services_outlined},
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
              color: Color(0xFFF72585), // Pink theme color for MCH
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
                  'MCH MONITOR',
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
