import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/blood_bank/view_model/blood_bank_view_model.dart';

class BbIssueTab extends ConsumerStatefulWidget {
  const BbIssueTab({super.key});

  @override
  ConsumerState<BbIssueTab> createState() => _BbIssueTabState();
}

class _BbIssueTabState extends ConsumerState<BbIssueTab> {
  final _reqNoController = TextEditingController(text: 'REQ-001');
  final _uhidController = TextEditingController(text: 'UK-00512');
  final _nameController = TextEditingController(text: 'Kishore Negi');
  final _bagIdController = TextEditingController(text: 'BB-UK-2025-0234');
  String _component = 'PCV/RCC';
  final _unitsController = TextEditingController(text: '2');
  final _issuedByController = TextEditingController(text: 'Lab Tech Mohan');
  final _receivedByController = TextEditingController();
  String _crossMatchDone = 'Yes – Compatible';

  @override
  void dispose() {
    _reqNoController.dispose();
    _uhidController.dispose();
    _nameController.dispose();
    _bagIdController.dispose();
    _unitsController.dispose();
    _issuedByController.dispose();
    _receivedByController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bloodBankProvider);
    final notifier = ref.read(bloodBankProvider.notifier);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = constraints.maxWidth > 900
            ? (constraints.maxWidth - AppSpacing.md) / 2
            : constraints.maxWidth;

        final isWide = constraints.maxWidth > 900;

        final leftSide = Container(
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
                '📤 Issue Blood Units',
                style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Request Reference No'),
                        TextField(
                          controller: _reqNoController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Patient UHID'),
                        TextField(
                          controller: _uhidController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Patient Full Name'),
              TextField(
                controller: _nameController,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Donor Bag ID(s) to Dispatch'),
              TextField(
                controller: _bagIdController,
                style: AppTextStyles.bodyMedium,
                decoration: InputDecoration(
                  hintText: 'e.g. BB-UK-2025-0234',
                  filled: true,
                  fillColor: AppColors.card,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Component Type'),
                        _buildDropdown(
                          value: _component,
                          items: const ['Whole Blood', 'PCV/RCC', 'Platelets', 'FFP', 'Cryoprecipitate'],
                          onChanged: (val) {
                            if (val != null) setState(() => _component = val);
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
                        _buildLabel('Volume Units'),
                        TextField(
                          controller: _unitsController,
                          style: AppTextStyles.bodyMedium,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Issued By Staff'),
                        TextField(
                          controller: _issuedByController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Received By Clinician / Nurse'),
                        TextField(
                          controller: _receivedByController,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Enter name...',
                            filled: true,
                            fillColor: AppColors.card,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildLabel('Compatibility Verification'),
              _buildDropdown(
                value: _crossMatchDone,
                items: const ['Yes – Compatible', 'Emergency Issue'],
                onChanged: (val) {
                  if (val != null) setState(() => _crossMatchDone = val);
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC62828),
                  minimumSize: const Size(double.infinity, 44),
                ),
                icon: const Icon(Icons.send_rounded, color: Colors.white),
                label: const Text('ISSUE BLOOD BAG', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  final name = _nameController.text.trim();
                  final reqNo = _reqNoController.text.trim();
                  final bagId = _bagIdController.text.trim();
                  final units = int.tryParse(_unitsController.text.trim()) ?? 1;

                  if (name.isEmpty || bagId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill patient name and Donor bag ID.')),
                    );
                    return;
                  }

                  notifier.issueBlood(
                    reqNo: reqNo,
                    patientName: name,
                    bagId: bagId,
                    component: _component,
                    units: units,
                    issuedBy: _issuedByController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Blood unit issued. Dispatch record logged in history.'),
                      backgroundColor: AppColors.success,
                    ),
                  );
                },
              ),
            ],
          ),
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
                '⏱️ Issue History Logs',
                style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.md),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(AppColors.border.withValues(alpha: 0.15)),
                    columns: const [
                      DataColumn(label: Text('Issue No', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Patient Name', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Bag ID', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Component', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Date Issued', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: state.issueHistory.map((i) {
                      final isTransfused = i.status == 'Transfused';
                      return DataRow(
                        cells: [
                          DataCell(Text(i.issueNo, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'))),
                          DataCell(Text(i.patientName, style: const TextStyle(fontWeight: FontWeight.bold))),
                          DataCell(Text(i.bagId, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
                          DataCell(Text(i.component)),
                          DataCell(Text(i.date, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText))),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: (isTransfused ? Colors.indigo : AppColors.success).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                i.status.toUpperCase(),
                                style: TextStyle(
                                  color: isTransfused ? Colors.indigoAccent : AppColors.success,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
