import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EMRVisitsTab extends StatelessWidget {
  const EMRVisitsTab({super.key});

  static const List<Map<String, dynamic>> _visits = [
    {
      'date': '8 May 2026',
      'dept': 'Endocrinology',
      'doctor': 'Dr. Rajesh Kumar',
      'diag': 'Diabetes Review · Teleconsult',
      'icon': Icons.video_camera_back_rounded,
      'color': Color(0xFF3A86FF),
    },
    {
      'date': '2 Apr 2026',
      'dept': 'Cardiology & Vacc',
      'doctor': 'Dr. Anjali Sharma',
      'diag': 'Routine Review · COVID Booster',
      'icon': Icons.local_hospital_rounded,
      'color': Color(0xFF00B4D8),
    },
    {
      'date': '18 Feb 2026',
      'dept': 'Internal Medicine',
      'doctor': 'Dr. Suresh Rawat',
      'diag': 'HTN Protocol Update',
      'icon': Icons.medication_rounded,
      'color': Color(0xFFF77F00),
    },
    {
      'date': '14 Nov 2025',
      'dept': 'Emergency Medicine',
      'doctor': 'Dr. Vikas Mehta',
      'diag': 'Hypertensive Crisis · 6h IPD',
      'icon': Icons.warning_rounded,
      'color': Color(0xFFFF4D6D),
    },
    {
      'date': '5 Mar 2025',
      'dept': 'Orthopaedics',
      'doctor': 'Dr. Anil Gupta',
      'diag': 'Knee Arthroscopy · Surgery',
      'icon': Icons.biotech_rounded,
      'color': Color(0xFFC77DFF),
    },
    {
      'date': '20 Sep 2025',
      'dept': 'General Checkup',
      'doctor': 'PathKind Diagnostics',
      'diag': 'Annual Full Panel',
      'icon': Icons.science_rounded,
      'color': Color(0xFFFFD166),
    },
    {
      'date': '3 Jun 2024',
      'dept': 'Ophthalmology',
      'doctor': 'Dr. Meena Bisht',
      'diag': 'Annual Eye Checkup · Normal',
      'icon': Icons.visibility_rounded,
      'color': Color(0xFF00B4D8),
    },
    {
      'date': '12 Jan 2024',
      'dept': 'Dentistry',
      'doctor': 'Dr. Pooja Singh',
      'diag': 'Scaling + Filling',
      'icon': Icons.mood_rounded,
      'color': Color(0xFF22C55E),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'VISIT SUMMARIES & CONSULTATIONS',
              style: AppTextStyles.labelSmall,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '28 Visits Total',
                style: TextStyle(
                  color: Color(0xFF00B4D8),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Grid View of visits
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.sm,
            mainAxisSpacing: AppSpacing.sm,
            childAspectRatio: 1.45,
          ),
          itemCount: _visits.length,
          itemBuilder: (context, index) {
            final visit = _visits[index];
            final color = visit['color'] as Color;

            return InkWell(
              onTap: () => _showVisitDetails(context, visit),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(visit['icon'] as IconData, color: color, size: 16),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            visit['dept'] as String,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      visit['date'] as String,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 9.5,
                      ),
                    ),
                    Text(
                      visit['doctor'] as String,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      visit['diag'] as String,
                      style: TextStyle(
                        color: color,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showVisitDetails(BuildContext context, Map<String, dynamic> visit) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: (visit['color'] as Color).withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    visit['icon'] as IconData,
                    color: visit['color'] as Color,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    visit['dept'] as String,
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Colors.white70,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: 8),
              _buildDetailRow('Consulting Date', visit['date'] as String),
              _buildDetailRow('Treating Expert', visit['doctor'] as String),
              _buildDetailRow('Primary Diagnosis', visit['diag'] as String),
              _buildDetailRow('Clinical Center', 'AIIMS Rishikesh OPD Section'),
              _buildDetailRow('Consent Lock Status', 'ABDM Verified'),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Downloading full consultation summary...',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('DOWNLOAD VISIT RECORD'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
