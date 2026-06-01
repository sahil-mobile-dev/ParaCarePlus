import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class AiEsanjeevani extends StatelessWidget {
  const AiEsanjeevani({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;

          final logoWidget = Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF006B3C), Color(0xFF00A550)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: const Text('🏥', style: TextStyle(fontSize: 26)),
          );

          final detailsWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'eSanjeevani OPD — Government Telemedicine Platform',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'ABDM-linked national telemedicine service by MoHFW, GoI. Access free virtual consultations with Government doctors across all specialties. Your ABHA ID (43-8912-3456-7890) is pre-linked.',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Launching eSanjeevani OPD portal…'),
                          backgroundColor: Color(0xFF00A550),
                        ),
                      );
                    },
                    icon: const Icon(Icons.video_call_rounded, size: 14),
                    label: const Text(
                      'Join eSanjeevani OPD',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00A550),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Fetching consultation history from ABDM…',
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      'View Past Consultations',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Health records shared with eSanjeevani',
                          ),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: const Text(
                      'Share Health Records',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );

          final statsWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('2.4L+', 'Daily Consultations'),
              _buildStat('34', 'Specialties'),
              _buildStat('Free', 'Govt. OPD'),
            ],
          );

          if (isMobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    logoWidget,
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'eSanjeevani OPD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                detailsWidget,
                const SizedBox(height: 16),
                const Divider(color: AppColors.border),
                const SizedBox(height: 8),
                statsWidget,
              ],
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logoWidget,
                const SizedBox(width: 16),
                Expanded(flex: 3, child: detailsWidget),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      _buildStat('2.4L+', 'Daily Consults'),
                      const SizedBox(height: 12),
                      _buildStat('34', 'Specialties'),
                      const SizedBox(height: 12),
                      _buildStat('Free', 'Govt. OPD'),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildStat(String val, String lbl) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(
            color: AppColors.primaryLight,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          lbl,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
