import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ReportingTab extends StatefulWidget {
  const ReportingTab({super.key});

  @override
  State<ReportingTab> createState() => _ReportingTabState();
}

class _ReportingTabState extends State<ReportingTab> {
  final TextEditingController _findingsController = TextEditingController(
    text:
        'EXAMINATION: CT Brain without contrast.\n\n'
        'CLINICAL INDICATION: Acute onset left-sided weakness and headache.\n\n'
        'FINDINGS:\n'
        '- No acute intracranial hemorrhage or large territorial infarction is visualized.\n'
        '- Grey-white matter differentiation is preserved.\n'
        '- Ventricles and sulci are within normal limits for age.\n'
        '- No midline shift or mass effect.\n'
        '- Paranasal sinuses and mastoid air cells are clear.',
  );

  final TextEditingController _impressionController = TextEditingController(
    text:
        'IMPRESSION:\n'
        '1. No acute intracranial pathology or hemorrhage identified.\n'
        '2. Age-appropriate brain volume, otherwise normal study.',
  );

  bool _isDictating = false;
  String _selectedTemplate = 'CT Brain Standard';

  final List<String> _templates = [
    'CT Brain Standard',
    'Chest HRCT Lung Screen',
    'MRI Lumbar Spine Routine',
    'Knee Joint Left Routine',
    'USG Abdomen Whole',
  ];

  void _loadTemplate(String t) {
    setState(() {
      _selectedTemplate = t;
      if (t == 'Chest HRCT Lung Screen') {
        _findingsController.text =
            'EXAMINATION: High Resolution CT Chest.\n\n'
            'CLINICAL INDICATION: Chronic cough and history of smoking.\n\n'
            'FINDINGS:\n'
            '- Lungs are well-inflated. No suspicious pulmonary nodules or masses.\n'
            '- No active consolidations, pleural effusion, or pneumothorax.\n'
            '- Minimal subpleural scarring in the lung bases.\n'
            '- Tracheobronchial tree is patent.\n'
            '- Mediastinum and hilum are unremarkable.';
        _impressionController.text =
            'IMPRESSION:\n'
            '1. No suspicious pulmonary nodules. Normal high-resolution thoracic scan.\n'
            '2. Minor subpleural base scarring, likely senile/sequela.';
      } else if (t == 'MRI Lumbar Spine Routine') {
        _findingsController.text =
            'EXAMINATION: MRI Lumbar Spine without contrast.\n\n'
            'CLINICAL INDICATION: L4-S1 radiculopathy and low back pain.\n\n'
            'FINDINGS:\n'
            '- Lumbar lordosis is maintained. Vertebral heights are preserved.\n'
            '- L4-L5: Moderate diffuse disc bulge causing mild canal narrowing.\n'
            '- L5-S1: Focal postero-central protrusion causing moderate indentation of the thecal sac.\n'
            '- No spinal cord signal abnormality.\n'
            '- Paraspinal soft tissues are normal.';
        _impressionController.text =
            'IMPRESSION:\n'
            '1. L5-S1 disc protrusion causing focal thecal sac indentation.\n'
            '2. L4-L5 diffuse disc bulge with mild central narrowing.';
      } else {
        _findingsController.text =
            'EXAMINATION: CT Brain without contrast.\n\n'
            'CLINICAL INDICATION: Acute headache.\n\n'
            'FINDINGS:\n'
            '- No acute hemorrhage or focal space occupying lesion.\n'
            '- Normal ventricular system.\n'
            '- Clear sinus cavities.';
        _impressionController.text = 'IMPRESSION:\n1. Normal CT Brain.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPatientMetadataCard(),
        const SizedBox(height: AppSpacing.xxl),
        _buildReportingWorkspaceCard(),
      ],
    );
  }

  Widget _buildPatientMetadataCard() {
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
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text('Reporting Target', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          _metaRow('Patient Name', 'Rajesh Sharma'),
          _metaRow('MRN', 'MRN-7819'),
          _metaRow('Age / Sex', '45 Years / Male'),
          _metaRow('Procedure', 'CT Brain W/O Contrast'),
          _metaRow('Date Performed', 'May 21, 2026 11:32 AM'),
          _metaRow('Referring Doctor', 'Dr. Alok Verma'),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          Text(
            'Select Report Template',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedTemplate,
                isExpanded: true,
                dropdownColor: AppColors.card,
                style: AppTextStyles.bodyMedium,
                items: _templates.map((String val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val));
                }).toList(),
                onChanged: (val) {
                  if (val != null) _loadTemplate(val);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildAIAnalysisSummary(),
        ],
      ),
    );
  }

  Widget _buildAIAnalysisSummary() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.success.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.psychology_outlined,
                color: AppColors.success,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'AI CAD Diagnostic Check',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Confidence Level: 98.6% Normal\nNo ischemia, midline deviation, or hemorrhage signatures detected by the Neural Net core.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(
            val,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportingWorkspaceCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.edit_note_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text('Report Workspace', style: AppTextStyles.titleSmall),
                ],
              ),
              Row(
                children: [
                  _speechIndicator(),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _isDictating = !_isDictating);
                      if (_isDictating) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.secondaryAccent,
                            content: Row(
                              children: [
                                Icon(Icons.mic, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  'Voice Dictation active... Speak clearly into microphone.',
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      _isDictating ? Icons.mic_off_rounded : Icons.mic_rounded,
                      size: 16,
                    ),
                    label: Text(
                      _isDictating ? 'Stop Dictating' : 'Start Dictation',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isDictating
                          ? AppColors.error
                          : AppColors.secondaryAccent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(0, 36),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          Text(
            'Findings / Description',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _findingsController,
              maxLines: 8,
              style: AppTextStyles.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter findings here...',
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Impression / Conclusion',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: _impressionController,
              maxLines: 3,
              style: AppTextStyles.bodyMedium,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter impression here...',
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Report saved as Draft successfully.'),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.border),
                  foregroundColor: AppColors.secondaryText,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: const Text('SAVE DRAFT'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.success,
                      content: Text(
                        'Radiology Report Approved & Signed off! Sent to Patient Portal.',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'APPROVE & SIGN REPORT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _speechIndicator() {
    if (!_isDictating) return const SizedBox.shrink();
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: AppColors.error,
        shape: BoxShape.circle,
      ),
    );
  }
}
