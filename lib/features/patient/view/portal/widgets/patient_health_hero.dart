import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class PatientHealthHero extends StatelessWidget {
  const PatientHealthHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryLight.withValues(alpha: 0.15),
            const Color(0xFF4361EE).withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rahul Kumar Sharma',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Male · 38 years · Blood Group: B+ · Dehradun',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.badge_rounded,
                          color: AppColors.success.withValues(alpha: 0.8),
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        const Expanded(
                          child: Text(
                            'ABHA: 12-3456-7890-0001   ·   UHID: UHD-2021-08421',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildConditionTag('Hypertension', AppColors.error),
                        _buildConditionTag(
                          'T2 Diabetes',
                          AppColors.secondaryAccent,
                        ),
                        _buildConditionTag(
                          'Penicillin Allergy',
                          const Color(0xFFC77DFF),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                children: [
                  Container(
                    width: 76,
                    height: 76,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                    child: CustomPaint(
                      painter: _ConicScorePainter(
                        score: 0.78,
                        color: AppColors.success,
                      ),
                      child: const Center(
                        child: Text(
                          '78',
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Wellness Score',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Good · +3 this month',
                    style: TextStyle(color: AppColors.success, fontSize: 8),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildVitalChip(
                  icon: Icons.favorite_rounded,
                  value: '128/82',
                  label: 'Blood Pressure',
                  color: AppColors.error,
                ),
                const SizedBox(width: 10),
                _buildVitalChip(
                  icon: Icons.speed_rounded,
                  value: '7.4%',
                  label: 'HbA1c',
                  color: AppColors.secondaryAccent,
                ),
                const SizedBox(width: 10),
                _buildVitalChip(
                  icon: Icons.scale_rounded,
                  value: '78 kg',
                  label: 'Weight',
                  color: AppColors.primaryLight,
                ),
                const SizedBox(width: 10),
                _buildVitalChip(
                  icon: Icons.air_rounded,
                  value: '98%',
                  label: 'SpO2',
                  color: AppColors.success,
                ),
                const SizedBox(width: 10),
                _buildVitalChip(
                  icon: Icons.monitor_heart_rounded,
                  value: '76 bpm',
                  label: 'Heart Rate',
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildVitalChip({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConicScorePainter extends CustomPainter {
  _ConicScorePainter({required this.score, required this.color});
  final double score;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, radius - 2, bgPaint);

    final scorePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 2),
      -1.57, // Starts from top (-90 degrees)
      6.28 * score, // Sweeps to 360 degrees * score
      false,
      scorePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ConicScorePainter oldDelegate) =>
      oldDelegate.score != score || oldDelegate.color != color;
}
