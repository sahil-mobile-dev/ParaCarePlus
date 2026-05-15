import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/patient/view_model/registration_view_model.dart';

class StepContactAddress extends ConsumerWidget {
  const StepContactAddress({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registrationViewModelProvider).value;
    if (state == null) return const SizedBox.shrink();

    final notifier = ref.read(registrationViewModelProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact & Address', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.lg),
        
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Mobile Number *',
                hintText: '10-digit mobile number',
                initialValue: state.mobileNumber,
                onChanged: (v) => notifier.updateField(mobileNumber: v),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                label: 'Email',
                hintText: 'patient@example.com',
                initialValue: state.email,
                onChanged: (v) => notifier.updateField(email: v),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Current Address *',
          hintText: 'House No, Street, Landmark',
          initialValue: state.address,
          onChanged: (v) => notifier.updateField(address: v),
          textInputAction: TextInputAction.next,
          maxLines: 2,
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'City',
                hintText: 'City name',
                initialValue: state.city,
                onChanged: (v) => notifier.updateField(city: v),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                label: 'State',
                hintText: 'State name',
                initialValue: state.state,
                onChanged: (v) => notifier.updateField(addressState: v),
                textInputAction: TextInputAction.next,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        AppTextField(
          label: 'Pincode',
          hintText: '6-digit pincode',
          initialValue: state.pincode,
          onChanged: (v) => notifier.updateField(pincode: v),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: AppSpacing.xl),

        Text('Emergency Contact', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Guardian/Emergency Name',
                hintText: 'Relation or Name',
                initialValue: state.emergencyContactName,
                onChanged: (v) => notifier.updateField(emergencyContactName: v),
                textInputAction: TextInputAction.next,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppTextField(
                label: 'Emergency Mobile',
                hintText: '10-digit mobile',
                initialValue: state.emergencyContactNumber,
                onChanged: (v) => notifier.updateField(emergencyContactNumber: v),
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => notifier.nextStep(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
