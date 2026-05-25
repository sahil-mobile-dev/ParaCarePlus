import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class FeedbackSidePanel extends StatelessWidget {
  const FeedbackSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 14),
        _ExperienceSummary(),
        const SizedBox(height: 14),
        _FeedbackBreakdown(),
        const SizedBox(height: 14),
        _DeptRatings(),
        const SizedBox(height: 14),
        _HospitalResponse(),
      ],
    );
  }
}

// ── Experience Summary Panel ──
class _ExperienceSummary extends StatelessWidget {
  static const _dims = [
    ('Doctor Communication', 0.96, AppColors.success, '4.8'),
    ('Wait Time', 0.68, AppColors.secondaryAccent, '3.4'),
    ('Facility & Cleanliness', 0.86, AppColors.success, '4.3'),
    ('HIMS Portal', 0.94, AppColors.primaryLight, '4.7'),
    ('Pharmacy Service', 0.90, AppColors.success, '4.5'),
    ('Lab & Diagnostics', 0.82, AppColors.primaryLight, '4.1'),
  ];

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: 'Your Experience Summary',
      icon: Icons.workspace_premium_rounded,
      iconColor: AppColors.secondaryAccent,
      child: Column(
        children: [
          // Score hero
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '4.6',
                style: TextStyle(
                  color: AppColors.secondaryAccent,
                  fontSize: 52,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  '/5',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              return Icon(
                i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                color: AppColors.secondaryAccent,
                size: 20,
              );
            }),
          ),
          const SizedBox(height: 4),
          const Text(
            'Excellent · Based on 18 visits',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 11),
          ),
          const SizedBox(height: 14),
          // Dimension bars
          ..._dims.map(
            (d) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      d.$1,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: d.$2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: d.$3,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 28,
                    child: Text(
                      d.$4,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: d.$3,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Feedback Breakdown (Donut-like bar) ──
class _FeedbackBreakdown extends StatelessWidget {
  static const _segments = [
    (0.61, AppColors.success, '5 Stars (61%)'),
    (0.28, AppColors.primaryLight, '4 Stars (28%)'),
    (0.08, AppColors.secondaryAccent, '3 Stars (8%)'),
    (0.03, AppColors.error, '≤2 Stars (3%)'),
  ];

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: 'Feedback Breakdown',
      icon: Icons.pie_chart_outline_rounded,
      iconColor: const Color(0xFFC77DFF),
      child: Column(
        children: [
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _DonutPainter(),
              child: const Center(
                child: Text(
                  '18\nreviews',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 4,
            alignment: WrapAlignment.center,
            children: _segments.map((s) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, color: s.$2, size: 8),
                  const SizedBox(width: 4),
                  Text(s.$3, style: TextStyle(color: s.$2, fontSize: 10)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.height / 2 - 8;

    const segments = [
      (0.61, AppColors.success),
      (0.28, AppColors.primaryLight),
      (0.08, AppColors.secondaryAccent),
      (0.03, AppColors.error),
    ];

    var startAngle = -3.14159 / 2;
    for (final seg in segments) {
      final sweep = seg.$1 * 2 * 3.14159;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        startAngle,
        sweep,
        false,
        Paint()
          ..color = seg.$2
          ..style = PaintingStyle.stroke
          ..strokeWidth = 22
          ..strokeCap = StrokeCap.butt,
      );
      // Gap
      startAngle += sweep + 0.02;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Department Ratings ──
class _DeptRatings extends StatelessWidget {
  static const _depts = [
    ('Gen Medicine', 0.92, AppColors.success),
    ('Orthopaedics', 0.96, AppColors.primaryLight),
    ('Cardiology', 0.86, Color(0xFFC77DFF)),
    ('Endocrinology', 0.90, AppColors.secondaryAccent),
    ('Emergency', 0.84, AppColors.error),
    ('Lab', 0.82, Color(0xFF4361EE)),
  ];

  @override
  Widget build(BuildContext context) {
    return _PanelBox(
      title: 'Department Ratings',
      icon: Icons.local_hospital_outlined,
      iconColor: AppColors.success,
      child: Column(
        children: _depts.map((d) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 90,
                  child: Text(
                    d.$1,
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: d.$2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: d.$3.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  (d.$2 * 5).toStringAsFixed(1),
                  style: TextStyle(
                    color: d.$3,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ── Hospital Response ──
class _HospitalResponse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const _PanelBox(
      title: 'Hospital Response',
      icon: Icons.reply_rounded,
      iconColor: AppColors.primaryLight,
      child: Column(
        children: [
          _ResponseCard(
            orgColor: AppColors.primaryLight,
            orgLabel: 'AIIMS Rishikesh — Quality Team',
            orgIcon: Icons.account_balance_rounded,
            message:
                'Thank you for your feedback on wait times, Ramesh ji. We have implemented a digital token system for Cardiology OPD. Average wait time has reduced from 68 min to 42 min since March 2026.',
            footer: 'Response to 15 Mar 2026 feedback · Responded in 4.2 hrs',
          ),
          SizedBox(height: 8),
          _ResponseCard(
            orgColor: AppColors.success,
            orgLabel: 'AIIMS Lab Services',
            orgIcon: Icons.science_outlined,
            message:
                'We noted your suggestion for SMS notification on report readiness. This feature has been added to the HIMS patient portal from May 2026. Thank you for helping us improve!',
            footer:
                'Response to 10 May 2026 lab feedback · Responded in 2.8 hrs',
          ),
        ],
      ),
    );
  }
}

class _ResponseCard extends StatelessWidget {
  const _ResponseCard({
    required this.orgColor,
    required this.orgLabel,
    required this.orgIcon,
    required this.message,
    required this.footer,
  });

  final Color orgColor;
  final String orgLabel;
  final IconData orgIcon;
  final String message;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: orgColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: orgColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(orgIcon, color: orgColor, size: 13),
              const SizedBox(width: 6),
              Text(
                orgLabel,
                style: TextStyle(
                  color: orgColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 11,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            footer,
            style: TextStyle(
              color: AppColors.secondaryText.withValues(alpha: 0.7),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────── Panel Box ───────────────────────
class _PanelBox extends StatelessWidget {
  const _PanelBox({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 14),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
