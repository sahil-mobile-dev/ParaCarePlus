import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paracareplus/features/auth/model/user_role.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_view_model.freezed.dart';
part 'login_view_model.g.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    UserRole? selectedRole,
    @Default('') String employeeId,
    @Default('') String password,
    @Default(false) bool rememberMe,
    @Default(false) bool isObscured,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _LoginState;
}

@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  FutureOr<LoginState> build() async {
    return const LoginState(isObscured: true);
  }

  void selectRole(UserRole role) {
    state = AsyncValue.data(state.value!.copyWith(selectedRole: role));
  }

  void updateEmployeeId(String value) {
    state = AsyncValue.data(state.value!.copyWith(employeeId: value, errorMessage: null));
  }

  void updatePassword(String value) {
    state = AsyncValue.data(state.value!.copyWith(password: value, errorMessage: null));
  }

  void toggleRememberMe(bool? value) {
    state = AsyncValue.data(state.value!.copyWith(rememberMe: value ?? false));
  }

  void toggleObscure() {
    state = AsyncValue.data(state.value!.copyWith(isObscured: !state.value!.isObscured));
  }

  Future<bool> login() async {
    final currentState = state.value!;
    
    if (currentState.selectedRole == null) {
      state = AsyncValue.data(currentState.copyWith(errorMessage: 'Please select your role'));
      return false;
    }

    if (currentState.employeeId.isEmpty || currentState.password.isEmpty) {
      state = AsyncValue.data(currentState.copyWith(errorMessage: 'Please fill all fields'));
      return false;
    }

    state = AsyncValue.data(currentState.copyWith(isLoading: true, errorMessage: null));

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 2));

    state = AsyncValue.data(state.value!.copyWith(isLoading: false));
    return true;
  }

  void fillDemoCredentials(UserRole role) {
    state = AsyncValue.data(state.value!.copyWith(
      selectedRole: role,
      employeeId: '${role.name.toLowerCase()}@demo.com',
      password: 'password123',
      errorMessage: null,
    ));
  }
}
