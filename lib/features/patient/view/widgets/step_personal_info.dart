import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/patient/model/patient_enums.dart';
import 'package:paracareplus/features/patient/view_model/registration_view_model.dart';

class StepPersonalInfo extends ConsumerWidget {
  const StepPersonalInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationViewModelProvider).value;
    if (state == null) return const SizedBox.shrink();

    final notifier = ref.read(registrationViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Personal Information', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.lg),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildDropdown<PatientTitle>(
                label: 'Title',
                value: state.title,
                items: PatientTitle.values,
                itemLabel: (t) => t.label,
                onChanged: (v) => notifier.updateField(title: v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              flex: 4,
              child: AppTextField(
                label: 'Full Name *',
                hintText: "Patient's full name",
                initialValue: state.fullName,
                onChanged: (v) => notifier.updateField(fullName: v),
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: state.dateOfBirth ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (date != null) {
                    notifier.updateField(dateOfBirth: date);
                  }
                },
                child: AbsorbPointer(
                  child: AppTextField(
                    label: 'Date of Birth *',
                    hintText: 'DD-MM-YYYY',
                    controller: TextEditingController(
                      text: state.dateOfBirth != null
                          ? DateFormat('dd-MM-yyyy').format(state.dateOfBirth!)
                          : '',
                    ),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                label: 'Age (Auto)',
                hintText: 'Auto-calculated',
                controller: TextEditingController(text: state.age),
                readOnly: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _buildDropdown<Gender>(
                label: 'Gender *',
                value: state.gender,
                items: Gender.values,
                itemLabel: (g) => g.label,
                onChanged: (v) => notifier.updateField(gender: v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildDropdown<BloodGroup>(
                label: 'Blood Group',
                value: state.bloodGroup,
                items: BloodGroup.values,
                itemLabel: (b) => b.label,
                onChanged: (v) => notifier.updateField(bloodGroup: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Aadhaar Number',
          hintText: 'XXXX XXXX XXXX',
          initialValue: state.aadhaarNumber,
          onChanged: (v) => notifier.updateField(aadhaarNumber: v),
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Ayushman Bharat ID',
          hintText: 'AB-PMJAY ID',
          initialValue: state.ayushmanBharatId,
          onChanged: (v) => notifier.updateField(ayushmanBharatId: v),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _buildDropdown<MaritalStatus>(
                label: 'Marital Status',
                value: state.maritalStatus,
                items: MaritalStatus.values,
                itemLabel: (m) => m.label,
                onChanged: (v) => notifier.updateField(maritalStatus: v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildDropdown<Religion>(
                label: 'Religion',
                value: state.religion,
                items: Religion.values,
                itemLabel: (r) => r.label,
                onChanged: (v) => notifier.updateField(religion: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Occupation',
                hintText: 'Farmer / Govt. Employee etc.',
                initialValue: state.occupation,
                onChanged: (v) => notifier.updateField(occupation: v),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => notifier.nextStep(),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildDropdown<Category>(
                label: 'Category',
                value: state.category,
                items: Category.values,
                itemLabel: (c) => c.label,
                onChanged: (v) => notifier.updateField(category: v),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) itemLabel,
    required ValueChanged<T?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          isExpanded: true,
          initialValue: items.contains(value)
              ? value
              : (items.isNotEmpty ? items.first : null),
          dropdownColor: AppColors.card,
          style: AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(itemLabel(item), overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
