import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/opd/model/opd_token.dart';
import 'package:paracareplus/features/opd/view_model/opd_token_view_model.dart';

class OpdTokenScreen extends ConsumerStatefulWidget {
  const OpdTokenScreen({super.key});

  @override
  ConsumerState<OpdTokenScreen> createState() => _OpdTokenScreenState();
}

class _OpdTokenScreenState extends ConsumerState<OpdTokenScreen> {
  final _formKey = GlobalKey<FormState>();

  final _searchFocus = FocusNode();
  final _departmentFocus = FocusNode();
  final _doctorFocus = FocusNode();
  final _dateFocus = FocusNode();
  final _slotFocus = FocusNode();
  final _complaintFocus = FocusNode();
  final _chargeFocus = FocusNode();
  final _submitFocus = FocusNode();

  final _searchController = TextEditingController();
  final _complaintController = TextEditingController();
  final _chargeController = TextEditingController(text: '50.00');

  int _selectedSearchIndex = -1;

  @override
  void dispose() {
    _searchFocus.dispose();
    _departmentFocus.dispose();
    _doctorFocus.dispose();
    _dateFocus.dispose();
    _slotFocus.dispose();
    _complaintFocus.dispose();
    _chargeFocus.dispose();
    _submitFocus.dispose();
    _searchController.dispose();
    _complaintController.dispose();
    _chargeController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(opdTokenViewModelProvider.notifier).issueToken();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OPD Token Issued Successfully'),
          backgroundColor: AppColors.success,
        ),
      );
      // Reset after success
      _searchController.clear();
      _complaintController.clear();
      ref.read(opdTokenViewModelProvider.notifier).reset();
      _searchFocus.requestFocus();
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
        final state = ref.read(opdTokenViewModelProvider).value;
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
    final stateAsync = ref.watch(opdTokenViewModelProvider);

    return Focus(
      autofocus: true,
      onKey: (node, event) {
        _handleKeyEvent(event);
        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text(
            'Issue OPD Token',
            style: AppTextStyles.titleMedium,
          ),
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _searchController.clear();
                _complaintController.clear();
                ref.read(opdTokenViewModelProvider.notifier).reset();
                _searchFocus.requestFocus();
              },
            ),
          ],
        ),
        body: stateAsync.when(
          data: _buildContent,
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) => Center(child: Text('Error: $e')),
        ),
      ),
    );
  }

  Widget _buildContent(OpdToken state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildPatientInfoSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildVisitSection(state),
            const SizedBox(height: AppSpacing.lg),
            _buildBillingSection(state),
            const SizedBox(height: AppSpacing.xl),
            _buildActionButtons(state),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(OpdToken state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.search, color: AppColors.primary, size: 20),
            SizedBox(width: 8),
            Text('Search Existing Patient', style: AppTextStyles.labelMedium),
          ],
        ),
        // const SizedBox(height: AppSpacing.sm),
        Stack(
          clipBehavior: Clip.none,
          children: [
            AppTextField(
              label: '',
              hintText: 'MRN / Name / Phone',
              controller: _searchController,
              focusNode: _searchFocus,
              textInputAction: TextInputAction.search,
              onChanged: (val) {
                ref
                    .read(opdTokenViewModelProvider.notifier)
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
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 300),
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
                              color: isSelected ? AppColors.primary : null,
                              fontWeight: isSelected ? FontWeight.bold : null,
                            ),
                          ),
                          subtitle: Text(
                            '${patient.mrn} • ${patient.sex} • ${patient.age} yrs',
                            style: AppTextStyles.bodySmall,
                          ),
                          trailing: Text(
                            patient.phone,
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
    ref.read(opdTokenViewModelProvider.notifier).selectPatient(patient);
    _searchController.text = patient.mrn;
    setState(() => _selectedSearchIndex = -1);
    // Focus next field
    _departmentFocus.requestFocus();
  }

  Widget _buildPatientInfoSection(OpdToken state) {
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
                Icons.person_outline,
                color: AppColors.secondaryAccent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Patient Details',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppTextField(
                  label: 'Patient Name *',
                  hintText: 'Full name',
                  initialValue: state.patientName,
                  readOnly: state.selectedPatient != null,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(patientName: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  label: 'Age',
                  hintText: 'Yrs',
                  initialValue: state.age,
                  readOnly: state.selectedPatient != null,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(age: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildDropdown(
                  label: 'Sex',
                  value: state.sex,
                  items: ['Male', 'Female', 'Other'],
                  onChanged: state.selectedPatient != null
                      ? null
                      : (val) => ref
                            .read(opdTokenViewModelProvider.notifier)
                            .updateField(sex: val),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVisitSection(OpdToken state) {
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
                Icons.medical_services_outlined,
                color: AppColors.secondaryAccent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Visit Info',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Department *',
                  value: state.department,
                  items: [
                    'General Medicine',
                    'Pediatrics',
                    'Orthopedics',
                    'Cardiology',
                    'Gynecology',
                  ],
                  focusNode: _departmentFocus,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(department: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildDropdown(
                  label: 'Select Doctor',
                  value: state.doctorName,
                  items: [
                    'Dr. Sharma (Medicine)',
                    'Dr. Verma (Pediatrics)',
                    'Dr. Gupta (Ortho)',
                  ],
                  focusNode: _doctorFocus,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(doctorName: val),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildDatePicker(
                  label: 'Appointment Date',
                  value: state.appointmentDate,
                  focusNode: _dateFocus,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(appointmentDate: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildDropdown(
                  label: 'Slot',
                  value: state.appointmentSlot,
                  items: [
                    '09:00 AM - 10:00 AM',
                    '10:00 AM - 11:00 AM',
                    '11:00 AM - 12:00 PM',
                    '02:00 PM - 03:00 PM',
                  ],
                  focusNode: _slotFocus,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(appointmentSlot: val),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Focus(
            onKey: (node, event) {
              if (event is RawKeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.enter) {
                if (event.isShiftPressed) {
                  return KeyEventResult.ignored; // Let newline happen
                } else {
                  _handleSubmit();
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: AppTextField(
              label: 'Chief Complaint',
              hintText: 'Briefly describe the symptoms...',
              controller: _complaintController,
              focusNode: _complaintFocus,
              maxLines: 3,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              onChanged: (val) => ref
                  .read(opdTokenViewModelProvider.notifier)
                  .updateField(chiefComplaint: val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingSection(OpdToken state) {
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
                Icons.payments_outlined,
                color: AppColors.secondaryAccent,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Billing',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Visit Type',
                  value: state.visitType,
                  items: ['OPD', 'Re-visit', 'Consultation'],
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(visitType: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                flex: 2,
                child: _buildDropdown(
                  label: 'Payment',
                  value: state.paymentMode,
                  items: [
                    'Cash',
                    'State Health Scheme/ AB-PMJAY',
                    'Private Insurance',
                    'UPI',
                  ],
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(paymentMode: val),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppTextField(
                  label: 'Applied Charge (₹)',
                  controller: _chargeController,
                  focusNode: _chargeFocus,
                  keyboardType: TextInputType.number,
                  onChanged: (val) => ref
                      .read(opdTokenViewModelProvider.notifier)
                      .updateField(appliedCharge: val),
                  onFieldSubmitted: (_) => _handleSubmit(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(OpdToken state) {
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
          child: AppButton(
            text: state.isSubmitting ? 'Issuing...' : 'Issue Token',
            isLoading: state.isSubmitting,
            onPressed: _handleSubmit,
            // focusNode: _submitFocus,
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
          initialValue: items.contains(value) ? value : items.first,
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

  Widget _buildDatePicker({
    required String label,
    required DateTime? value,
    required void Function(DateTime) onChanged,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: value ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 30)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: AppColors.primary,
                      onPrimary: Colors.white,
                      surface: AppColors.surface,
                      onSurface: AppColors.primaryText,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) onChanged(date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.secondaryText,
                ),
                const SizedBox(width: 8),
                Text(
                  value != null
                      ? DateFormat('dd-MM-yyyy').format(value)
                      : 'DD-MM-YYYY',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: value != null
                        ? AppColors.primaryText
                        : AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
