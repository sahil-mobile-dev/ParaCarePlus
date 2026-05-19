import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/ipd/model/ipd_admission.dart';
import 'package:paracareplus/features/ipd/view_model/ipd_admission_view_model.dart';
import 'package:paracareplus/features/opd/model/opd_token.dart';

class IpdAdmissionScreen extends ConsumerStatefulWidget {
  const IpdAdmissionScreen({super.key});

  @override
  ConsumerState<IpdAdmissionScreen> createState() => _IpdAdmissionScreenState();
}

class _IpdAdmissionScreenState extends ConsumerState<IpdAdmissionScreen> {
  final _formKey = GlobalKey<FormState>();

  final _searchFocus = FocusNode();
  final _departmentFocus = FocusNode();
  final _reasonFocus = FocusNode();
  final _wardFocus = FocusNode();
  final _bedFocus = FocusNode();
  final _doctorFocus = FocusNode();
  final _durationFocus = FocusNode();
  final _paymentFocus = FocusNode();
  final _depositFocus = FocusNode();
  final _instructionsFocus = FocusNode();
  final _submitFocus = FocusNode();

  final _searchController = TextEditingController();
  final _reasonController = TextEditingController();
  final _depositController = TextEditingController(text: '5000');
  final _instructionsController = TextEditingController();

  int _selectedSearchIndex = -1;

  @override
  void dispose() {
    _searchFocus.dispose();
    _departmentFocus.dispose();
    _reasonFocus.dispose();
    _wardFocus.dispose();
    _bedFocus.dispose();
    _doctorFocus.dispose();
    _durationFocus.dispose();
    _paymentFocus.dispose();
    _depositFocus.dispose();
    _instructionsFocus.dispose();
    _submitFocus.dispose();
    _searchController.dispose();
    _reasonController.dispose();
    _depositController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(ipdAdmissionViewModelProvider.notifier).admitPatient();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Patient Admitted Successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.isAltPressed) {
        if (event.logicalKey == LogicalKeyboardKey.keyN) {
          _handleSubmit();
        } else if (event.logicalKey == LogicalKeyboardKey.keyB) {
          Navigator.of(context).pop();
        }
      }

      // Arrow keys for search results
      if (_searchFocus.hasFocus) {
        final state = ref.read(ipdAdmissionViewModelProvider).value;
        if (state != null && state.searchResults.isNotEmpty) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            setState(() {
              _selectedSearchIndex =
                  (_selectedSearchIndex + 1) % state.searchResults.length;
            });
          } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            setState(() {
              _selectedSearchIndex = _selectedSearchIndex <= 0
                  ? state.searchResults.length - 1
                  : _selectedSearchIndex - 1;
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(ipdAdmissionViewModelProvider);

    return Focus(
      autofocus: true,
      onKey: (node, event) {
        _handleKeyEvent(event);
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text('IPD Admission', style: AppTextStyles.titleMedium),
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: stateAsync.when(
          data: _buildContent,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildContent(IpdAdmission state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPatientSearchSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildAdmissionDetailsSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildBedSelectionSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildPaymentSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildBedAvailabilityPreview(state),
            const SizedBox(height: AppSpacing.xl),
            _buildActionButtons(state),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientSearchSection(IpdAdmission state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.search, color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text('Patient (Search MRN)', style: AppTextStyles.labelMedium),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Stack(
          clipBehavior: Clip.none,
          children: [
            AppTextField(
              label: '',
              hintText: 'MRN-XXXXX or Name',
              controller: _searchController,
              focusNode: _searchFocus,
              textInputAction: TextInputAction.search,
              onChanged: (val) {
                ref
                    .read(ipdAdmissionViewModelProvider.notifier)
                    .updateField(searchQuery: val);
                setState(() => _selectedSearchIndex = -1);
              },
              onFieldSubmitted: (_) {
                if (_selectedSearchIndex != -1 &&
                    state.searchResults.isNotEmpty) {
                  _onPatientSelected(state.searchResults[_selectedSearchIndex]);
                } else if (state.searchResults.isNotEmpty) {
                  _onPatientSelected(state.searchResults.first);
                }
              },
            ),
            if (state.searchResults.isNotEmpty)
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                bottom: 10,
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 250),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.searchResults.length,
                      separatorBuilder: (context, index) =>
                          const Divider(height: 1, color: AppColors.border),
                      itemBuilder: (context, index) {
                        final patient = state.searchResults[index];
                        final isSelected = _selectedSearchIndex == index;
                        return ListTile(
                          tileColor: isSelected
                              ? AppColors.primary.withValues(alpha: 0.2)
                              : null,
                          title: Text(
                            patient.name,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                          subtitle: Text(
                            '${patient.mrn} • ${patient.sex} • ${patient.age} yrs',
                            style: AppTextStyles.bodySmall,
                          ),
                          onTap: () => _onPatientSelected(patient),
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  void _onPatientSelected(PatientSummary patient) {
    ref.read(ipdAdmissionViewModelProvider.notifier).selectPatient(patient);
    _searchController.text = patient.mrn;
    setState(() => _selectedSearchIndex = -1);
    _departmentFocus.requestFocus();
  }

  Widget _buildAdmissionDetailsSection(IpdAdmission state) {
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
          _buildDropdown(
            label: 'Department *',
            value: state.department,
            items: [
              'General Medicine',
              'Pediatrics',
              'Orthopedics',
              'Cardiology',
              'Surgery',
            ],
            focusNode: _departmentFocus,
            onChanged: (val) => ref
                .read(ipdAdmissionViewModelProvider.notifier)
                .updateField(department: val),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Admission Reason / Diagnosis',
            hintText: 'Primary diagnosis or admission reason...',
            controller: _reasonController,
            focusNode: _reasonFocus,
            maxLines: 2,
            onChanged: (val) => ref
                .read(ipdAdmissionViewModelProvider.notifier)
                .updateField(admissionReason: val),
          ),
        ],
      ),
    );
  }

  Widget _buildBedSelectionSection(IpdAdmission state) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Ward',
                  value: state.ward,
                  items: ['General Ward', 'ICU', 'Semi-Private', 'Private'],
                  focusNode: _wardFocus,
                  onChanged: (val) => ref
                      .read(ipdAdmissionViewModelProvider.notifier)
                      .updateField(ward: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildDropdown(
                  label: 'Bed',
                  value: state.selectedBed,
                  items: state.availableBeds
                      .where((b) => b.wardName == state.ward)
                      .map((b) => b.id)
                      .toList(),
                  focusNode: _bedFocus,
                  onChanged: (val) => ref
                      .read(ipdAdmissionViewModelProvider.notifier)
                      .updateField(selectedBed: val),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Admitting Doctor',
                  value: state.doctorName,
                  items: ['Dr. Sharma', 'Dr. Verma', 'Dr. Gupta'],
                  focusNode: _doctorFocus,
                  onChanged: (val) => ref
                      .read(ipdAdmissionViewModelProvider.notifier)
                      .updateField(doctorName: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildDropdown(
                  label: 'Expected Duration',
                  value: state.expectedDuration,
                  items: [
                    '1-3 days',
                    '3-7 days',
                    '1-2 weeks',
                    'More than 2 weeks',
                  ],
                  focusNode: _durationFocus,
                  onChanged: (val) => ref
                      .read(ipdAdmissionViewModelProvider.notifier)
                      .updateField(expectedDuration: val),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection(IpdAdmission state) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Payment / Insurance',
                  value: state.paymentMode,
                  items: ['Cash', 'Insurance', 'State Health Scheme'],
                  focusNode: _paymentFocus,
                  onChanged: (val) => ref
                      .read(ipdAdmissionViewModelProvider.notifier)
                      .updateField(paymentMode: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  label: 'Advance Deposit (₹)',
                  hintText: '₹ 5000',
                  controller: _depositController,
                  focusNode: _depositFocus,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => ref
                      .read(ipdAdmissionViewModelProvider.notifier)
                      .updateField(advanceDeposit: val),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Special Instructions',
            hintText: 'Any special nursing or dietary instructions...',
            controller: _instructionsController,
            focusNode: _instructionsFocus,
            maxLines: 2,
            onChanged: (val) => ref
                .read(ipdAdmissionViewModelProvider.notifier)
                .updateField(specialInstructions: val),
            onFieldSubmitted: (_) => _submitFocus.requestFocus(),
          ),
        ],
      ),
    );
  }

  Widget _buildBedAvailabilityPreview(IpdAdmission state) {
    final filteredBeds = state.availableBeds
        .where((b) => b.wardName == state.ward)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.bed, color: AppColors.secondaryAccent, size: 20),
            SizedBox(width: 8),
            Text(
              '🛏️ Bed Availability Preview',
              style: AppTextStyles.labelMedium,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${state.ward} (${filteredBeds.length} beds available)',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: filteredBeds.map((bed) {
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: state.selectedBed == bed.id
                            ? AppColors.primary.withValues(alpha: 0.2)
                            : AppColors.card,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: state.selectedBed == bed.id
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            bed.id,
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${bed.roomNumber} • Bed',
                            style: AppTextStyles.labelSmall.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(IpdAdmission state) {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(context).pop(),
            isOutlined: true,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          flex: 2,
          child: Focus(
            onKey: (node, event) {
              if (event is RawKeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.tab &&
                  !event.isShiftPressed) {
                // Keep focus on Admit button on forward tab
                return KeyEventResult.handled;
              }
              return KeyEventResult.ignored;
            },
            child: AppButton(
              text: state.isSubmitting ? 'Admitting...' : 'Admit Patient',
              isLoading: state.isSubmitting,
              onPressed: _handleSubmit,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?)? onChanged,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: items.contains(value)
              ? value
              : (items.isNotEmpty ? items.first : null),
          focusNode: focusNode,
          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: AppTextStyles.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          isExpanded: true,
          dropdownColor: AppColors.surface,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
      ],
    );
  }
}
