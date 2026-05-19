import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/patient/view_model/registration_view_model.dart';

class StepMedicalHistory extends ConsumerWidget {
  const StepMedicalHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationViewModelProvider).value;
    if (state == null) return const SizedBox.shrink();

    final notifier = ref.read(registrationViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Medical History', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.lg),

        _buildMultiSelectChips(
          label: 'Chronic Conditions (Multiple Selection Possible)',
          options: [
            'COVID-19',
            'Dengue Fever',
            'Malaria',
            'Typhoid Fever',
            'Tuberculosis',
          ],
          selectedValues: state.chronicIllnesses,
          onChanged: (v) => notifier.updateField(chronicIllnesses: v),
        ),
        const SizedBox(height: AppSpacing.lg),

        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Smoking Habit',
                value: state.smokingHabit,
                items: ['Never', 'Occasional', 'Regular'],
                onChanged: (v) => notifier.updateField(smokingHabit: v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildDropdown(
                label: 'Alcohol Habit',
                value: state.alcoholHabit,
                items: ['Never', 'Occasional', 'Regular'],
                onChanged: (v) => notifier.updateField(alcoholHabit: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        _buildDropdown(
          label: 'Vaccination History',
          value: state.vaccinationHistory,
          items: ['Up to Date', 'Partial', 'Unknown', 'None'],
          onChanged: (v) => notifier.updateField(vaccinationHistory: v),
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Family Medical History',
          hintText: 'Details of genetic or major family illnesses',
          initialValue: state.familyHistory,
          onChanged: (v) => notifier.updateField(familyHistory: v),
          textInputAction: TextInputAction.next,
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Known Allergies',
          hintText: 'e.g. Penicillin, Peanuts (Comma separated)',
          initialValue: state.allergies.join(', '),
          onChanged: (v) => notifier.updateField(
            allergies: v.split(',').map((e) => e.trim()).toList(),
          ),
          textInputAction: TextInputAction.next,
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Current Medications',
          hintText: 'List any ongoing medications',
          initialValue: state.currentMedications,
          onChanged: (v) => notifier.updateField(currentMedications: v),
          textInputAction: TextInputAction.next,
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Past Surgeries',
          hintText: 'Details of any major surgeries',
          initialValue: state.pastSurgeries,
          onChanged: (v) => notifier.updateField(pastSurgeries: v),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => notifier.nextStep(),
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildMultiSelectChips({
    required String label,
    required List<String> options,
    required List<String> selectedValues,
    required void Function(List<String>) onChanged,
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
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final isSelected = selectedValues.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                final newList = List<String>.from(selectedValues);
                if (selected) {
                  newList.add(option);
                } else {
                  newList.remove(option);
                }
                onChanged(newList);
              },
              selectedColor: AppColors.primary.withValues(alpha: 0.1),
              checkmarkColor: AppColors.primary,
              backgroundColor: AppColors.card.withValues(alpha: 0.5),
              labelStyle: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.secondaryText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border.withValues(alpha: 0.5),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: items.contains(value)
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
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
