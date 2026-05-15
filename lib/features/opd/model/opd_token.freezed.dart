// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opd_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OpdToken _$OpdTokenFromJson(Map<String, dynamic> json) {
  return _OpdToken.fromJson(json);
}

/// @nodoc
mixin _$OpdToken {
  String get searchQuery => throw _privateConstructorUsedError;
  String get patientName => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  String get sex => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  String get doctorName => throw _privateConstructorUsedError;
  DateTime? get appointmentDate => throw _privateConstructorUsedError;
  String get appointmentSlot => throw _privateConstructorUsedError;
  String get chiefComplaint => throw _privateConstructorUsedError;
  String get visitType => throw _privateConstructorUsedError;
  String get paymentMode => throw _privateConstructorUsedError;
  String get appliedCharge => throw _privateConstructorUsedError;
  bool get isSearching => throw _privateConstructorUsedError;
  List<PatientSummary> get searchResults => throw _privateConstructorUsedError;
  PatientSummary? get selectedPatient => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;

  /// Serializes this OpdToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpdToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpdTokenCopyWith<OpdToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpdTokenCopyWith<$Res> {
  factory $OpdTokenCopyWith(OpdToken value, $Res Function(OpdToken) then) =
      _$OpdTokenCopyWithImpl<$Res, OpdToken>;
  @useResult
  $Res call({
    String searchQuery,
    String patientName,
    String age,
    String sex,
    String department,
    String doctorName,
    DateTime? appointmentDate,
    String appointmentSlot,
    String chiefComplaint,
    String visitType,
    String paymentMode,
    String appliedCharge,
    bool isSearching,
    List<PatientSummary> searchResults,
    PatientSummary? selectedPatient,
    bool isSubmitting,
  });

  $PatientSummaryCopyWith<$Res>? get selectedPatient;
}

/// @nodoc
class _$OpdTokenCopyWithImpl<$Res, $Val extends OpdToken>
    implements $OpdTokenCopyWith<$Res> {
  _$OpdTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpdToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? patientName = null,
    Object? age = null,
    Object? sex = null,
    Object? department = null,
    Object? doctorName = null,
    Object? appointmentDate = freezed,
    Object? appointmentSlot = null,
    Object? chiefComplaint = null,
    Object? visitType = null,
    Object? paymentMode = null,
    Object? appliedCharge = null,
    Object? isSearching = null,
    Object? searchResults = null,
    Object? selectedPatient = freezed,
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
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as String,
            sex: null == sex
                ? _value.sex
                : sex // ignore: cast_nullable_to_non_nullable
                      as String,
            department: null == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String,
            doctorName: null == doctorName
                ? _value.doctorName
                : doctorName // ignore: cast_nullable_to_non_nullable
                      as String,
            appointmentDate: freezed == appointmentDate
                ? _value.appointmentDate
                : appointmentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            appointmentSlot: null == appointmentSlot
                ? _value.appointmentSlot
                : appointmentSlot // ignore: cast_nullable_to_non_nullable
                      as String,
            chiefComplaint: null == chiefComplaint
                ? _value.chiefComplaint
                : chiefComplaint // ignore: cast_nullable_to_non_nullable
                      as String,
            visitType: null == visitType
                ? _value.visitType
                : visitType // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMode: null == paymentMode
                ? _value.paymentMode
                : paymentMode // ignore: cast_nullable_to_non_nullable
                      as String,
            appliedCharge: null == appliedCharge
                ? _value.appliedCharge
                : appliedCharge // ignore: cast_nullable_to_non_nullable
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
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of OpdToken
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
abstract class _$$OpdTokenImplCopyWith<$Res>
    implements $OpdTokenCopyWith<$Res> {
  factory _$$OpdTokenImplCopyWith(
    _$OpdTokenImpl value,
    $Res Function(_$OpdTokenImpl) then,
  ) = __$$OpdTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String searchQuery,
    String patientName,
    String age,
    String sex,
    String department,
    String doctorName,
    DateTime? appointmentDate,
    String appointmentSlot,
    String chiefComplaint,
    String visitType,
    String paymentMode,
    String appliedCharge,
    bool isSearching,
    List<PatientSummary> searchResults,
    PatientSummary? selectedPatient,
    bool isSubmitting,
  });

  @override
  $PatientSummaryCopyWith<$Res>? get selectedPatient;
}

/// @nodoc
class __$$OpdTokenImplCopyWithImpl<$Res>
    extends _$OpdTokenCopyWithImpl<$Res, _$OpdTokenImpl>
    implements _$$OpdTokenImplCopyWith<$Res> {
  __$$OpdTokenImplCopyWithImpl(
    _$OpdTokenImpl _value,
    $Res Function(_$OpdTokenImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpdToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchQuery = null,
    Object? patientName = null,
    Object? age = null,
    Object? sex = null,
    Object? department = null,
    Object? doctorName = null,
    Object? appointmentDate = freezed,
    Object? appointmentSlot = null,
    Object? chiefComplaint = null,
    Object? visitType = null,
    Object? paymentMode = null,
    Object? appliedCharge = null,
    Object? isSearching = null,
    Object? searchResults = null,
    Object? selectedPatient = freezed,
    Object? isSubmitting = null,
  }) {
    return _then(
      _$OpdTokenImpl(
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as String,
        sex: null == sex
            ? _value.sex
            : sex // ignore: cast_nullable_to_non_nullable
                  as String,
        department: null == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String,
        doctorName: null == doctorName
            ? _value.doctorName
            : doctorName // ignore: cast_nullable_to_non_nullable
                  as String,
        appointmentDate: freezed == appointmentDate
            ? _value.appointmentDate
            : appointmentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        appointmentSlot: null == appointmentSlot
            ? _value.appointmentSlot
            : appointmentSlot // ignore: cast_nullable_to_non_nullable
                  as String,
        chiefComplaint: null == chiefComplaint
            ? _value.chiefComplaint
            : chiefComplaint // ignore: cast_nullable_to_non_nullable
                  as String,
        visitType: null == visitType
            ? _value.visitType
            : visitType // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMode: null == paymentMode
            ? _value.paymentMode
            : paymentMode // ignore: cast_nullable_to_non_nullable
                  as String,
        appliedCharge: null == appliedCharge
            ? _value.appliedCharge
            : appliedCharge // ignore: cast_nullable_to_non_nullable
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
class _$OpdTokenImpl implements _OpdToken {
  const _$OpdTokenImpl({
    this.searchQuery = '',
    this.patientName = '',
    this.age = '',
    this.sex = 'Male',
    this.department = 'General Medicine',
    this.doctorName = 'Dr. Sharma (Medicine)',
    this.appointmentDate,
    this.appointmentSlot = '09:00 AM - 10:00 AM',
    this.chiefComplaint = '',
    this.visitType = 'OPD',
    this.paymentMode = 'Cash',
    this.appliedCharge = '50.00',
    this.isSearching = false,
    final List<PatientSummary> searchResults = const [],
    this.selectedPatient,
    this.isSubmitting = false,
  }) : _searchResults = searchResults;

  factory _$OpdTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpdTokenImplFromJson(json);

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final String patientName;
  @override
  @JsonKey()
  final String age;
  @override
  @JsonKey()
  final String sex;
  @override
  @JsonKey()
  final String department;
  @override
  @JsonKey()
  final String doctorName;
  @override
  final DateTime? appointmentDate;
  @override
  @JsonKey()
  final String appointmentSlot;
  @override
  @JsonKey()
  final String chiefComplaint;
  @override
  @JsonKey()
  final String visitType;
  @override
  @JsonKey()
  final String paymentMode;
  @override
  @JsonKey()
  final String appliedCharge;
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
  @override
  @JsonKey()
  final bool isSubmitting;

  @override
  String toString() {
    return 'OpdToken(searchQuery: $searchQuery, patientName: $patientName, age: $age, sex: $sex, department: $department, doctorName: $doctorName, appointmentDate: $appointmentDate, appointmentSlot: $appointmentSlot, chiefComplaint: $chiefComplaint, visitType: $visitType, paymentMode: $paymentMode, appliedCharge: $appliedCharge, isSearching: $isSearching, searchResults: $searchResults, selectedPatient: $selectedPatient, isSubmitting: $isSubmitting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpdTokenImpl &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.appointmentSlot, appointmentSlot) ||
                other.appointmentSlot == appointmentSlot) &&
            (identical(other.chiefComplaint, chiefComplaint) ||
                other.chiefComplaint == chiefComplaint) &&
            (identical(other.visitType, visitType) ||
                other.visitType == visitType) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.appliedCharge, appliedCharge) ||
                other.appliedCharge == appliedCharge) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            const DeepCollectionEquality().equals(
              other._searchResults,
              _searchResults,
            ) &&
            (identical(other.selectedPatient, selectedPatient) ||
                other.selectedPatient == selectedPatient) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    searchQuery,
    patientName,
    age,
    sex,
    department,
    doctorName,
    appointmentDate,
    appointmentSlot,
    chiefComplaint,
    visitType,
    paymentMode,
    appliedCharge,
    isSearching,
    const DeepCollectionEquality().hash(_searchResults),
    selectedPatient,
    isSubmitting,
  );

  /// Create a copy of OpdToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpdTokenImplCopyWith<_$OpdTokenImpl> get copyWith =>
      __$$OpdTokenImplCopyWithImpl<_$OpdTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OpdTokenImplToJson(this);
  }
}

abstract class _OpdToken implements OpdToken {
  const factory _OpdToken({
    final String searchQuery,
    final String patientName,
    final String age,
    final String sex,
    final String department,
    final String doctorName,
    final DateTime? appointmentDate,
    final String appointmentSlot,
    final String chiefComplaint,
    final String visitType,
    final String paymentMode,
    final String appliedCharge,
    final bool isSearching,
    final List<PatientSummary> searchResults,
    final PatientSummary? selectedPatient,
    final bool isSubmitting,
  }) = _$OpdTokenImpl;

  factory _OpdToken.fromJson(Map<String, dynamic> json) =
      _$OpdTokenImpl.fromJson;

  @override
  String get searchQuery;
  @override
  String get patientName;
  @override
  String get age;
  @override
  String get sex;
  @override
  String get department;
  @override
  String get doctorName;
  @override
  DateTime? get appointmentDate;
  @override
  String get appointmentSlot;
  @override
  String get chiefComplaint;
  @override
  String get visitType;
  @override
  String get paymentMode;
  @override
  String get appliedCharge;
  @override
  bool get isSearching;
  @override
  List<PatientSummary> get searchResults;
  @override
  PatientSummary? get selectedPatient;
  @override
  bool get isSubmitting;

  /// Create a copy of OpdToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpdTokenImplCopyWith<_$OpdTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PatientSummary _$PatientSummaryFromJson(Map<String, dynamic> json) {
  return _PatientSummary.fromJson(json);
}

/// @nodoc
mixin _$PatientSummary {
  String get mrn => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  String get sex => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;

  /// Serializes this PatientSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientSummaryCopyWith<PatientSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientSummaryCopyWith<$Res> {
  factory $PatientSummaryCopyWith(
    PatientSummary value,
    $Res Function(PatientSummary) then,
  ) = _$PatientSummaryCopyWithImpl<$Res, PatientSummary>;
  @useResult
  $Res call({String mrn, String name, String age, String sex, String phone});
}

/// @nodoc
class _$PatientSummaryCopyWithImpl<$Res, $Val extends PatientSummary>
    implements $PatientSummaryCopyWith<$Res> {
  _$PatientSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mrn = null,
    Object? name = null,
    Object? age = null,
    Object? sex = null,
    Object? phone = null,
  }) {
    return _then(
      _value.copyWith(
            mrn: null == mrn
                ? _value.mrn
                : mrn // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as String,
            sex: null == sex
                ? _value.sex
                : sex // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PatientSummaryImplCopyWith<$Res>
    implements $PatientSummaryCopyWith<$Res> {
  factory _$$PatientSummaryImplCopyWith(
    _$PatientSummaryImpl value,
    $Res Function(_$PatientSummaryImpl) then,
  ) = __$$PatientSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String mrn, String name, String age, String sex, String phone});
}

/// @nodoc
class __$$PatientSummaryImplCopyWithImpl<$Res>
    extends _$PatientSummaryCopyWithImpl<$Res, _$PatientSummaryImpl>
    implements _$$PatientSummaryImplCopyWith<$Res> {
  __$$PatientSummaryImplCopyWithImpl(
    _$PatientSummaryImpl _value,
    $Res Function(_$PatientSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mrn = null,
    Object? name = null,
    Object? age = null,
    Object? sex = null,
    Object? phone = null,
  }) {
    return _then(
      _$PatientSummaryImpl(
        mrn: null == mrn
            ? _value.mrn
            : mrn // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as String,
        sex: null == sex
            ? _value.sex
            : sex // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PatientSummaryImpl implements _PatientSummary {
  const _$PatientSummaryImpl({
    required this.mrn,
    required this.name,
    required this.age,
    required this.sex,
    required this.phone,
  });

  factory _$PatientSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientSummaryImplFromJson(json);

  @override
  final String mrn;
  @override
  final String name;
  @override
  final String age;
  @override
  final String sex;
  @override
  final String phone;

  @override
  String toString() {
    return 'PatientSummary(mrn: $mrn, name: $name, age: $age, sex: $sex, phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientSummaryImpl &&
            (identical(other.mrn, mrn) || other.mrn == mrn) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mrn, name, age, sex, phone);

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientSummaryImplCopyWith<_$PatientSummaryImpl> get copyWith =>
      __$$PatientSummaryImplCopyWithImpl<_$PatientSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientSummaryImplToJson(this);
  }
}

abstract class _PatientSummary implements PatientSummary {
  const factory _PatientSummary({
    required final String mrn,
    required final String name,
    required final String age,
    required final String sex,
    required final String phone,
  }) = _$PatientSummaryImpl;

  factory _PatientSummary.fromJson(Map<String, dynamic> json) =
      _$PatientSummaryImpl.fromJson;

  @override
  String get mrn;
  @override
  String get name;
  @override
  String get age;
  @override
  String get sex;
  @override
  String get phone;

  /// Create a copy of PatientSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientSummaryImplCopyWith<_$PatientSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
