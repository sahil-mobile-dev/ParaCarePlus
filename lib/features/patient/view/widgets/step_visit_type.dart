import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/patient/view_model/registration_view_model.dart';

class StepVisitType extends ConsumerWidget {
  const StepVisitType({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationViewModelProvider).value;
    if (state == null) return const SizedBox.shrink();

    final notifier = ref.read(registrationViewModelProvider.notifier);

    final isOPD = state.visitType == 'OPD';
    final isEmergency = state.visitType == 'Emergency';
    final isIPD = state.visitType == 'IPD';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Visit Details', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.lg),

        _buildDropdown(
          label: 'Visit Type',
          value: state.visitType,
          items: ['OPD', 'IPD', 'Emergency', 'Day Care'],
          onChanged: (v) => notifier.updateField(visitType: v),
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Department',
                value: state.department,
                items: [
                  'General Medicine',
                  'Pediatrics',
                  'Orthopedics',
                  'Cardiology',
                  'Gastroenterology',
                ],
                onChanged: (v) => notifier.updateField(department: v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildDropdown(
                label: 'Doctor *',
                value: state.doctorName,
                items: [
                  'Dr. Sharma (Medicine)',
                  'Dr. Verma (Pediatrics)',
                  'Dr. Gupta (Ortho)',
                  'Dr. Reddy (Cardio)',
                ],
                onChanged: (v) => notifier.updateField(doctorName: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        if (isOPD || isEmergency) ...[
          Row(
            children: [
              Expanded(
                child: _buildDatePicker(
                  context: context,
                  label: 'Appointment Date *',
                  value: state.appointmentDate,
                  onChanged: (date) =>
                      notifier.updateField(appointmentDate: date),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _buildDropdown(
                  label: 'Appointment Slot *',
                  value: state.appointmentSlot,
                  items: [
                    '09:00 AM - 10:00 AM',
                    '10:00 AM - 11:00 AM',
                    '11:00 AM - 12:00 PM',
                    '02:00 PM - 03:00 PM',
                    '04:00 PM - 05:00 PM',
                  ],
                  onChanged: (v) => notifier.updateField(appointmentSlot: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        if (isIPD || isEmergency) ...[
          _buildDropdown(
            label: 'Bed Selection *',
            value: state.bedNumber,
            items: [
              'General Ward - B101',
              'General Ward - B102',
              'Semi-Private - R204',
              'Private - R305',
              'ICU - I01',
            ],
            onChanged: (v) => notifier.updateField(bedNumber: v),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Admission Reason *',
            hintText: 'Detailed reason for admission',
            initialValue: state.admissionReason,
            onChanged: (v) => notifier.updateField(admissionReason: v),
            maxLines: 2,
          ),
          const SizedBox(height: AppSpacing.md),
        ],

        AppTextField(
          label: 'Primary Complaint *',
          hintText: 'Reason for visit',
          initialValue: state.primaryComplaint,
          onChanged: (v) => notifier.updateField(primaryComplaint: v),
          textInputAction: TextInputAction.next,
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Payment Mode *',
                value: state.paymentMode,
                items: [
                  'Cash',
                  'State Health Scheme/ AB-PMJAY',
                  'Private Insurance',
                  'Online Payment',
                ],
                onChanged: (v) => notifier.updateField(paymentMode: v),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                label: 'Registration Fee (₹) *',
                hintText: '0.00',
                initialValue: state.registrationFee,
                keyboardType: TextInputType.number,
                onChanged: (v) => notifier.updateField(registrationFee: v),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Referred By',
          hintText: 'Doctor name or Hospital name',
          initialValue: state.referredBy,
          onChanged: (v) => notifier.updateField(referredBy: v),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => notifier.nextStep(),
        ),
      ],
    );
  }

  Widget _buildDatePicker({
    required BuildContext context,
    required String label,
    required DateTime? value,
    required ValueChanged<DateTime> onChanged,
  }) {
    final controller = TextEditingController(
      text: value != null ? DateFormat('dd-MM-yyyy').format(value) : '',
    );

    return AppTextField(
      label: label,
      hintText: 'DD-MM-YYYY',
      controller: controller,
      readOnly: true,
      suffixIcon: IconButton(
        icon: const Icon(
          Icons.calendar_today,
          color: AppColors.primary,
          size: 20,
        ),
        onPressed: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)),
          );
          if (date != null) {
            onChanged(date);
          }
        },
      ),
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
