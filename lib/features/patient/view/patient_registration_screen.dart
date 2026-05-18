import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';
import 'package:paracareplus/features/patient/model/patient_registration.dart';
import 'package:paracareplus/features/patient/view/widgets/step_personal_info.dart';
import 'package:paracareplus/features/patient/view/widgets/step_contact_address.dart';
import 'package:paracareplus/features/patient/view/widgets/step_medical_history.dart';
import 'package:paracareplus/features/patient/view/widgets/step_visit_type.dart';
import 'package:paracareplus/features/patient/view/widgets/step_confirm_print.dart';
import 'package:paracareplus/features/patient/view_model/registration_view_model.dart';

class PatientRegistrationScreen extends ConsumerWidget {
  const PatientRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registrationState = ref.watch(registrationViewModelProvider);

    return registrationState.when(
      data: (data) => _buildContent(context, ref, data),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    PatientRegistration data,
  ) {
    final currentStep = data.currentStep;

    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.keyN):
            const NextStepIntent(),
        LogicalKeySet(LogicalKeyboardKey.alt, LogicalKeyboardKey.keyB):
            const PreviousStepIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          NextStepIntent: CallbackAction<NextStepIntent>(
            onInvoke: (intent) =>
                ref.read(registrationViewModelProvider.notifier).nextStep(),
          ),
          PreviousStepIntent: CallbackAction<PreviousStepIntent>(
            onInvoke: (intent) =>
                ref.read(registrationViewModelProvider.notifier).previousStep(),
          ),
        },
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            title: Text(
              'New Patient Registration',
              style: AppTextStyles.titleLarge,
            ),
            leading: IconButton(
              icon: const Icon(Icons.close, color: AppColors.primaryText),
              onPressed: () => context.pop(),
            ),
          ),
          body: Column(
            children: [
              _buildStepIndicator(currentStep),
              Expanded(
                child: FocusTraversalGroup(
                  policy: WidgetOrderTraversalPolicy(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: _getStepWidget(currentStep),
                  ),
                ),
              ),
              _buildFooter(context, ref, data),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int currentStep) {
    final steps = ['Personal', 'Contact', 'Medical', 'Visit', 'Confirm'];
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(steps.length, (index) {
          final isActive = index == currentStep;
          final isCompleted = index < currentStep;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: isActive
                    ? AppColors.primary
                    : isCompleted
                    ? AppColors.success
                    : AppColors.border,
                child: isCompleted
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: isActive || isCompleted
                              ? Colors.white
                              : AppColors.secondaryText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[index],
                style: AppTextStyles.labelMedium.copyWith(
                  color: isActive ? AppColors.primary : AppColors.secondaryText,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _getStepWidget(int step) {
    switch (step) {
      case 0:
        return const StepPersonalInfo();
      case 1:
        return const StepContactAddress();
      case 2:
        return const StepMedicalHistory();
      case 3:
        return const StepVisitType();
      case 4:
        return const StepConfirmPrint();
      default:
        return const StepPersonalInfo();
    }
  }

  Widget _buildFooter(
    BuildContext context,
    WidgetRef ref,
    PatientRegistration data,
  ) {
    final currentStep = data.currentStep;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (currentStep > 0)
            AppButton(
              text: 'Back',
              isOutlined: true,
              onPressed: () => ref
                  .read(registrationViewModelProvider.notifier)
                  .previousStep(),
            )
          else
            const SizedBox.shrink(),
          Row(
            children: [
              Text(
                'Step ${currentStep + 1} of 5',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              AppButton(
                text: currentStep == 4 ? 'Register & Print' : 'Next',
                isLoading: data.isSubmitting,
                onPressed: () {
                  if (currentStep == 4) {
                    ref
                        .read(registrationViewModelProvider.notifier)
                        .registerPatient();
                  } else {
                    ref.read(registrationViewModelProvider.notifier).nextStep();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NextStepIntent extends Intent {
  const NextStepIntent();
}

class PreviousStepIntent extends Intent {
  const PreviousStepIntent();
}
