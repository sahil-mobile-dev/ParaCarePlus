import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view_model/registration_view_model.dart';
import 'package:intl/intl.dart';

class StepConfirmPrint extends ConsumerWidget {
  const StepConfirmPrint({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationViewModelProvider).value;
    if (state == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Review Registration', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.lg),

        _buildSummaryCard(
          title: 'Personal Details',
          items: [
            _SummaryItem('Name', '${state.title.label} ${state.fullName}'),
            _SummaryItem(
              'DOB',
              state.dateOfBirth != null
                  ? DateFormat('dd-MMM-yyyy').format(state.dateOfBirth!)
                  : 'N/A',
            ),
            _SummaryItem(
              'Age/Gender',
              '${state.age} Years / ${state.gender.label}',
            ),
            _SummaryItem('Blood Group', state.bloodGroup.label),
            _SummaryItem(
              'Aadhaar',
              state.aadhaarNumber.isEmpty ? 'N/A' : state.aadhaarNumber,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        _buildSummaryCard(
          title: 'Contact Information',
          items: [
            _SummaryItem('Mobile', state.mobileNumber),
            _SummaryItem('Email', state.email.isEmpty ? 'N/A' : state.email),
            _SummaryItem(
              'Address',
              '${state.address}, ${state.city}, ${state.state} - ${state.pincode}',
            ),
            _SummaryItem(
              'Emergency',
              '${state.emergencyContactName} (${state.emergencyContactNumber})',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        _buildSummaryCard(
          title: 'Visit Details',
          items: [
            _SummaryItem('Type', state.visitType),
            _SummaryItem('Department', state.department),
            _SummaryItem('Complaint', state.primaryComplaint),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),

        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.print, color: AppColors.primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Clicking "Register & Print" will generate a registration slip and save the record.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required List<_SummaryItem> items,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.secondaryAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(color: AppColors.border, height: 24),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      item.label,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem {
  final String label;
  final String value;
  _SummaryItem(this.label, this.value);
}
