// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginState {
  UserRole? get selectedRole => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  bool get rememberMe => throw _privateConstructorUsedError;
  bool get isObscured => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
    LoginState value,
    $Res Function(LoginState) then,
  ) = _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call({
    UserRole? selectedRole,
    String employeeId,
    String password,
    bool rememberMe,
    bool isObscured,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedRole = freezed,
    Object? employeeId = null,
    Object? password = null,
    Object? rememberMe = null,
    Object? isObscured = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedRole: freezed == selectedRole
                ? _value.selectedRole
                : selectedRole // ignore: cast_nullable_to_non_nullable
                      as UserRole?,
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            password: null == password
                ? _value.password
                : password // ignore: cast_nullable_to_non_nullable
                      as String,
            rememberMe: null == rememberMe
                ? _value.rememberMe
                : rememberMe // ignore: cast_nullable_to_non_nullable
                      as bool,
            isObscured: null == isObscured
                ? _value.isObscured
                : isObscured // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
    _$LoginStateImpl value,
    $Res Function(_$LoginStateImpl) then,
  ) = __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    UserRole? selectedRole,
    String employeeId,
    String password,
    bool rememberMe,
    bool isObscured,
    bool isLoading,
    String? errorMessage,
  });
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
    _$LoginStateImpl _value,
    $Res Function(_$LoginStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedRole = freezed,
    Object? employeeId = null,
    Object? password = null,
    Object? rememberMe = null,
    Object? isObscured = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$LoginStateImpl(
        selectedRole: freezed == selectedRole
            ? _value.selectedRole
            : selectedRole // ignore: cast_nullable_to_non_nullable
                  as UserRole?,
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        password: null == password
            ? _value.password
            : password // ignore: cast_nullable_to_non_nullable
                  as String,
        rememberMe: null == rememberMe
            ? _value.rememberMe
            : rememberMe // ignore: cast_nullable_to_non_nullable
                  as bool,
        isObscured: null == isObscured
            ? _value.isObscured
            : isObscured // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl({
    this.selectedRole,
    this.employeeId = '',
    this.password = '',
    this.rememberMe = false,
    this.isObscured = false,
    this.isLoading = false,
    this.errorMessage,
  });

  @override
  final UserRole? selectedRole;
  @override
  @JsonKey()
  final String employeeId;
  @override
  @JsonKey()
  final String password;
  @override
  @JsonKey()
  final bool rememberMe;
  @override
  @JsonKey()
  final bool isObscured;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'LoginState(selectedRole: $selectedRole, employeeId: $employeeId, password: $password, rememberMe: $rememberMe, isObscured: $isObscured, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.selectedRole, selectedRole) ||
                other.selectedRole == selectedRole) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.rememberMe, rememberMe) ||
                other.rememberMe == rememberMe) &&
            (identical(other.isObscured, isObscured) ||
                other.isObscured == isObscured) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedRole,
    employeeId,
    password,
    rememberMe,
    isObscured,
    isLoading,
    errorMessage,
  );

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState({
    final UserRole? selectedRole,
    final String employeeId,
    final String password,
    final bool rememberMe,
    final bool isObscured,
    final bool isLoading,
    final String? errorMessage,
  }) = _$LoginStateImpl;

  @override
  UserRole? get selectedRole;
  @override
  String get employeeId;
  @override
  String get password;
  @override
  bool get rememberMe;
  @override
  bool get isObscured;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
