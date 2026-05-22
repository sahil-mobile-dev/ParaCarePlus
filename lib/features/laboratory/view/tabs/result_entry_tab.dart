import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ResultEntryTab extends StatefulWidget {
  const ResultEntryTab({super.key});

  @override
  State<ResultEntryTab> createState() => _ResultEntryTabState();
}

class _ResultEntryTabState extends State<ResultEntryTab> {
  final TextEditingController _reportIdController = TextEditingController();
  bool _isLoaded = false;
  String? _loadedSampleId;

  // Controllers for parameters input
  final TextEditingController _hbController = TextEditingController(
    text: '10.5',
  );
  final TextEditingController _rbcController = TextEditingController(
    text: '4.2',
  );
  final TextEditingController _wbcController = TextEditingController(
    text: '11.2',
  );
  final TextEditingController _pltController = TextEditingController(
    text: '250',
  );

  // Diagnostic warning states derived from values
  String _getHbStatus(double val) {
    if (val < 13.5) return 'Low';
    if (val > 17.5) return 'High';
    return 'Normal';
  }

  String _getRbcStatus(double val) {
    if (val < 4.5) return 'Low';
    if (val > 5.9) return 'High';
    return 'Normal';
  }

  String _getWbcStatus(double val) {
    if (val < 4.0) return 'Low';
    if (val > 11.0) return 'High';
    return 'Normal';
  }

  String _getPltStatus(double val) {
    if (val < 150) return 'Low';
    if (val > 450) return 'High';
    return 'Normal';
  }

  Color _getStatusColor(String status) {
    if (status == 'Low' || status == 'High') return AppColors.error;
    return AppColors.success;
  }

  @override
  void dispose() {
    _reportIdController.dispose();
    _hbController.dispose();
    _rbcController.dispose();
    _wbcController.dispose();
    _pltController.dispose();
    super.dispose();
  }

  void _loadSample() {
    final text = _reportIdController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.error,
          content: Text('Please enter a valid Report Number or Sample ID.'),
        ),
      );
      return;
    }
    setState(() {
      _isLoaded = true;
      _loadedSampleId = text;
    });
  }

  void _unloadSample() {
    setState(() {
      _isLoaded = false;
      _loadedSampleId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return _buildSearchAndLoadLayout();
    } else {
      return _buildParameterInputLayout();
    }
  }

  Widget _buildSearchAndLoadLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Blue Info Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Enter a Report Number or Sample ID, then click Load Sample. If multiple in-progress tests exist under the same order request, separate parameter templates will render below.',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primaryText,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // 2. Load Action Bar
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Load Diagnostic Template',
                style: AppTextStyles.labelLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Access sample diagnostic fields to input analysis values.',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _reportIdController,
                      style: AppTextStyles.bodyMedium,
                      decoration: const InputDecoration(
                        hintText:
                            'Enter Report Number (e.g. IPDPAT-20260513-00001)',
                        prefixIcon: Icon(
                          Icons.fingerprint_rounded,
                          color: AppColors.secondaryText,
                          size: 20,
                        ),
                        hintStyle: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 48,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: _loadSample,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'LOAD SAMPLE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParameterInputLayout() {
    // Parse double values for warnings
    final hb = double.tryParse(_hbController.text) ?? 0.0;
    final rbc = double.tryParse(_rbcController.text) ?? 0.0;
    final wbc = double.tryParse(_wbcController.text) ?? 0.0;
    final plt = double.tryParse(_pltController.text) ?? 0.0;

    final hbStatus = _getHbStatus(hb);
    final rbcStatus = _getRbcStatus(rbc);
    final wbcStatus = _getWbcStatus(wbc);
    final pltStatus = _getPltStatus(plt);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Patient banner card
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Patient: Mr. Nilesh Patel',
                    style: AppTextStyles.labelLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'MRN-99812 | Male / 45 Yrs | Ward: IPD General Bed-03',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Sample ID: $_loadedSampleId',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Template: Complete Blood Count (CBC)',
                    style: TextStyle(
                      color: AppColors.secondaryAccent,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Parameter input table/grid
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  'Complete Blood Count (CBC) Parameters',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  children: [
                    _buildParameterRow(
                      'Hemoglobin (Hb)',
                      _hbController,
                      '13.5 - 17.5',
                      'g/dL',
                      hbStatus,
                    ),
                    const SizedBox(height: 16),
                    _buildParameterRow(
                      'Red Blood Cells (RBC)',
                      _rbcController,
                      '4.5 - 5.9',
                      'M/uL',
                      rbcStatus,
                    ),
                    const SizedBox(height: 16),
                    _buildParameterRow(
                      'White Blood Cells (WBC)',
                      _wbcController,
                      '4.0 - 11.0',
                      'K/uL',
                      wbcStatus,
                    ),
                    const SizedBox(height: 16),
                    _buildParameterRow(
                      'Platelet Count',
                      _pltController,
                      '150 - 450',
                      'K/uL',
                      pltStatus,
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              // Bottom actions
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: _unloadSample,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        foregroundColor: AppColors.secondaryText,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text('CANCEL'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: AppColors.success,
                            content: Text(
                              'Diagnostic results for Mr. Nilesh Patel saved & dispatched successfully!',
                            ),
                          ),
                        );
                        _unloadSample();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'SAVE & DISPATCH',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildParameterRow(
    String name,
    TextEditingController controller,
    String refRange,
    String unit,
    String status,
  ) {
    final statusColor = _getStatusColor(status);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: controller,
                  style: AppTextStyles.bodyMedium,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 60,
              child: Text(
                unit,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Text(
                'Ref: $refRange',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 80,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: statusColor.withValues(alpha: 0.3)),
              ),
              alignment: Alignment.center,
              child: Text(
                status,
                style: AppTextStyles.labelSmall.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
