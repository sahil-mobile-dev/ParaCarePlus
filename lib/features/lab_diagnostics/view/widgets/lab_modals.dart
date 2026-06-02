import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/lab_diagnostics/model/lab_diagnostics_model.dart';
import 'package:paracareplus/features/lab_diagnostics/view_model/lab_diagnostics_view_model.dart';

class LabModals {
  static void showNewSample(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => const _NewSampleDialog(),
    );
  }

  static void showResultEntry(
    BuildContext context,
    WidgetRef ref,
    LabSampleItem sample,
  ) {
    showDialog(
      context: context,
      builder: (context) => _ResultEntryDialog(sample: sample),
    );
  }
}

class _NewSampleDialog extends ConsumerStatefulWidget {
  const _NewSampleDialog();

  @override
  ConsumerState<_NewSampleDialog> createState() => _NewSampleDialogState();
}

class _NewSampleDialogState extends ConsumerState<_NewSampleDialog> {
  final _patientSearchController = TextEditingController(text: 'Ramesh Kumar Singh');
  final _mrnController = TextEditingController(text: 'MRN-10021');
  String _doctor = 'Dr. Rajesh Negi';
  String _priority = 'Routine';
  String _category = 'Haematology';

  final List<String> _tests = [
    'Complete Blood Count (CBC)',
    'Liver Function Test (LFT)',
    'Kidney Function Test (KFT)',
    'Lipid Profile',
    'Thyroid Profile (T3, T4, TSH)',
    'Dengue NS1 + IgM/IgG',
    'Malaria RDT',
    'HbA1c',
    'Blood Culture',
  ];
  final Map<String, bool> _selectedTests = {};

  final List<String> _sampleTypes = [
    '🩸 Blood (EDTA)',
    '🩸 Blood (Plain)',
    '💛 Urine',
    '🫁 Sputum',
    '🧪 CSF',
  ];
  final Map<String, bool> _selectedSampleTypes = {};

  @override
  void initState() {
    super.initState();
    _selectedTests[_tests[0]] = true;
    _selectedSampleTypes[_sampleTypes[0]] = true;
  }

  @override
  void dispose() {
    _patientSearchController.dispose();
    _mrnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '🧫 Sample Registration & Specimen Collection',
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Patient info & Metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Patient Search (Name/MRN) *'),
                        TextField(
                          controller: _patientSearchController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Search patient...',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildLabel('MRN Identifier *'),
                        TextField(
                          controller: _mrnController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'MRN-...',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildLabel('Ordered By Clinic Doctor'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _doctor,
                              dropdownColor: AppColors.card,
                              style: AppTextStyles.bodyMedium,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(
                                  value: 'Dr. Rajesh Negi',
                                  child: Text('Dr. Rajesh Negi'),
                                ),
                                DropdownMenuItem(
                                  value: 'Dr. Sunita Verma',
                                  child: Text('Dr. Sunita Verma'),
                                ),
                                DropdownMenuItem(
                                  value: 'Dr. Bisht',
                                  child: Text('Dr. Bisht'),
                                ),
                                DropdownMenuItem(
                                  value: 'Dr. Kumar',
                                  child: Text('Dr. Kumar'),
                                ),
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _doctor = val);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildLabel('Priority Level'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _priority,
                              dropdownColor: AppColors.card,
                              style: AppTextStyles.bodyMedium,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(value: 'Routine', child: Text('Routine')),
                                DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
                                DropdownMenuItem(value: 'STAT', child: Text('STAT')),
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _priority = val);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  // Right Column: Tests list & Sample types
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Category'),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _category,
                              dropdownColor: AppColors.card,
                              style: AppTextStyles.bodyMedium,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(value: 'Haematology', child: Text('Haematology')),
                                DropdownMenuItem(value: 'Biochemistry', child: Text('Biochemistry')),
                                DropdownMenuItem(value: 'Microbiology', child: Text('Microbiology')),
                                DropdownMenuItem(value: 'Serology', child: Text('Serology')),
                                DropdownMenuItem(value: 'Endocrinology', child: Text('Endocrinology')),
                              ],
                              onChanged: (val) {
                                if (val != null) setState(() => _category = val);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildLabel('Select Diagnostics Profiles'),
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: ListView(
                            padding: const EdgeInsets.all(8),
                            children: _tests.map((t) {
                              return CheckboxListTile(
                                value: _selectedTests[t] ?? false,
                                activeColor: AppColors.primary,
                                checkColor: Colors.white,
                                title: Text(t, style: const TextStyle(fontSize: 12)),
                                dense: true,
                                controlAffinity: ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() => _selectedTests[t] = val ?? false);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _buildLabel('Sample Specimen Types'),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: _sampleTypes.map((st) {
                            final isSel = _selectedSampleTypes[st] ?? false;
                            return FilterChip(
                              label: Text(st, style: const TextStyle(fontSize: 11)),
                              selected: isSel,
                              selectedColor: AppColors.primary.withValues(alpha: 0.3),
                              checkmarkColor: Colors.white,
                              onSelected: (val) {
                                setState(() => _selectedSampleTypes[st] = val);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL', style: TextStyle(color: AppColors.secondaryText)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                    onPressed: () {
                      final name = _patientSearchController.text.trim();
                      final mrn = _mrnController.text.trim();
                      final selectedNames = _selectedTests.entries
                          .where((e) => e.value)
                          .map((e) => e.key)
                          .toList();

                      if (name.isEmpty || mrn.isEmpty || selectedNames.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill all mandatory fields and select a test.'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }

                      ref.read(labDiagnosticsProvider.notifier).registerSample(
                            patientName: name,
                            mrn: mrn,
                            tests: selectedNames.join(' + '),
                            category: _category,
                            priority: _priority,
                            doctor: _doctor,
                          );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: AppColors.success,
                          content: Text('Registered specimen for $name. Barcode printed!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.print_rounded, color: Colors.white),
                    label: const Text('REGISTER & PRINT BARCODE', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
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

class _ResultEntryDialog extends ConsumerStatefulWidget {
  const _ResultEntryDialog({required this.sample});
  final LabSampleItem sample;

  @override
  ConsumerState<_ResultEntryDialog> createState() => _ResultEntryDialogState();
}

class _ResultEntryDialogState extends ConsumerState<_ResultEntryDialog> {
  final _remarksController = TextEditingController();
  final _pathologistController = TextEditingController();

  final List<Map<String, dynamic>> _params = [
    {'param': 'Haemoglobin (Hb)', 'normal': 'M: 13–17 | F: 12–15', 'unit': 'g/dL', 'low': 12.0, 'high': 17.0, 'value': ''},
    {'param': 'WBC Count (TLC)', 'normal': '4,000–11,000', 'unit': '/μL', 'low': 4000.0, 'high': 11000.0, 'value': ''},
    {'param': 'Neutrophils', 'normal': '50–70%', 'unit': '%', 'low': 50.0, 'high': 70.0, 'value': ''},
    {'param': 'Lymphocytes', 'normal': '20–40%', 'unit': '%', 'low': 20.0, 'high': 40.0, 'value': ''},
    {'param': 'Eosinophils', 'normal': '1–6%', 'unit': '%', 'low': 1.0, 'high': 6.0, 'value': ''},
    {'param': 'Platelet Count', 'normal': '1,50,000–4,00,000', 'unit': '/μL', 'low': 150000.0, 'high': 400000.0, 'value': ''},
    {'param': 'PCV / Haematocrit', 'normal': '36–46%', 'unit': '%', 'low': 36.0, 'high': 46.0, 'value': ''},
  ];

  @override
  void dispose() {
    _remarksController.dispose();
    _pathologistController.dispose();
    super.dispose();
  }

  Map<String, dynamic> _computeFlag(double val, double low, double high) {
    if (val < low * 0.7 || val > high * 1.3) {
      return {
        'flag': val < low ? '↓↓ Critical Low' : '↑↑ Critical High',
        'color': AppColors.error,
        'bg': AppColors.error.withValues(alpha: 0.1),
        'isCritical': true
      };
    } else if (val < low || val > high) {
      return {
        'flag': val < low ? '↓ Low' : '↑ High',
        'color': AppColors.secondaryAccent,
        'bg': AppColors.secondaryAccent.withValues(alpha: 0.1),
        'isCritical': false
      };
    } else {
      return {
        'flag': 'Normal',
        'color': AppColors.success,
        'bg': Colors.transparent,
        'isCritical': false
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 780,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '📊 Diagnostics Result Entry — ${widget.sample.id}',
                    style: AppTextStyles.titleSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.secondaryText),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              const SizedBox(height: AppSpacing.md),
              // Patient summary info banner
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: 20,
                      child: Text(
                        widget.sample.patientName[0],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.sample.patientName, style: AppTextStyles.labelLarge),
                          const SizedBox(height: 2),
                          Text(
                            '${widget.sample.mrn} | Ordered tests: ${widget.sample.tests}',
                            style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondaryText),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.sample.priority.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.success,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              // Parameter entry table
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2.5),
                  1: FlexColumnWidth(1.5),
                  2: FlexColumnWidth(1.0),
                  3: FlexColumnWidth(2.0),
                  4: FlexColumnWidth(2.0),
                },
                border: TableBorder.all(color: AppColors.border.withValues(alpha: 0.3), width: 0.5),
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: AppColors.card),
                    children: [
                      _buildHeaderCell('Parameter'),
                      _buildHeaderCell('Result Value'),
                      _buildHeaderCell('Unit'),
                      _buildHeaderCell('Reference Limits'),
                      _buildHeaderCell('Flag Status'),
                    ],
                  ),
                  ...List<TableRow>.generate(_params.length, (index) {
                    final p = _params[index];
                    final valStr = p['value'] as String;
                    final val = double.tryParse(valStr);
                    final low = p['low'] as double;
                    final high = p['high'] as double;

                    var flagText = '—';
                    var textColor = AppColors.secondaryText;
                    var rowBg = Colors.transparent;

                    if (val != null) {
                      final calc = _computeFlag(val, low, high);
                      flagText = calc['flag'] as String;
                      textColor = calc['color'] as Color;
                      rowBg = calc['bg'] as Color;
                    }

                    return TableRow(
                      decoration: BoxDecoration(color: rowBg),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            p['param'] as String,
                            style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            height: 32,
                            child: TextField(
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: AppTextStyles.bodyMedium,
                              decoration: InputDecoration(
                                hintText: 'Enter...',
                                contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  _params[index]['value'] = val;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(p['unit'] as String, style: const TextStyle(fontSize: 12)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(p['normal'] as String, style: const TextStyle(fontSize: 12, color: AppColors.secondaryText)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            flagText,
                            style: TextStyle(
                              fontSize: 12,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Technician Remarks'),
                        TextField(
                          controller: _remarksController,
                          maxLines: 2,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Any concerns about specimen quality...',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Interpretive Pathologist Comments'),
                        TextField(
                          controller: _pathologistController,
                          maxLines: 2,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Enter Pathologist remarks...',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('CANCEL', style: TextStyle(color: AppColors.secondaryText)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryAccent),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Result values saved as draft successfully.'),
                          backgroundColor: AppColors.secondaryAccent,
                        ),
                      );
                    },
                    child: const Text('SAVE DRAFT', style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
                    onPressed: () {
                      // Prepare parameter list mapping
                      final resultList = <Map<String, dynamic>>[];
                      var hasValues = false;

                      for (final p in _params) {
                        final valStr = p['value'] as String;
                        final val = double.tryParse(valStr);
                        if (val != null) {
                          hasValues = true;
                          final calc = _computeFlag(val, p['low'] as double, p['high'] as double);
                          resultList.add({
                            'param': p['param'] as String,
                            'value': val,
                            'unit': p['unit'] as String,
                            'isCritical': calc['isCritical'] as bool,
                            'flag': calc['flag'] as String,
                          });
                        }
                      }

                      if (!hasValues) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter at least one numeric value.'),
                            backgroundColor: AppColors.error,
                          ),
                        );
                        return;
                      }

                      ref.read(labDiagnosticsProvider.notifier).submitResults(
                            sampleId: widget.sample.id,
                            remarks: _remarksController.text,
                            pathologistComment: _pathologistController.text,
                            testParameters: resultList,
                          );

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Report finalized and dispatched to Doctor Portal.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    },
                    child: const Text('FINALIZE & DISPATCH', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
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
