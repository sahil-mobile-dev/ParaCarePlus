import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ProtocolsTab extends StatefulWidget {
  const ProtocolsTab({super.key});

  @override
  State<ProtocolsTab> createState() => _ProtocolsTabState();
}

class _ProtocolsTabState extends State<ProtocolsTab> {
  final List<Map<String, dynamic>> _protocols = [
    {
      'name': 'Brain Contrast Stroke Protocol',
      'modality': 'CT',
      'sliceThickness': '1.25 mm',
      'contrast': 'Omnipaque 350 | 80 mL',
      'delay': '25 sec (Bolus Tracking)',
      'ctdi': '58.4 mGy',
      'notes': 'Monitor for contrast extravasation. Pre-hydration required.',
    },
    {
      'name': 'Thorax High-Resolution CT (HRCT)',
      'modality': 'CT',
      'sliceThickness': '0.625 mm',
      'contrast': 'None',
      'delay': 'N/A',
      'ctdi': '12.2 mGy',
      'notes': 'Inspiratory and expiratory scans. Patient must hold breath.',
    },
    {
      'name': 'Lumbar Spine Multi-Sequence',
      'modality': 'MRI',
      'sliceThickness': '3.0 mm',
      'contrast': 'None',
      'delay': 'N/A',
      'ctdi': 'N/A',
      'notes':
          'Include Sagittal T1, T2 and Axial T2. High resolution required.',
    },
    {
      'name': 'Cardiac Functional MRI',
      'modality': 'MRI',
      'sliceThickness': '8.0 mm',
      'contrast': 'Gadovist | 15 mL',
      'delay': 'Perfusion / LGE',
      'ctdi': 'N/A',
      'notes': 'ECG-gated. Monitor heart rhythm throughout examination.',
    },
    {
      'name': 'Abdomen & Pelvis Triphasic CT',
      'modality': 'CT',
      'sliceThickness': '2.5 mm',
      'contrast': 'Visipaque 320 | 120 mL',
      'delay': 'Arterial (35s) / Portal (70s) / Delayed (3m)',
      'ctdi': '34.8 mGy',
      'notes':
          'NPO 4 hours prior. Check serum creatinine levels before contrast injection.',
    },
    {
      'name': 'Carotid Doppler Ultrasound',
      'modality': 'USG',
      'sliceThickness': 'N/A',
      'contrast': 'None',
      'delay': 'N/A',
      'ctdi': 'N/A',
      'notes': 'B-mode and spectral analysis of ICA/ECA/CCA flow velocities.',
    },
  ];

  String _filterModality = 'All';

  @override
  Widget build(BuildContext context) {
    final filtered = _filterModality == 'All'
        ? _protocols
        : _protocols.where((p) => p['modality'] == _filterModality).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderRow(),
        const SizedBox(height: AppSpacing.lg),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final p = filtered[index];
            final modality = p['modality'] as String;
            final name = p['name'] as String;
            final sliceThickness = p['sliceThickness'] as String;
            final contrast = p['contrast'] as String;
            final delay = p['delay'] as String;
            final ctdi = p['ctdi'] as String;
            final notes = p['notes'] as String;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              modality,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.primaryLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            name,
                            style: AppTextStyles.bodyLarge.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.print_outlined,
                          color: AppColors.secondaryText,
                          size: 20,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Printing $name guidelines checklist...',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(color: AppColors.border, height: 1),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _metaColumn('Slice Width', sliceThickness),
                      ),
                      Expanded(child: _metaColumn('Contrast Agent', contrast)),
                      Expanded(child: _metaColumn('Acquisition Delay', delay)),
                      if (modality == 'CT')
                        Expanded(
                          child: _metaColumn('Avg Dose (CTDIvol)', ctdi),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.secondaryAccent,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Special Instructions: $notes',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.primaryText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.science_outlined, color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text(
              'Technical Scanning Protocols',
              style: AppTextStyles.titleSmall,
            ),
          ],
        ),
        Row(
          children: ['All', 'CT', 'MRI', 'USG'].map((m) {
            final isSel = _filterModality == m;
            return Container(
              margin: const EdgeInsets.only(left: 8),
              child: ChoiceChip(
                label: Text(m),
                selected: isSel,
                onSelected: (val) {
                  if (val) setState(() => _filterModality = m);
                },
                backgroundColor: AppColors.card,
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: isSel ? Colors.white : AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _metaColumn(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.labelSmall.copyWith(fontSize: 10)),
        const SizedBox(height: 4),
        Text(
          val,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
