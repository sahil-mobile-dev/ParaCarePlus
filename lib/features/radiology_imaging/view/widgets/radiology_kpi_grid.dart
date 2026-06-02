import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:paracareplus/features/abdm_compliance/view/widgets/abdm_kpi_card.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyKpiGrid extends ConsumerWidget {
  const RadiologyKpiGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radiologyImagingProvider);
    final kpis = state.kpis;

    final cards = [
      {
        'title': "Today's Orders",
        'value': kpis.todayOrders.toString(),
        'subText': '12 pending scan',
        'emoji': '📋',
        'colorTheme': 'blue',
        'trendUp': true,
      },
      {
        'title': 'Completed Scans',
        'value': kpis.completed.toString(),
        'subText': '64.6% completion rate',
        'emoji': '✅',
        'colorTheme': 'green',
        'trendUp': true,
      },
      {
        'title': 'Urgent / STAT',
        'value': kpis.urgentStat.toString(),
        'subText': 'Awaiting priority scan',
        'emoji': '⚠️',
        'colorTheme': 'red',
        'trendUp': false,
      },
      {
        'title': 'Reports Pending',
        'value': kpis.reportsPending.toString(),
        'subText': 'Radiologist queue',
        'emoji': '🩺',
        'colorTheme': 'yellow',
        'trendUp': false,
      },
      {
        'title': 'AI Flagged',
        'value': kpis.aiFlagged.toString(),
        'subText': 'Requires medical audit',
        'emoji': '🤖',
        'colorTheme': 'purple',
        'trendUp': false,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 900 ? 5 : (constraints.maxWidth > 600 ? 3 : 2);
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.6,
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return AbdmKpiCard(
              title: card['title'] as String,
              value: card['value'] as String,
              subText: card['subText'] as String,
              emoji: card['emoji'] as String,
              colorTheme: card['colorTheme'] as String,
              trendUp: card['trendUp'] as bool?,
            );
          },
        );
      },
    );
  }
}
