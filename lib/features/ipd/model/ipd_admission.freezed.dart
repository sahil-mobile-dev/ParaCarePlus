// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ipd_admission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

IpdAdmission _$IpdAdmissionFromJson(Map<String, dynamic> json) {
  return _IpdAdmission.fromJson(json);
}

/// @nodoc
mixin _$IpdAdmission {
  String get searchQuery => throw _privateConstructorUsedError;
  String get patientName => throw _privateConstructorUsedError;
  String get mrn => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get admissionReason => throw _privateConstructorUsedError;
  String get ward => throw _privateConstructorUsedError;
  String get selectedBed => throw _privateConstructorUsedError;
  String get doctorName => throw _privateConstructorUsedError;
  String get expectedDuration => throw _privateConstructorUsedError;
  String get paymentMode => throw _privateConstructorUsedError;
  String get advanceDeposit => throw _privateConstructorUsedError;
  String get specialInstructions => throw _privateConstructorUsedError;
  bool get isSearching => throw _privateConstructorUsedError;
  List<PatientSummary> get searchResults => throw _privateConstructorUsedError;
  PatientSummary? get selectedPatient => throw _privateConstructorUsedError;
  List<BedInfo> get availableBeds => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;

  /// Serializes this IpdAdmission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IpdAdmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IpdAdmissionCopyWith<IpdAdmission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IpdAdmissionCopyWith<$Res> {
  factory $IpdAdmissionCopyWith(
    IpdAdmission value,
    $Res Function(IpdAdmission) then,
  ) = _$IpdAdmissionCopyWithImpl<$Res, IpdAdmission>;
  @useResult
  $Res call({
    String searchQuery,
    String patientName,
    String mrn,
    String department,
    String admissionReason,
    String ward,
    String selectedBed,
    String doctorName,
    String expectedDuration,
    String paymentMode,
    String advanceDeposit,
    String specialInstructions,
    bool isSearching,
    List<PatientSummary> searchResults,
    PatientSummary? selectedPatient,
    List<BedInfo> availableBeds,
    bool isSubmitting,
  });

  $PatientSummaryCopyWith<$Res>? get selectedPatient;
}

/// @nodoc
class _$IpdAdmissionCopyWithImpl<$Res, $Val extends IpdAdmission>
    implements $IpdAdmissionCopyWith<$Res> {
  _$IpdAdmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IpdAdmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? patientName = null,
    Object? mrn = null,
    Object? department = null,
    Object? admissionReason = null,
    Object? ward = null,
    Object? selectedBed = null,
    Object? doctorName = null,
    Object? expectedDuration = null,
    Object? paymentMode = null,
    Object? advanceDeposit = null,
    Object? specialInstructions = null,
    Object? isSearching = null,
    Object? searchResults = null,
    Object? selectedPatient = freezed,
    Object? availableBeds = null,
    Object? isSubmitting = null,
  }) {
    return _then(
      _value.copyWith(
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            patientName: null == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                      as String,
            mrn: null == mrn
                ? _value.mrn
                : mrn // ignore: cast_nullable_to_non_nullable
                      as String,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            admissionReason: null == admissionReason
                ? _value.admissionReason
                : admissionReason // ignore: cast_nullable_to_non_nullable
                      as String,
            ward: null == ward
                ? _value.ward
                : ward // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedBed: null == selectedBed
                ? _value.selectedBed
                : selectedBed // ignore: cast_nullable_to_non_nullable
                      as String,
            doctorName: null == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                      as String,
            expectedDuration: null == expectedDuration
                ? _value.expectedDuration
                : expectedDuration // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMode: null == paymentMode
                ? _value.paymentMode
                : paymentMode // ignore: cast_nullable_to_non_nullable
                      as String,
            advanceDeposit: null == advanceDeposit
                ? _value.advanceDeposit
                : advanceDeposit // ignore: cast_nullable_to_non_nullable
                      as String,
            specialInstructions: null == specialInstructions
                ? _value.specialInstructions
                : specialInstructions // ignore: cast_nullable_to_non_nullable
                      as String,
            isSearching: null == isSearching
                ? _value.isSearching
                : isSearching // ignore: cast_nullable_to_non_nullable
                      as bool,
            searchResults: null == searchResults
                ? _value.searchResults
                : searchResults // ignore: cast_nullable_to_non_nullable
                      as List<PatientSummary>,
            selectedPatient: freezed == selectedPatient
                ? _value.selectedPatient
                : selectedPatient // ignore: cast_nullable_to_non_nullable
                      as PatientSummary?,
            availableBeds: null == availableBeds
                ? _value.availableBeds
                : availableBeds // ignore: cast_nullable_to_non_nullable
                      as List<BedInfo>,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of IpdAdmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PatientSummaryCopyWith<$Res>? get selectedPatient {
    if (_value.selectedPatient == null) {
      return null;
    }

    return $PatientSummaryCopyWith<$Res>(_value.selectedPatient!, (value) {
      return _then(_value.copyWith(selectedPatient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IpdAdmissionImplCopyWith<$Res>
    implements $IpdAdmissionCopyWith<$Res> {
  factory _$$IpdAdmissionImplCopyWith(
    _$IpdAdmissionImpl value,
    $Res Function(_$IpdAdmissionImpl) then,
  ) = __$$IpdAdmissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String searchQuery,
    String patientName,
    String mrn,
    String department,
    String admissionReason,
    String ward,
    String selectedBed,
    String doctorName,
    String expectedDuration,
    String paymentMode,
    String advanceDeposit,
    String specialInstructions,
    bool isSearching,
    List<PatientSummary> searchResults,
    PatientSummary? selectedPatient,
    List<BedInfo> availableBeds,
    bool isSubmitting,
  });

  @override
  $PatientSummaryCopyWith<$Res>? get selectedPatient;
}

/// @nodoc
class __$$IpdAdmissionImplCopyWithImpl<$Res>
    extends _$IpdAdmissionCopyWithImpl<$Res, _$IpdAdmissionImpl>
    implements _$$IpdAdmissionImplCopyWith<$Res> {
  __$$IpdAdmissionImplCopyWithImpl(
    _$IpdAdmissionImpl _value,
    $Res Function(_$IpdAdmissionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IpdAdmission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? patientName = null,
    Object? mrn = null,
    Object? department = null,
    Object? admissionReason = null,
    Object? ward = null,
    Object? selectedBed = null,
    Object? doctorName = null,
    Object? expectedDuration = null,
    Object? paymentMode = null,
    Object? advanceDeposit = null,
    Object? specialInstructions = null,
    Object? isSearching = null,
    Object? searchResults = null,
    Object? selectedPatient = freezed,
    Object? availableBeds = null,
    Object? isSubmitting = null,
  }) {
    return _then(
      _$IpdAdmissionImpl(
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        mrn: null == mrn
            ? _value.mrn
            : mrn // ignore: cast_nullable_to_non_nullable
                  as String,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        admissionReason: null == admissionReason
            ? _value.admissionReason
            : admissionReason // ignore: cast_nullable_to_non_nullable
                  as String,
        ward: null == ward
            ? _value.ward
            : ward // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedBed: null == selectedBed
            ? _value.selectedBed
            : selectedBed // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorName: null == doctorName
            ? _value.doctorName
            : doctorName // ignore: cast_nullable_to_non_nullable
                  as String,
        expectedDuration: null == expectedDuration
            ? _value.expectedDuration
            : expectedDuration // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMode: null == paymentMode
            ? _value.paymentMode
            : paymentMode // ignore: cast_nullable_to_non_nullable
                  as String,
        advanceDeposit: null == advanceDeposit
            ? _value.advanceDeposit
            : advanceDeposit // ignore: cast_nullable_to_non_nullable
                  as String,
        specialInstructions: null == specialInstructions
            ? _value.specialInstructions
            : specialInstructions // ignore: cast_nullable_to_non_nullable
                  as String,
        isSearching: null == isSearching
            ? _value.isSearching
            : isSearching // ignore: cast_nullable_to_non_nullable
                  as bool,
        searchResults: null == searchResults
            ? _value._searchResults
            : searchResults // ignore: cast_nullable_to_non_nullable
                  as List<PatientSummary>,
        selectedPatient: freezed == selectedPatient
            ? _value.selectedPatient
            : selectedPatient // ignore: cast_nullable_to_non_nullable
                  as PatientSummary?,
        availableBeds: null == availableBeds
            ? _value._availableBeds
            : availableBeds // ignore: cast_nullable_to_non_nullable
                  as List<BedInfo>,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IpdAdmissionImpl implements _IpdAdmission {
  const _$IpdAdmissionImpl({
    this.searchQuery = '',
    this.patientName = '',
    this.mrn = '',
    this.department = 'General Medicine',
    this.admissionReason = '',
    this.ward = 'General Ward',
    this.selectedBed = '',
    this.doctorName = '',
    this.expectedDuration = '1-3 days',
    this.paymentMode = 'Cash',
    this.advanceDeposit = '5000',
    this.specialInstructions = '',
    this.isSearching = false,
    final List<PatientSummary> searchResults = const [],
    this.selectedPatient,
    final List<BedInfo> availableBeds = const [],
    this.isSubmitting = false,
  }) : _searchResults = searchResults,
       _availableBeds = availableBeds;

  factory _$IpdAdmissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$IpdAdmissionImplFromJson(json);

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final String patientName;
  @override
  @JsonKey()
  final String mrn;
  @override
  @JsonKey()
  final String department;
  @override
  @JsonKey()
  final String admissionReason;
  @override
  @JsonKey()
  final String ward;
  @override
  @JsonKey()
  final String selectedBed;
  @override
  @JsonKey()
  final String doctorName;
  @override
  @JsonKey()
  final String expectedDuration;
  @override
  @JsonKey()
  final String paymentMode;
  @override
  @JsonKey()
  final String advanceDeposit;
  @override
  @JsonKey()
  final String specialInstructions;
  @override
  @JsonKey()
  final bool isSearching;
  final List<PatientSummary> _searchResults;
  @override
  @JsonKey()
  List<PatientSummary> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  @override
  final PatientSummary? selectedPatient;
  final List<BedInfo> _availableBeds;
  @override
  @JsonKey()
  List<BedInfo> get availableBeds {
    if (_availableBeds is EqualUnmodifiableListView) return _availableBeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableBeds);
  }

  @override
  @JsonKey()
  final bool isSubmitting;

  @override
  String toString() {
    return 'IpdAdmission(searchQuery: $searchQuery, patientName: $patientName, mrn: $mrn, department: $department, admissionReason: $admissionReason, ward: $ward, selectedBed: $selectedBed, doctorName: $doctorName, expectedDuration: $expectedDuration, paymentMode: $paymentMode, advanceDeposit: $advanceDeposit, specialInstructions: $specialInstructions, isSearching: $isSearching, searchResults: $searchResults, selectedPatient: $selectedPatient, availableBeds: $availableBeds, isSubmitting: $isSubmitting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IpdAdmissionImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.mrn, mrn) || other.mrn == mrn) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.admissionReason, admissionReason) ||
                other.admissionReason == admissionReason) &&
            (identical(other.ward, ward) || other.ward == ward) &&
            (identical(other.selectedBed, selectedBed) ||
                other.selectedBed == selectedBed) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.expectedDuration, expectedDuration) ||
                other.expectedDuration == expectedDuration) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.advanceDeposit, advanceDeposit) ||
                other.advanceDeposit == advanceDeposit) &&
            (identical(other.specialInstructions, specialInstructions) ||
                other.specialInstructions == specialInstructions) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            const DeepCollectionEquality().equals(
              other._searchResults,
              _searchResults,
            ) &&
            (identical(other.selectedPatient, selectedPatient) ||
                other.selectedPatient == selectedPatient) &&
            const DeepCollectionEquality().equals(
              other._availableBeds,
              _availableBeds,
            ) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    searchQuery,
    patientName,
    mrn,
    department,
    admissionReason,
    ward,
    selectedBed,
    doctorName,
    expectedDuration,
    paymentMode,
    advanceDeposit,
    specialInstructions,
    isSearching,
    const DeepCollectionEquality().hash(_searchResults),
    selectedPatient,
    const DeepCollectionEquality().hash(_availableBeds),
    isSubmitting,
  );

  /// Create a copy of IpdAdmission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IpdAdmissionImplCopyWith<_$IpdAdmissionImpl> get copyWith =>
      __$$IpdAdmissionImplCopyWithImpl<_$IpdAdmissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IpdAdmissionImplToJson(this);
  }
}

abstract class _IpdAdmission implements IpdAdmission {
  const factory _IpdAdmission({
    final String searchQuery,
    final String patientName,
    final String mrn,
    final String department,
    final String admissionReason,
    final String ward,
    final String selectedBed,
    final String doctorName,
    final String expectedDuration,
    final String paymentMode,
    final String advanceDeposit,
    final String specialInstructions,
    final bool isSearching,
    final List<PatientSummary> searchResults,
    final PatientSummary? selectedPatient,
    final List<BedInfo> availableBeds,
    final bool isSubmitting,
  }) = _$IpdAdmissionImpl;

  factory _IpdAdmission.fromJson(Map<String, dynamic> json) =
      _$IpdAdmissionImpl.fromJson;

  @override
  String get searchQuery;
  @override
  String get patientName;
  @override
  String get mrn;
  @override
  String get department;
  @override
  String get admissionReason;
  @override
  String get ward;
  @override
  String get selectedBed;
  @override
  String get doctorName;
  @override
  String get expectedDuration;
  @override
  String get paymentMode;
  @override
  String get advanceDeposit;
  @override
  String get specialInstructions;
  @override
  bool get isSearching;
  @override
  List<PatientSummary> get searchResults;
  @override
  PatientSummary? get selectedPatient;
  @override
  List<BedInfo> get availableBeds;
  @override
  bool get isSubmitting;

  /// Create a copy of IpdAdmission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IpdAdmissionImplCopyWith<_$IpdAdmissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BedInfo _$BedInfoFromJson(Map<String, dynamic> json) {
  return _BedInfo.fromJson(json);
}

/// @nodoc
mixin _$BedInfo {
  String get id => throw _privateConstructorUsedError;
  String get wardName => throw _privateConstructorUsedError;
  String get bedNumber => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;

  /// Serializes this BedInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BedInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BedInfoCopyWith<BedInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BedInfoCopyWith<$Res> {
  factory $BedInfoCopyWith(BedInfo value, $Res Function(BedInfo) then) =
      _$BedInfoCopyWithImpl<$Res, BedInfo>;
  @useResult
  $Res call({
    String id,
    String wardName,
    String bedNumber,
    String roomNumber,
    bool isAvailable,
  });
}

/// @nodoc
class _$BedInfoCopyWithImpl<$Res, $Val extends BedInfo>
    implements $BedInfoCopyWith<$Res> {
  _$BedInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BedInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wardName = null,
    Object? bedNumber = null,
    Object? roomNumber = null,
    Object? isAvailable = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            wardName: null == wardName
                ? _value.wardName
                : wardName // ignore: cast_nullable_to_non_nullable
                      as String,
            bedNumber: null == bedNumber
                ? _value.bedNumber
                : bedNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            roomNumber: null == roomNumber
                ? _value.roomNumber
                : roomNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            isAvailable: null == isAvailable
                ? _value.isAvailable
                : isAvailable // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BedInfoImplCopyWith<$Res> implements $BedInfoCopyWith<$Res> {
  factory _$$BedInfoImplCopyWith(
    _$BedInfoImpl value,
    $Res Function(_$BedInfoImpl) then,
  ) = __$$BedInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String wardName,
    String bedNumber,
    String roomNumber,
    bool isAvailable,
  });
}

/// @nodoc
class __$$BedInfoImplCopyWithImpl<$Res>
    extends _$BedInfoCopyWithImpl<$Res, _$BedInfoImpl>
    implements _$$BedInfoImplCopyWith<$Res> {
  __$$BedInfoImplCopyWithImpl(
    _$BedInfoImpl _value,
    $Res Function(_$BedInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BedInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? wardName = null,
    Object? bedNumber = null,
    Object? roomNumber = null,
    Object? isAvailable = null,
  }) {
    return _then(
      _$BedInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        wardName: null == wardName
            ? _value.wardName
            : wardName // ignore: cast_nullable_to_non_nullable
                  as String,
        bedNumber: null == bedNumber
            ? _value.bedNumber
            : bedNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        roomNumber: null == roomNumber
            ? _value.roomNumber
            : roomNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        isAvailable: null == isAvailable
            ? _value.isAvailable
            : isAvailable // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BedInfoImpl implements _BedInfo {
  const _$BedInfoImpl({
    required this.id,
    required this.wardName,
    required this.bedNumber,
    required this.roomNumber,
    this.isAvailable = true,
  });

  factory _$BedInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BedInfoImplFromJson(json);

  @override
  final String id;
  @override
  final String wardName;
  @override
  final String bedNumber;
  @override
  final String roomNumber;
  @override
  @JsonKey()
  final bool isAvailable;

  @override
  String toString() {
    return 'BedInfo(id: $id, wardName: $wardName, bedNumber: $bedNumber, roomNumber: $roomNumber, isAvailable: $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BedInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.wardName, wardName) ||
                other.wardName == wardName) &&
            (identical(other.bedNumber, bedNumber) ||
                other.bedNumber == bedNumber) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    wardName,
    bedNumber,
    roomNumber,
    isAvailable,
  );

  /// Create a copy of BedInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BedInfoImplCopyWith<_$BedInfoImpl> get copyWith =>
      __$$BedInfoImplCopyWithImpl<_$BedInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BedInfoImplToJson(this);
  }
}

abstract class _BedInfo implements BedInfo {
  const factory _BedInfo({
    required final String id,
    required final String wardName,
    required final String bedNumber,
    required final String roomNumber,
    final bool isAvailable,
  }) = _$BedInfoImpl;

  factory _BedInfo.fromJson(Map<String, dynamic> json) = _$BedInfoImpl.fromJson;

  @override
  String get id;
  @override
  String get wardName;
  @override
  String get bedNumber;
  @override
  String get roomNumber;
  @override
  bool get isAvailable;

  /// Create a copy of BedInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BedInfoImplCopyWith<_$BedInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
