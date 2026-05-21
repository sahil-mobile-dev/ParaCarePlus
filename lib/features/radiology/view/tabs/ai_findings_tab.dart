import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AiFindingsTab extends StatefulWidget {
  const AiFindingsTab({super.key});

  @override
  State<AiFindingsTab> createState() => _AiFindingsTabState();
}

class _AiFindingsTabState extends State<AiFindingsTab> {
  final List<Map<String, dynamic>> _aiDetections = [
    {
      'id': 'CAD-7721',
      'patient': 'Amit Sharma',
      'mrn': 'MRN-7819',
      'modality': 'CT Brain',
      'model': 'NeuroNet Bleed v2.4',
      'finding': 'Acute Intracranial Hemorrhage',
      'confidence': 94.2,
      'status': 'Critical Alert',
      'color': AppColors.error,
      'heatmapUrl': 'Brain Intracerebral Left Temporal Segment',
    },
    {
      'id': 'CAD-7722',
      'patient': 'Sharda Devi',
      'mrn': 'MRN-3482',
      'modality': 'CT Chest',
      'model': 'ThoraxNodule Seg v1.8',
      'finding': 'Solid Pulmonary Nodule (Right Upper Lobe)',
      'confidence': 88.5,
      'status': 'High Risk',
      'color': AppColors.secondaryAccent,
      'heatmapUrl': 'Lung RUL 4.8mm Diameter Solid Sphere',
    },
    {
      'id': 'CAD-7723',
      'patient': 'Jasbir Singh',
      'mrn': 'MRN-9021',
      'modality': 'XR Pelvis',
      'model': 'OsteoFracture Detect v3.1',
      'finding': 'Displaced Femoral Neck Fracture',
      'confidence': 97.4,
      'status': 'Critical Alert',
      'color': AppColors.error,
      'heatmapUrl': 'Left Femur Neck Cortex Continuity Disruption',
    },
    {
      'id': 'CAD-7724',
      'patient': 'Reema Sen',
      'mrn': 'MRN-4450',
      'modality': 'MRI Brain',
      'model': 'NeuroTract Demyelination v1.2',
      'finding': 'Multiple Sclerosis Plaques (Periventricular)',
      'confidence': 81.2,
      'status': 'Moderate',
      'color': AppColors.primaryLight,
      'heatmapUrl': 'Deep White Matter Flair Hyperintensities',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsBar(),
        const SizedBox(height: AppSpacing.lg),
        _buildDetectionsGrid(),
      ],
    );
  }

  Widget _buildStatsBar() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(
                Icons.psychology_rounded,
                color: AppColors.secondaryAccent,
                size: 24,
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PACS AI Neural Coprocessor',
                    style: AppTextStyles.titleSmall,
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Real-time clinical segmentation algorithms',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppRadius.md),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _metricTile('Active Models', '14', AppColors.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: _metricTile('Cores Loading', '12%', AppColors.success),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: _metricTile(
                  'Avg CAD Latency',
                  '1.8 sec',
                  AppColors.secondaryAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metricTile(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: AppTextStyles.labelSmall.copyWith(fontSize: 8)),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextStyles.labelMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetectionsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossCount = constraints.maxWidth > 800 ? 2 : 1;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.6,
          ),
          itemCount: _aiDetections.length,
          itemBuilder: (context, index) {
            final det = _aiDetections[index];
            final id = det['id'] as String;
            final patient = det['patient'] as String;
            final modality = det['modality'] as String;
            final model = det['model'] as String;
            final finding = det['finding'] as String;
            final confidence = det['confidence'] as double;
            final status = det['status'] as String;
            final color = det['color'] as Color;
            final heatmapUrl = det['heatmapUrl'] as String;
            return Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                id,
                                style: AppTextStyles.labelSmall.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: color,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            patient,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            'Confidence',
                            style: AppTextStyles.labelSmall,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$confidence%',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 8),
                  _rowItem('Model Core', model),
                  _rowItem('Target Tissue', modality),
                  _rowItem('AI Impression', finding),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.secondaryAccent,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            'Bounding Target: $heatmapUrl',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _rowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: AppTextStyles.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
