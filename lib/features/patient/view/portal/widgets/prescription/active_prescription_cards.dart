import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ActivePrescriptionCards extends StatelessWidget {
  const ActivePrescriptionCards({super.key});

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 800 ? 2 : 1;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.1,
          children: [
            _buildRxCard(
              context,
              rxNumber: 'Rx #2026-0482',
              date: '10 May 2026',
              doctor: 'Dr. Rajesh Kumar — Cardiologist',
              hospital: 'AIIMS Rishikesh',
              validity: 'Valid: 10 May–10 Aug 2026',
              drugs: [
                {
                  'name': 'Amlodipine 5mg',
                  'dose': '1-0-0 (Morning) · 30 tablets · Refills: 2',
                  'instruction': 'Take with water. Avoid grapefruit juice.',
                  'color': const Color(0xFF00B4D8),
                },
                {
                  'name': 'Atorvastatin 10mg',
                  'dose': '0-0-1 (Night) · 30 tablets · Refills: 2',
                  'instruction': 'Take at bedtime. Avoid alcohol.',
                  'color': const Color(0xFFC77DFF),
                },
              ],
            ),
            _buildRxCard(
              context,
              rxNumber: 'Rx #2026-0471',
              date: '01 May 2026',
              doctor: 'Dr. Meena Verma — Endocrinologist',
              hospital: 'Himalayan Hospital',
              validity: 'Valid: 01 May–01 Aug 2026',
              drugs: [
                {
                  'name': 'Metformin 500mg',
                  'dose': '0-1-1 (After meals) · 60 tablets · Refills: 3',
                  'instruction': 'Take with food. Monitor blood sugar weekly.',
                  'color': const Color(0xFFF77F00),
                },
                {
                  'name': 'Vitamin D3 1000 IU',
                  'dose': '0-1-0 (After lunch) · 30 capsules · Refills: 1',
                  'instruction': 'Take with fatty meal for better absorption.',
                  'color': AppColors.success,
                },
                {
                  'name': 'Omeprazole 20mg',
                  'dose': '0-0-1 (Before dinner) · 30 capsules · Refills: 2',
                  'instruction': 'Take 30 min before meal. Avoid antacids.',
                  'color': AppColors.primaryLight,
                },
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildRxCard(
    BuildContext context, {
    required String rxNumber,
    required String date,
    required String doctor,
    required String hospital,
    required String validity,
    required List<Map<String, dynamic>> drugs,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section with gradient-like background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF00B4D8).withValues(alpha: 0.12),
                    AppColors.primaryLight.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: const Border(bottom: BorderSide(color: AppColors.border)),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        rxNumber,
                        style: const TextStyle(color: AppColors.secondaryText, fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        date,
                        style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.medical_services_rounded, color: Color(0xFF00B4D8), size: 14),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          doctor,
                          style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$hospital · $validity',
                    style: const TextStyle(color: AppColors.secondaryText, fontSize: 10),
                  ),
                ],
              ),
            ),
            // Body section with scrollable list of drugs
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: drugs.length,
                separatorBuilder: (context, index) => Container(
                  height: 0.5,
                  color: AppColors.border.withValues(alpha: 0.4),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                ),
                itemBuilder: (context, index) {
                  final drug = drugs[index];
                  final name = drug['name'] as String;
                  final dose = drug['dose'] as String;
                  final instruction = drug['instruction'] as String;
                  final color = drug['color'] as Color;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              name,
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          dose,
                          style: const TextStyle(color: AppColors.secondaryText, fontSize: 10),
                        ),
                        Text(
                          instruction,
                          style: const TextStyle(color: AppColors.secondaryText, fontSize: 9, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Footer with action buttons
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () => _showToast(context, 'Showing original prescription Rx receipt'),
                      icon: const Icon(Icons.visibility_rounded, size: 12, color: AppColors.secondaryText),
                      label: const Text('View Rx', style: TextStyle(color: Colors.white, fontSize: 9)),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () => _showToast(context, 'Downloading Rx PDF...'),
                      icon: const Icon(Icons.picture_as_pdf_rounded, size: 12, color: AppColors.secondaryText),
                      label: const Text('PDF', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      ),
                      onPressed: () => _showToast(context, 'Ordering refill from nearest pharmacy...'),
                      icon: const Icon(Icons.medication_rounded, size: 12, color: AppColors.secondaryText),
                      label: const Text('Refill', style: TextStyle(color: AppColors.secondaryText, fontSize: 9)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
