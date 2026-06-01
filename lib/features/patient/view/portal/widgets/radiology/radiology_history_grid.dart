import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/radiology/dicom_viewer_panel.dart';

class RadiologyHistoryGrid extends ConsumerStatefulWidget {
  const RadiologyHistoryGrid({super.key});

  @override
  ConsumerState<RadiologyHistoryGrid> createState() =>
      _RadiologyHistoryGridState();
}

class _RadiologyHistoryGridState extends ConsumerState<RadiologyHistoryGrid> {
  bool _isEchoConfirmed = false;

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 900 ? 2 : 1;
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: AppSpacing.md,
          mainAxisSpacing: AppSpacing.md,
          childAspectRatio: 1.6,
          children: [
            _buildHistoryCard(
              type: 'X-Ray',
              typeBg: const Color(0xFF00B4D8).withValues(alpha: 0.15),
              typeFg: const Color(0xFF00B4D8),
              date: '28 Apr 2026',
              title: 'Chest PA + Lateral',
              meta: 'Dr. Kavita Mehta · AIIMS Rishikesh · Ref: RAD-2026-0421',
              finding:
                  'Mild cardiomegaly. Both lung fields clear. No consolidation or pleural effusion detected.',
              status: 'Abnormal',
              statusBg: AppColors.error.withValues(alpha: 0.15),
              statusFg: AppColors.error,
              onView: () {
                ref.read(activeScanIndexProvider.notifier).state = 0;
                _showToast('Loading Chest PA scan in PACS Viewer');
              },
              aiConfidence: '87%',
            ),
            _buildHistoryCard(
              type: 'Ultrasound',
              typeBg: const Color(0xFF22C55E).withValues(alpha: 0.15),
              typeFg: const Color(0xFF22C55E),
              date: '10 Mar 2026',
              title: 'USG Abdomen & Pelvis',
              meta:
                  'Dr. Priya Kapoor · Himalayan Hospital · Ref: RAD-2026-0318',
              finding:
                  'Liver mildly enlarged (15.2 cm). Mild fatty infiltration Grade I. Gall bladder, pancreas, spleen, both kidneys — normal. No free fluid.',
              status: 'Mild Change',
              statusBg: AppColors.secondaryAccent.withValues(alpha: 0.15),
              statusFg: AppColors.secondaryAccent,
              onView: () {
                ref.read(activeScanIndexProvider.notifier).state = 3;
                _showToast('Loading USG Abdomen in PACS Viewer');
              },
              aiConfidence: '91%',
            ),
            _buildHistoryCard(
              type: 'X-Ray',
              typeBg: const Color(0xFF00B4D8).withValues(alpha: 0.15),
              typeFg: const Color(0xFF00B4D8),
              date: '15 Jan 2026',
              title: 'Right Knee AP & Lateral',
              meta: 'Dr. Suresh Gupta · Doon Hospital · Ref: RAD-2026-0089',
              finding:
                  'Post-arthroscopy changes seen. Joint space preserved. No new effusion. Hardware intact. Bony alignment maintained.',
              status: 'Normal (Post-op)',
              statusBg: AppColors.success.withValues(alpha: 0.15),
              statusFg: AppColors.success,
              onView: () {
                ref.read(activeScanIndexProvider.notifier).state = 2;
                _showToast('Loading Knee AP scan in PACS Viewer');
              },
            ),
            _buildHistoryCard(
              type: 'Echo',
              typeBg: const Color(0xFFF72585).withValues(alpha: 0.15),
              typeFg: const Color(0xFFF72585),
              date: _isEchoConfirmed ? 'Confirmed' : 'Pending',
              title: '2D Echocardiogram',
              meta:
                  'Dr. Rajesh Kumar · AIIMS Rishikesh · Scheduled: 20 May 2026',
              finding:
                  'Ordered in response to mild cardiomegaly on chest X-ray. Will assess LV function, wall motion, EF%.',
              status: _isEchoConfirmed ? 'Confirmed' : 'Scheduled',
              statusBg: _isEchoConfirmed
                  ? AppColors.success.withValues(alpha: 0.15)
                  : AppColors.secondaryAccent.withValues(alpha: 0.15),
              statusFg: _isEchoConfirmed
                  ? AppColors.success
                  : AppColors.secondaryAccent,
              onView: () {
                _showToast(
                  'No DICOM images available yet for pending Echocardiogram.',
                );
              },
              isPending: !_isEchoConfirmed,
              onAction: () {
                setState(() {
                  _isEchoConfirmed = true;
                });
                _showToast('Appointment confirmed for 20 May 2026');
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHistoryCard({
    required String type,
    required Color typeBg,
    required Color typeFg,
    required String date,
    required String title,
    required String meta,
    required String finding,
    required String status,
    required Color statusBg,
    required Color statusFg,
    required VoidCallback onView,
    String? aiConfidence,
    bool isPending = false,
    VoidCallback? onAction,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: typeBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: typeFg,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
          Text(
            meta,
            style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              finding,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 9,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: statusFg,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          status,
                          style: TextStyle(
                            color: statusFg,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (aiConfidence != null) ...[
                    const SizedBox(width: 8),
                    Text(
                      'AI Confidence: $aiConfidence',
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              if (isPending) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: onAction,
                    icon: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 12,
                      color: AppColors.success,
                    ),
                    label: const Text(
                      'Confirm Appt',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => _showToast('Rx Shared'),
                    icon: const Icon(
                      Icons.share_rounded,
                      size: 12,
                      color: AppColors.secondaryText,
                    ),
                    label: const Text(
                      'Share Rx',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: onView,
                    icon: const Icon(
                      Icons.visibility_rounded,
                      size: 12,
                      color: AppColors.secondaryText,
                    ),
                    label: const Text(
                      'View',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => _showToast('Downloading scan report...'),
                    icon: const Icon(
                      Icons.download_rounded,
                      size: 12,
                      color: AppColors.secondaryText,
                    ),
                    label: const Text(
                      'Download',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => _showToast('Scan shared successfully'),
                    icon: const Icon(
                      Icons.share_rounded,
                      size: 12,
                      color: AppColors.secondaryText,
                    ),
                    label: const Text(
                      'Share',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
