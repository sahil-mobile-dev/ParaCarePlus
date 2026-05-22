import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

/// Vitals Recording Activity — 2026 Calendar Heatmap
/// Renders a full-year GitHub-style contribution calendar using
/// a scrollable week-by-week grid with proper day/month labels.
class AnalyticsHeatmap extends StatelessWidget {
  const AnalyticsHeatmap({super.key});

  // Stable colour scale matching the HTML reference
  static const Color _c0 = Color(0xFF0D1F32); // 0 readings
  static const Color _c1 = Color(0xFF0A4555); // 1 reading
  static const Color _c2 = Color(0xFF0D9488); // 2 readings
  static const Color _c3 = Color(0xFF22C55E); // 3 readings
  static const Color _c4 = Color(0xFF4ADE80); // 4 readings
  static const Color _c5 = Color(0xFF86EFAC); // 5 readings

  Color _colorFor(int count) {
    if (count == 0) return _c0;
    if (count == 1) return _c1;
    if (count == 2) return _c2;
    if (count == 3) return _c3;
    if (count == 4) return _c4;
    return _c5;
  }

  /// Builds the full year 2026 data: list of 365/366 entries.
  /// Each entry is (month-index, dayOfWeek 0=Mon..6=Sun, color)
  List<(DateTime, Color)> _buildYearData() {
    final rng = math.Random(20260101);
    final start = DateTime(2026, 1, 1);
    final end = DateTime(2026, 12, 31);
    final result = <(DateTime, Color)>[];
    for (var d = start; !d.isAfter(end); d = d.add(const Duration(days: 1))) {
      final count = rng.nextInt(6); // 0–5
      result.add((d, _colorFor(count)));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final days = _buildYearData();

    // Group by ISO week (Mon = first day).
    // weekday: Mon=1..Sun=7; we use (weekday-1) as row index 0..6
    final weeks = <List<(DateTime, Color)?>>[];
    List<(DateTime, Color)?>? currentWeek;

    for (final entry in days) {
      final (date, color) = entry;
      final dow = date.weekday - 1; // 0=Mon 6=Sun

      if (currentWeek == null) {
        // Pad the first week with nulls before the first day
        currentWeek = List.filled(7, null);
        currentWeek[dow] = (date, color);
      } else {
        if (dow == 0) {
          weeks.add(currentWeek);
          currentWeek = List.filled(7, null);
        }
        currentWeek[dow] = (date, color);
      }
    }
    if (currentWeek != null) weeks.add(currentWeek);

    const double cellSize = 10;
    const double cellGap = 2.5;
    const double step = cellSize + cellGap;

    // Map week-column index → month label to show
    final Map<int, String> monthLabels = {};
    const mNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    for (var w = 0; w < weeks.length; w++) {
      // Find first non-null cell in this week
      for (final cell in weeks[w]) {
        if (cell != null) {
          final (date, _) = cell;
          if (date.day <= 7) {
            monthLabels[w] = mNames[date.month - 1];
          }
          break;
        }
      }
    }

    const dayNames = ['M', 'W', 'F'];
    const dayRows = [0, 2, 4]; // Mon, Wed, Fri indices

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Row(
            children: [
              const Icon(
                Icons.calendar_month_rounded,
                color: AppColors.primaryLight,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Vitals Recording Activity — 2026 Calendar Heatmap',
                  style: AppTextStyles.labelLarge.copyWith(fontSize: 13),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // ── Calendar grid ──
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Day-of-week labels (M / W / F)
                SizedBox(
                  width: 14,
                  child: Column(
                    children: [
                      const SizedBox(height: 14), // space for month labels
                      for (var row = 0; row < 7; row++)
                        SizedBox(
                          height: step,
                          child: dayRows.contains(row)
                              ? Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    dayNames[dayRows.indexOf(row)],
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 7,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),

                // Week columns
                for (var w = 0; w < weeks.length; w++)
                  Padding(
                    padding: const EdgeInsets.only(right: cellGap),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Month label row
                        SizedBox(
                          height: 14,
                          child: monthLabels.containsKey(w)
                              ? Text(
                                  monthLabels[w]!,
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                        // 7 day cells
                        for (var row = 0; row < 7; row++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: cellGap),
                            child: weeks[w][row] != null
                                ? _DayCell(
                                    color: weeks[w][row]!.$2,
                                    size: cellSize,
                                  )
                                : SizedBox(width: cellSize, height: cellSize),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          // ── Legend ──
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Less',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 9),
              ),
              const SizedBox(width: 4),
              for (final c in [_c0, _c1, _c2, _c3, _c4, _c5])
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: c,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              const SizedBox(width: 4),
              const Text(
                'More',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 9),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }
}
