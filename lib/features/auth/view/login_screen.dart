import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/core/widgets/app_button.dart';
import 'package:paracareplus/core/widgets/app_textfield.dart';
import 'package:paracareplus/features/auth/view/widgets/demo_credentials_bar.dart';
import 'package:paracareplus/features/auth/view/widgets/login_info_section.dart';
import 'package:paracareplus/features/auth/view/widgets/role_selection_grid.dart';
import 'package:paracareplus/features/auth/view_model/login_view_model.dart';
import 'package:paracareplus/routes/route_names.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider).value;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 900) {
              return _buildTabletLayout(context, ref, loginState);
            }
            return _buildMobileLayout(context, ref, loginState);
          },
        ),
      ),
    );
  }

  Widget _buildTabletLayout(
    BuildContext context,
    WidgetRef ref,
    LoginState? state,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: const LoginInfoSection(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              width: 500,
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: _buildLoginForm(context, ref, state),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    WidgetRef ref,
    LoginState? state,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xl),
          const LoginInfoSection(),
          const SizedBox(height: AppSpacing.xl),
          _buildLoginForm(context, ref, state),
        ],
      ),
    );
  }

  Widget _buildLoginForm(
    BuildContext context,
    WidgetRef ref,
    LoginState? state,
  ) {
    if (state == null) return const Center(child: CircularProgressIndicator());

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_person_rounded,
                color: AppColors.secondaryAccent,
                size: 28,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ParaCare+ HIMS - Secure Login',
                    style: AppTextStyles.titleSmall,
                  ),
                  Text(
                    'Hospital Information Management System',
                    style: AppTextStyles.labelSmall.copyWith(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text('SELECT YOUR ROLE', style: AppTextStyles.labelSmall),
          const SizedBox(height: AppSpacing.md),
          const RoleSelectionGrid(),
          const SizedBox(height: AppSpacing.lg),
          AppTextField(
            label: 'Employee ID / Email',
            hintText: 'bakul@demo.com',
            prefixIcon: Icons.person_outline_rounded,
            onChanged: (v) =>
                ref.read(loginViewModelProvider.notifier).updateEmployeeId(v),
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Password',
            hintText: '••••••',
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: state.isObscured,
            suffixIcon: IconButton(
              onPressed: () =>
                  ref.read(loginViewModelProvider.notifier).toggleObscure(),
              icon: Icon(
                state.isObscured
                    ? Icons.visibility_off_rounded
                    : Icons.visibility_rounded,
              ),
              iconSize: 20,
            ),
            onChanged: (v) =>
                ref.read(loginViewModelProvider.notifier).updatePassword(v),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                      value: state.rememberMe,
                      onChanged: (v) => ref
                          .read(loginViewModelProvider.notifier)
                          .toggleRememberMe(v),
                      activeColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.border),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Remember me', style: AppTextStyles.labelSmall),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: AppTextStyles.labelSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (state.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                state.errorMessage!,
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                textAlign: TextAlign.center,
              ),
            ),
          AppButton(
            text: 'Secure Login to HIMS',
            isLoading: state.isLoading,
            onPressed: () async {
              final success = await ref
                  .read(loginViewModelProvider.notifier)
                  .login();
              if (success && context.mounted) {
                context.goNamed(RouteNames.dashboard);
              }
            },
            icon: Icons.vpn_key_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          const DemoCredentialsBar(),
        ],
      ),
    );
  }
}
