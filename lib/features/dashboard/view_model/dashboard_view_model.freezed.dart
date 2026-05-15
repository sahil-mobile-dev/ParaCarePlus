// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DashboardState {
  DashboardStats get stats => throw _privateConstructorUsedError;
  List<ActivityFeedItem> get activityFeed => throw _privateConstructorUsedError;
  List<BedStatus> get bedStatus => throw _privateConstructorUsedError;
  List<CriticalPatient> get criticalPatients =>
      throw _privateConstructorUsedError;
  List<ModuleStatus> get moduleStatus => throw _privateConstructorUsedError;
  List<StaffOnDuty> get staffOnDuty => throw _privateConstructorUsedError;
  List<AlertItem> get alerts => throw _privateConstructorUsedError;
  bool get isRefreshing => throw _privateConstructorUsedError;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardStateCopyWith<DashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardStateCopyWith<$Res> {
  factory $DashboardStateCopyWith(
    DashboardState value,
    $Res Function(DashboardState) then,
  ) = _$DashboardStateCopyWithImpl<$Res, DashboardState>;
  @useResult
  $Res call({
    DashboardStats stats,
    List<ActivityFeedItem> activityFeed,
    List<BedStatus> bedStatus,
    List<CriticalPatient> criticalPatients,
    List<ModuleStatus> moduleStatus,
    List<StaffOnDuty> staffOnDuty,
    List<AlertItem> alerts,
    bool isRefreshing,
  });

  $DashboardStatsCopyWith<$Res> get stats;
}

/// @nodoc
class _$DashboardStateCopyWithImpl<$Res, $Val extends DashboardState>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
    Object? activityFeed = null,
    Object? bedStatus = null,
    Object? criticalPatients = null,
    Object? moduleStatus = null,
    Object? staffOnDuty = null,
    Object? alerts = null,
    Object? isRefreshing = null,
  }) {
    return _then(
      _value.copyWith(
            stats: null == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as DashboardStats,
            activityFeed: null == activityFeed
                ? _value.activityFeed
                : activityFeed // ignore: cast_nullable_to_non_nullable
                      as List<ActivityFeedItem>,
            bedStatus: null == bedStatus
                ? _value.bedStatus
                : bedStatus // ignore: cast_nullable_to_non_nullable
                      as List<BedStatus>,
            criticalPatients: null == criticalPatients
                ? _value.criticalPatients
                : criticalPatients // ignore: cast_nullable_to_non_nullable
                      as List<CriticalPatient>,
            moduleStatus: null == moduleStatus
                ? _value.moduleStatus
                : moduleStatus // ignore: cast_nullable_to_non_nullable
                      as List<ModuleStatus>,
            staffOnDuty: null == staffOnDuty
                ? _value.staffOnDuty
                : staffOnDuty // ignore: cast_nullable_to_non_nullable
                      as List<StaffOnDuty>,
            alerts: null == alerts
                ? _value.alerts
                : alerts // ignore: cast_nullable_to_non_nullable
                      as List<AlertItem>,
            isRefreshing: null == isRefreshing
                ? _value.isRefreshing
                : isRefreshing // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DashboardStatsCopyWith<$Res> get stats {
    return $DashboardStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DashboardStateImplCopyWith<$Res>
    implements $DashboardStateCopyWith<$Res> {
  factory _$$DashboardStateImplCopyWith(
    _$DashboardStateImpl value,
    $Res Function(_$DashboardStateImpl) then,
  ) = __$$DashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DashboardStats stats,
    List<ActivityFeedItem> activityFeed,
    List<BedStatus> bedStatus,
    List<CriticalPatient> criticalPatients,
    List<ModuleStatus> moduleStatus,
    List<StaffOnDuty> staffOnDuty,
    List<AlertItem> alerts,
    bool isRefreshing,
  });

  @override
  $DashboardStatsCopyWith<$Res> get stats;
}

/// @nodoc
class __$$DashboardStateImplCopyWithImpl<$Res>
    extends _$DashboardStateCopyWithImpl<$Res, _$DashboardStateImpl>
    implements _$$DashboardStateImplCopyWith<$Res> {
  __$$DashboardStateImplCopyWithImpl(
    _$DashboardStateImpl _value,
    $Res Function(_$DashboardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stats = null,
    Object? activityFeed = null,
    Object? bedStatus = null,
    Object? criticalPatients = null,
    Object? moduleStatus = null,
    Object? staffOnDuty = null,
    Object? alerts = null,
    Object? isRefreshing = null,
  }) {
    return _then(
      _$DashboardStateImpl(
        stats: null == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as DashboardStats,
        activityFeed: null == activityFeed
            ? _value._activityFeed
            : activityFeed // ignore: cast_nullable_to_non_nullable
                  as List<ActivityFeedItem>,
        bedStatus: null == bedStatus
            ? _value._bedStatus
            : bedStatus // ignore: cast_nullable_to_non_nullable
                  as List<BedStatus>,
        criticalPatients: null == criticalPatients
            ? _value._criticalPatients
            : criticalPatients // ignore: cast_nullable_to_non_nullable
                  as List<CriticalPatient>,
        moduleStatus: null == moduleStatus
            ? _value._moduleStatus
            : moduleStatus // ignore: cast_nullable_to_non_nullable
                  as List<ModuleStatus>,
        staffOnDuty: null == staffOnDuty
            ? _value._staffOnDuty
            : staffOnDuty // ignore: cast_nullable_to_non_nullable
                  as List<StaffOnDuty>,
        alerts: null == alerts
            ? _value._alerts
            : alerts // ignore: cast_nullable_to_non_nullable
                  as List<AlertItem>,
        isRefreshing: null == isRefreshing
            ? _value.isRefreshing
            : isRefreshing // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$DashboardStateImpl implements _DashboardState {
  const _$DashboardStateImpl({
    this.stats = const DashboardStats(),
    final List<ActivityFeedItem> activityFeed = const [],
    final List<BedStatus> bedStatus = const [],
    final List<CriticalPatient> criticalPatients = const [],
    final List<ModuleStatus> moduleStatus = const [],
    final List<StaffOnDuty> staffOnDuty = const [],
    final List<AlertItem> alerts = const [],
    this.isRefreshing = false,
  }) : _activityFeed = activityFeed,
       _bedStatus = bedStatus,
       _criticalPatients = criticalPatients,
       _moduleStatus = moduleStatus,
       _staffOnDuty = staffOnDuty,
       _alerts = alerts;

  @override
  @JsonKey()
  final DashboardStats stats;
  final List<ActivityFeedItem> _activityFeed;
  @override
  @JsonKey()
  List<ActivityFeedItem> get activityFeed {
    if (_activityFeed is EqualUnmodifiableListView) return _activityFeed;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activityFeed);
  }

  final List<BedStatus> _bedStatus;
  @override
  @JsonKey()
  List<BedStatus> get bedStatus {
    if (_bedStatus is EqualUnmodifiableListView) return _bedStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bedStatus);
  }

  final List<CriticalPatient> _criticalPatients;
  @override
  @JsonKey()
  List<CriticalPatient> get criticalPatients {
    if (_criticalPatients is EqualUnmodifiableListView)
      return _criticalPatients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_criticalPatients);
  }

  final List<ModuleStatus> _moduleStatus;
  @override
  @JsonKey()
  List<ModuleStatus> get moduleStatus {
    if (_moduleStatus is EqualUnmodifiableListView) return _moduleStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_moduleStatus);
  }

  final List<StaffOnDuty> _staffOnDuty;
  @override
  @JsonKey()
  List<StaffOnDuty> get staffOnDuty {
    if (_staffOnDuty is EqualUnmodifiableListView) return _staffOnDuty;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_staffOnDuty);
  }

  final List<AlertItem> _alerts;
  @override
  @JsonKey()
  List<AlertItem> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  @JsonKey()
  final bool isRefreshing;

  @override
  String toString() {
    return 'DashboardState(stats: $stats, activityFeed: $activityFeed, bedStatus: $bedStatus, criticalPatients: $criticalPatients, moduleStatus: $moduleStatus, staffOnDuty: $staffOnDuty, alerts: $alerts, isRefreshing: $isRefreshing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardStateImpl &&
            (identical(other.stats, stats) || other.stats == stats) &&
            const DeepCollectionEquality().equals(
              other._activityFeed,
              _activityFeed,
            ) &&
            const DeepCollectionEquality().equals(
              other._bedStatus,
              _bedStatus,
            ) &&
            const DeepCollectionEquality().equals(
              other._criticalPatients,
              _criticalPatients,
            ) &&
            const DeepCollectionEquality().equals(
              other._moduleStatus,
              _moduleStatus,
            ) &&
            const DeepCollectionEquality().equals(
              other._staffOnDuty,
              _staffOnDuty,
            ) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts) &&
            (identical(other.isRefreshing, isRefreshing) ||
                other.isRefreshing == isRefreshing));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    stats,
    const DeepCollectionEquality().hash(_activityFeed),
    const DeepCollectionEquality().hash(_bedStatus),
    const DeepCollectionEquality().hash(_criticalPatients),
    const DeepCollectionEquality().hash(_moduleStatus),
    const DeepCollectionEquality().hash(_staffOnDuty),
    const DeepCollectionEquality().hash(_alerts),
    isRefreshing,
  );

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      __$$DashboardStateImplCopyWithImpl<_$DashboardStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DashboardState implements DashboardState {
  const factory _DashboardState({
    final DashboardStats stats,
    final List<ActivityFeedItem> activityFeed,
    final List<BedStatus> bedStatus,
    final List<CriticalPatient> criticalPatients,
    final List<ModuleStatus> moduleStatus,
    final List<StaffOnDuty> staffOnDuty,
    final List<AlertItem> alerts,
    final bool isRefreshing,
  }) = _$DashboardStateImpl;

  @override
  DashboardStats get stats;
  @override
  List<ActivityFeedItem> get activityFeed;
  @override
  List<BedStatus> get bedStatus;
  @override
  List<CriticalPatient> get criticalPatients;
  @override
  List<ModuleStatus> get moduleStatus;
  @override
  List<StaffOnDuty> get staffOnDuty;
  @override
  List<AlertItem> get alerts;
  @override
  bool get isRefreshing;

  /// Create a copy of DashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardStateImplCopyWith<_$DashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
