import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';

class BbCrossmatchTab extends ConsumerStatefulWidget {
  const BbCrossmatchTab({super.key});

  @override
  ConsumerState<BbCrossmatchTab> createState() => _BbCrossmatchTabState();
}

class _BbCrossmatchTabState extends ConsumerState<BbCrossmatchTab> {
  final _bagIdController = TextEditingController(text: 'BB-UK-2025-0234');
  String _patientGroup = 'B+';
  String _majorCM = 'Compatible';
  String _minorCM = 'Compatible';
  String _autocontrol = 'Negative';

  @override
  void dispose() {
    _bagIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bloodBankProvider);
    final notifier = ref.read(bloodBankProvider.notifier);

    final req = state.selectedRequestForCrossmatch;

    // Determine compatibility
    final isCompatible = _majorCM == 'Compatible' && _minorCM == 'Compatible';
    final isIncompatible =
        _majorCM == 'Incompatible' || _minorCM == 'Incompatible';

    var resultColor = AppColors.success;
    var resultText = 'COMPATIBLE – Safe to Issue';
    var resultIcon = Icons.check_circle_rounded;
    var resultBg = AppColors.success.withValues(alpha: 0.15);

    if (isIncompatible) {
      resultColor = AppColors.error;
      resultText = 'INCOMPATIBLE – Do NOT Issue';
      resultIcon = Icons.cancel_rounded;
      resultBg = AppColors.error.withValues(alpha: 0.15);
    } else if (!isCompatible) {
      resultColor = AppColors.secondaryAccent;
      resultText = 'WEAKLY REACTIVE – Further test needed';
      resultIcon = Icons.warning_rounded;
      resultBg = AppColors.secondaryAccent.withValues(alpha: 0.15);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 900
            ? (constraints.maxWidth - AppSpacing.md) / 2
            : constraints.maxWidth;

        final isWide = constraints.maxWidth > 900;

        final leftSide = Column(
          children: [
            // Request Active Summary
            if (req != null)
              Container(
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF880E4F), Color(0xFFC62828)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.science_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Cross-Match Testing Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _buildTextRow('Patient Name', req.patientName),
                    _buildTextRow('UHID', 'UK-00512'),
                    _buildTextRow(
                      'Patient Blood Group',
                      req.bloodGroup,
                      isBoldVal: true,
                    ),
                    _buildTextRow(
                      'Requested Units',
                      '${req.units} units ${req.component}',
                    ),
                  ],
                ),
              ),

            // Form card
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.border.withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🔬 Cross-Match Result Entry',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildLabel('Patient Blood Group'),
                  _buildDropdown(
                    value: req != null ? req.bloodGroup : _patientGroup,
                    items: const [
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'O+',
                      'O-',
                      'AB+',
                      'AB-',
                    ],
                    onChanged: req != null
                        ? null
                        : (val) {
                            if (val != null) {
                              setState(() => _patientGroup = val);
                            }
                          },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildLabel('Donor Bag ID'),
                  TextField(
                    controller: _bagIdController,
                    style: AppTextStyles.bodyMedium,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.card,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Major Cross-Match'),
                            _buildDropdown(
                              value: _majorCM,
                              items: const [
                                'Compatible',
                                'Incompatible',
                                'Weakly Reactive',
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _majorCM = val);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Minor Cross-Match'),
                            _buildDropdown(
                              value: _minorCM,
                              items: const [
                                'Compatible',
                                'Incompatible',
                                'Weakly Reactive',
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _minorCM = val);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildLabel('Autocontrol'),
                  _buildDropdown(
                    value: _autocontrol,
                    items: const ['Negative', 'Positive'],
                    onChanged: (val) {
                      if (val != null) setState(() => _autocontrol = val);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Compatibility check banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: resultBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(resultIcon, color: resultColor),
                        const SizedBox(width: 8),
                        Text(
                          resultText,
                          style: TextStyle(
                            color: resultColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      minimumSize: const Size(double.infinity, 44),
                    ),
                    icon: const Icon(Icons.save_rounded, color: Colors.white),
                    label: const Text(
                      'SAVE CROSS-MATCH',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      final pName = req != null
                          ? req.patientName
                          : 'Walk-in Patient';
                      final bGroup = req != null
                          ? req.bloodGroup
                          : _patientGroup;
                      notifier.saveCrossMatch(
                        patientName: pName,
                        bagId: _bagIdController.text,
                        bloodGroup: bGroup,
                        result: isCompatible
                            ? 'Compatible'
                            : (isIncompatible
                                  ? 'Incompatible'
                                  : 'Weakly Reactive'),
                        technician: 'Lab Tech Mohan',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Cross-match compatibility results saved successfully.',
                          ),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        );

        final rightSide = Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⏱️ Cross-Match History',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(
                      AppColors.border.withValues(alpha: 0.15),
                    ),
                    columns: const [
                      DataColumn(
                        label: Text(
                          'Patient Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Bag ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Group',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Result',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Technician',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: state.crossmatchHistory.map((c) {
                      final isComp = c.result == 'Compatible';
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              c.patientName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              c.bagId,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 11,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              c.bloodGroup,
                              style: const TextStyle(
                                color: Color(0xFFC62828),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    (isComp
                                            ? AppColors.success
                                            : AppColors.error)
                                        .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                c.result.toUpperCase(),
                                style: TextStyle(
                                  color: isComp
                                      ? AppColors.success
                                      : AppColors.error,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              c.date,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              c.technician,
                              style: const TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: cardWidth, child: leftSide),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: rightSide),
            ],
          );
        } else {
          return Column(
            children: [
              leftSide,
              const SizedBox(height: AppSpacing.md),
              rightSide,
            ],
          );
        }
      },
    );
  }

  Widget _buildTextRow(String label, String value, {bool isBoldVal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isBoldVal ? FontWeight.bold : FontWeight.normal,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: AppColors.secondaryText,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
