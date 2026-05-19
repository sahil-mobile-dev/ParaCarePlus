import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class TemplateManagerTab extends StatefulWidget {
  const TemplateManagerTab({super.key});

  @override
  State<TemplateManagerTab> createState() => _TemplateManagerTabState();
}

class _TemplateManagerTabState extends State<TemplateManagerTab> {
  final List<Map<String, dynamic>> _templates = [
    {
      'code': 'T-CBC',
      'name': 'Complete Blood Count (CBC)',
      'dept': 'Hematology',
      'parameters': 14,
      'unitSystem': 'SI Units / Metric',
    },
    {
      'code': 'T-LFT',
      'name': 'Liver Function Test (LFT)',
      'dept': 'Biochemistry',
      'parameters': 8,
      'unitSystem': 'g/dL, U/L, mg/dL',
    },
    {
      'code': 'T-LIPID',
      'name': 'Lipid Profile Screen',
      'dept': 'Biochemistry',
      'parameters': 5,
      'unitSystem': 'mg/dL',
    },
    {
      'code': 'T-RFT',
      'name': 'Renal Function Test (RFT)',
      'dept': 'Biochemistry',
      'parameters': 6,
      'unitSystem': 'mg/dL, mmol/L',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action Header Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Diagnostic Reference Range Templates',
              style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showCreateTemplateDialog();
              },
              icon: const Icon(Icons.playlist_add_rounded, size: 16),
              label: const Text('Create Template'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: AppTextStyles.labelSmall.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Grid Deck
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _templates.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 2 : 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 180,
          ),
          itemBuilder: (context, index) {
            final temp = _templates[index];
            return Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        temp['code'] as String,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          temp['dept'] as String,
                          style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondaryText),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    temp['name'] as String,
                    style: AppTextStyles.labelLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tracked Parameters: ${temp['parameters']} fields',
                    style: AppTextStyles.bodySmall,
                  ),
                  Text(
                    'Measurement Standard: ${temp['unitSystem']}',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Configuring template parameters for ${temp['code']}'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.settings_suggest_rounded, size: 14, color: AppColors.primary),
                        label: const Text('Configure Ranges', style: TextStyle(color: AppColors.primary, fontSize: 11)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _showCreateTemplateDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.card,
          title: Text('Create Diagnostic Template', style: AppTextStyles.titleMedium),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogField('Template Code (e.g. T-CBC)'),
                const SizedBox(height: 12),
                _buildDialogField('Template Test Name'),
                const SizedBox(height: 12),
                _buildDialogField('Department / Laboratory'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.secondaryText)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: AppColors.success,
                    content: Text('New Diagnostics Reference Template Created!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDialogField(String label) {
    return TextField(
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.secondaryText, fontSize: 13),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
      ),
    );
  }
}
