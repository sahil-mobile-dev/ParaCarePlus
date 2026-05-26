// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doctor_dashboard_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OpdPatient {
  String get token => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get symptom => throw _privateConstructorUsedError;
  String get urgency => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of OpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpdPatientCopyWith<OpdPatient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpdPatientCopyWith<$Res> {
  factory $OpdPatientCopyWith(
    OpdPatient value,
    $Res Function(OpdPatient) then,
  ) = _$OpdPatientCopyWithImpl<$Res, OpdPatient>;
  @useResult
  $Res call({
    String token,
    String name,
    int age,
    String gender,
    String symptom,
    String urgency,
    String status,
  });
}

/// @nodoc
class _$OpdPatientCopyWithImpl<$Res, $Val extends OpdPatient>
    implements $OpdPatientCopyWith<$Res> {
  _$OpdPatientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? symptom = null,
    Object? urgency = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            token: null == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            symptom: null == symptom
                ? _value.symptom
                : symptom // ignore: cast_nullable_to_non_nullable
                      as String,
            urgency: null == urgency
                ? _value.urgency
                : urgency // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OpdPatientImplCopyWith<$Res>
    implements $OpdPatientCopyWith<$Res> {
  factory _$$OpdPatientImplCopyWith(
    _$OpdPatientImpl value,
    $Res Function(_$OpdPatientImpl) then,
  ) = __$$OpdPatientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String token,
    String name,
    int age,
    String gender,
    String symptom,
    String urgency,
    String status,
  });
}

/// @nodoc
class __$$OpdPatientImplCopyWithImpl<$Res>
    extends _$OpdPatientCopyWithImpl<$Res, _$OpdPatientImpl>
    implements _$$OpdPatientImplCopyWith<$Res> {
  __$$OpdPatientImplCopyWithImpl(
    _$OpdPatientImpl _value,
    $Res Function(_$OpdPatientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? symptom = null,
    Object? urgency = null,
    Object? status = null,
  }) {
    return _then(
      _$OpdPatientImpl(
        token: null == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        symptom: null == symptom
            ? _value.symptom
            : symptom // ignore: cast_nullable_to_non_nullable
                  as String,
        urgency: null == urgency
            ? _value.urgency
            : urgency // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$OpdPatientImpl implements _OpdPatient {
  const _$OpdPatientImpl({
    required this.token,
    required this.name,
    required this.age,
    required this.gender,
    required this.symptom,
    required this.urgency,
    required this.status,
  });

  @override
  final String token;
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String symptom;
  @override
  final String urgency;
  @override
  final String status;

  @override
  String toString() {
    return 'OpdPatient(token: $token, name: $name, age: $age, gender: $gender, symptom: $symptom, urgency: $urgency, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpdPatientImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.symptom, symptom) || other.symptom == symptom) &&
            (identical(other.urgency, urgency) || other.urgency == urgency) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    token,
    name,
    age,
    gender,
    symptom,
    urgency,
    status,
  );

  /// Create a copy of OpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpdPatientImplCopyWith<_$OpdPatientImpl> get copyWith =>
      __$$OpdPatientImplCopyWithImpl<_$OpdPatientImpl>(this, _$identity);
}

abstract class _OpdPatient implements OpdPatient {
  const factory _OpdPatient({
    required final String token,
    required final String name,
    required final int age,
    required final String gender,
    required final String symptom,
    required final String urgency,
    required final String status,
  }) = _$OpdPatientImpl;

  @override
  String get token;
  @override
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String get symptom;
  @override
  String get urgency;
  @override
  String get status;

  /// Create a copy of OpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpdPatientImplCopyWith<_$OpdPatientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$IpdPatient {
  String get bed => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String get diagnosis => throw _privateConstructorUsedError;
  int get systolicBP => throw _privateConstructorUsedError;
  int get diastolicBP => throw _privateConstructorUsedError;
  int get pulse => throw _privateConstructorUsedError;
  String get vitalsStatus =>
      throw _privateConstructorUsedError; // 'Stable', 'Warning', 'Critical'
  String get roundStatus =>
      throw _privateConstructorUsedError; // 'Pending', 'Done'
  String get clinicalNotes => throw _privateConstructorUsedError;

  /// Create a copy of IpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IpdPatientCopyWith<IpdPatient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IpdPatientCopyWith<$Res> {
  factory $IpdPatientCopyWith(
    IpdPatient value,
    $Res Function(IpdPatient) then,
  ) = _$IpdPatientCopyWithImpl<$Res, IpdPatient>;
  @useResult
  $Res call({
    String bed,
    String name,
    int age,
    String gender,
    String diagnosis,
    int systolicBP,
    int diastolicBP,
    int pulse,
    String vitalsStatus,
    String roundStatus,
    String clinicalNotes,
  });
}

/// @nodoc
class _$IpdPatientCopyWithImpl<$Res, $Val extends IpdPatient>
    implements $IpdPatientCopyWith<$Res> {
  _$IpdPatientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bed = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? diagnosis = null,
    Object? systolicBP = null,
    Object? diastolicBP = null,
    Object? pulse = null,
    Object? vitalsStatus = null,
    Object? roundStatus = null,
    Object? clinicalNotes = null,
  }) {
    return _then(
      _value.copyWith(
            bed: null == bed
                ? _value.bed
                : bed // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as String,
            diagnosis: null == diagnosis
                ? _value.diagnosis
                : diagnosis // ignore: cast_nullable_to_non_nullable
                      as String,
            systolicBP: null == systolicBP
                ? _value.systolicBP
                : systolicBP // ignore: cast_nullable_to_non_nullable
                      as int,
            diastolicBP: null == diastolicBP
                ? _value.diastolicBP
                : diastolicBP // ignore: cast_nullable_to_non_nullable
                      as int,
            pulse: null == pulse
                ? _value.pulse
                : pulse // ignore: cast_nullable_to_non_nullable
                      as int,
            vitalsStatus: null == vitalsStatus
                ? _value.vitalsStatus
                : vitalsStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            roundStatus: null == roundStatus
                ? _value.roundStatus
                : roundStatus // ignore: cast_nullable_to_non_nullable
                      as String,
            clinicalNotes: null == clinicalNotes
                ? _value.clinicalNotes
                : clinicalNotes // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IpdPatientImplCopyWith<$Res>
    implements $IpdPatientCopyWith<$Res> {
  factory _$$IpdPatientImplCopyWith(
    _$IpdPatientImpl value,
    $Res Function(_$IpdPatientImpl) then,
  ) = __$$IpdPatientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String bed,
    String name,
    int age,
    String gender,
    String diagnosis,
    int systolicBP,
    int diastolicBP,
    int pulse,
    String vitalsStatus,
    String roundStatus,
    String clinicalNotes,
  });
}

/// @nodoc
class __$$IpdPatientImplCopyWithImpl<$Res>
    extends _$IpdPatientCopyWithImpl<$Res, _$IpdPatientImpl>
    implements _$$IpdPatientImplCopyWith<$Res> {
  __$$IpdPatientImplCopyWithImpl(
    _$IpdPatientImpl _value,
    $Res Function(_$IpdPatientImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bed = null,
    Object? name = null,
    Object? age = null,
    Object? gender = null,
    Object? diagnosis = null,
    Object? systolicBP = null,
    Object? diastolicBP = null,
    Object? pulse = null,
    Object? vitalsStatus = null,
    Object? roundStatus = null,
    Object? clinicalNotes = null,
  }) {
    return _then(
      _$IpdPatientImpl(
        bed: null == bed
            ? _value.bed
            : bed // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as String,
        diagnosis: null == diagnosis
            ? _value.diagnosis
            : diagnosis // ignore: cast_nullable_to_non_nullable
                  as String,
        systolicBP: null == systolicBP
            ? _value.systolicBP
            : systolicBP // ignore: cast_nullable_to_non_nullable
                  as int,
        diastolicBP: null == diastolicBP
            ? _value.diastolicBP
            : diastolicBP // ignore: cast_nullable_to_non_nullable
                  as int,
        pulse: null == pulse
            ? _value.pulse
            : pulse // ignore: cast_nullable_to_non_nullable
                  as int,
        vitalsStatus: null == vitalsStatus
            ? _value.vitalsStatus
            : vitalsStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        roundStatus: null == roundStatus
            ? _value.roundStatus
            : roundStatus // ignore: cast_nullable_to_non_nullable
                  as String,
        clinicalNotes: null == clinicalNotes
            ? _value.clinicalNotes
            : clinicalNotes // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$IpdPatientImpl implements _IpdPatient {
  const _$IpdPatientImpl({
    required this.bed,
    required this.name,
    required this.age,
    required this.gender,
    required this.diagnosis,
    required this.systolicBP,
    required this.diastolicBP,
    required this.pulse,
    required this.vitalsStatus,
    required this.roundStatus,
    required this.clinicalNotes,
  });

  @override
  final String bed;
  @override
  final String name;
  @override
  final int age;
  @override
  final String gender;
  @override
  final String diagnosis;
  @override
  final int systolicBP;
  @override
  final int diastolicBP;
  @override
  final int pulse;
  @override
  final String vitalsStatus;
  // 'Stable', 'Warning', 'Critical'
  @override
  final String roundStatus;
  // 'Pending', 'Done'
  @override
  final String clinicalNotes;

  @override
  String toString() {
    return 'IpdPatient(bed: $bed, name: $name, age: $age, gender: $gender, diagnosis: $diagnosis, systolicBP: $systolicBP, diastolicBP: $diastolicBP, pulse: $pulse, vitalsStatus: $vitalsStatus, roundStatus: $roundStatus, clinicalNotes: $clinicalNotes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IpdPatientImpl &&
            (identical(other.bed, bed) || other.bed == bed) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.diagnosis, diagnosis) ||
                other.diagnosis == diagnosis) &&
            (identical(other.systolicBP, systolicBP) ||
                other.systolicBP == systolicBP) &&
            (identical(other.diastolicBP, diastolicBP) ||
                other.diastolicBP == diastolicBP) &&
            (identical(other.pulse, pulse) || other.pulse == pulse) &&
            (identical(other.vitalsStatus, vitalsStatus) ||
                other.vitalsStatus == vitalsStatus) &&
            (identical(other.roundStatus, roundStatus) ||
                other.roundStatus == roundStatus) &&
            (identical(other.clinicalNotes, clinicalNotes) ||
                other.clinicalNotes == clinicalNotes));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    bed,
    name,
    age,
    gender,
    diagnosis,
    systolicBP,
    diastolicBP,
    pulse,
    vitalsStatus,
    roundStatus,
    clinicalNotes,
  );

  /// Create a copy of IpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IpdPatientImplCopyWith<_$IpdPatientImpl> get copyWith =>
      __$$IpdPatientImplCopyWithImpl<_$IpdPatientImpl>(this, _$identity);
}

abstract class _IpdPatient implements IpdPatient {
  const factory _IpdPatient({
    required final String bed,
    required final String name,
    required final int age,
    required final String gender,
    required final String diagnosis,
    required final int systolicBP,
    required final int diastolicBP,
    required final int pulse,
    required final String vitalsStatus,
    required final String roundStatus,
    required final String clinicalNotes,
  }) = _$IpdPatientImpl;

  @override
  String get bed;
  @override
  String get name;
  @override
  int get age;
  @override
  String get gender;
  @override
  String get diagnosis;
  @override
  int get systolicBP;
  @override
  int get diastolicBP;
  @override
  int get pulse;
  @override
  String get vitalsStatus; // 'Stable', 'Warning', 'Critical'
  @override
  String get roundStatus; // 'Pending', 'Done'
  @override
  String get clinicalNotes;

  /// Create a copy of IpdPatient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IpdPatientImplCopyWith<_$IpdPatientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LabReport {
  String get id => throw _privateConstructorUsedError;
  String get patientName => throw _privateConstructorUsedError;
  String get testName => throw _privateConstructorUsedError;
  String get orderedDate => throw _privateConstructorUsedError;
  String get resultSummary => throw _privateConstructorUsedError;
  bool get isUrgent => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Create a copy of LabReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LabReportCopyWith<LabReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LabReportCopyWith<$Res> {
  factory $LabReportCopyWith(LabReport value, $Res Function(LabReport) then) =
      _$LabReportCopyWithImpl<$Res, LabReport>;
  @useResult
  $Res call({
    String id,
    String patientName,
    String testName,
    String orderedDate,
    String resultSummary,
    bool isUrgent,
    String status,
  });
}

/// @nodoc
class _$LabReportCopyWithImpl<$Res, $Val extends LabReport>
    implements $LabReportCopyWith<$Res> {
  _$LabReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LabReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientName = null,
    Object? testName = null,
    Object? orderedDate = null,
    Object? resultSummary = null,
    Object? isUrgent = null,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            patientName: null == patientName
                ? _value.patientName
                : patientName // ignore: cast_nullable_to_non_nullable
                      as String,
            testName: null == testName
                ? _value.testName
                : testName // ignore: cast_nullable_to_non_nullable
                      as String,
            orderedDate: null == orderedDate
                ? _value.orderedDate
                : orderedDate // ignore: cast_nullable_to_non_nullable
                      as String,
            resultSummary: null == resultSummary
                ? _value.resultSummary
                : resultSummary // ignore: cast_nullable_to_non_nullable
                      as String,
            isUrgent: null == isUrgent
                ? _value.isUrgent
                : isUrgent // ignore: cast_nullable_to_non_nullable
                      as bool,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LabReportImplCopyWith<$Res>
    implements $LabReportCopyWith<$Res> {
  factory _$$LabReportImplCopyWith(
    _$LabReportImpl value,
    $Res Function(_$LabReportImpl) then,
  ) = __$$LabReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String patientName,
    String testName,
    String orderedDate,
    String resultSummary,
    bool isUrgent,
    String status,
  });
}

/// @nodoc
class __$$LabReportImplCopyWithImpl<$Res>
    extends _$LabReportCopyWithImpl<$Res, _$LabReportImpl>
    implements _$$LabReportImplCopyWith<$Res> {
  __$$LabReportImplCopyWithImpl(
    _$LabReportImpl _value,
    $Res Function(_$LabReportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LabReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? patientName = null,
    Object? testName = null,
    Object? orderedDate = null,
    Object? resultSummary = null,
    Object? isUrgent = null,
    Object? status = null,
  }) {
    return _then(
      _$LabReportImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        patientName: null == patientName
            ? _value.patientName
            : patientName // ignore: cast_nullable_to_non_nullable
                  as String,
        testName: null == testName
            ? _value.testName
            : testName // ignore: cast_nullable_to_non_nullable
                  as String,
        orderedDate: null == orderedDate
            ? _value.orderedDate
            : orderedDate // ignore: cast_nullable_to_non_nullable
                  as String,
        resultSummary: null == resultSummary
            ? _value.resultSummary
            : resultSummary // ignore: cast_nullable_to_non_nullable
                  as String,
        isUrgent: null == isUrgent
            ? _value.isUrgent
            : isUrgent // ignore: cast_nullable_to_non_nullable
                  as bool,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LabReportImpl implements _LabReport {
  const _$LabReportImpl({
    required this.id,
    required this.patientName,
    required this.testName,
    required this.orderedDate,
    required this.resultSummary,
    required this.isUrgent,
    required this.status,
  });

  @override
  final String id;
  @override
  final String patientName;
  @override
  final String testName;
  @override
  final String orderedDate;
  @override
  final String resultSummary;
  @override
  final bool isUrgent;
  @override
  final String status;

  @override
  String toString() {
    return 'LabReport(id: $id, patientName: $patientName, testName: $testName, orderedDate: $orderedDate, resultSummary: $resultSummary, isUrgent: $isUrgent, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LabReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.patientName, patientName) ||
                other.patientName == patientName) &&
            (identical(other.testName, testName) ||
                other.testName == testName) &&
            (identical(other.orderedDate, orderedDate) ||
                other.orderedDate == orderedDate) &&
            (identical(other.resultSummary, resultSummary) ||
                other.resultSummary == resultSummary) &&
            (identical(other.isUrgent, isUrgent) ||
                other.isUrgent == isUrgent) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    patientName,
    testName,
    orderedDate,
    resultSummary,
    isUrgent,
    status,
  );

  /// Create a copy of LabReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LabReportImplCopyWith<_$LabReportImpl> get copyWith =>
      __$$LabReportImplCopyWithImpl<_$LabReportImpl>(this, _$identity);
}

abstract class _LabReport implements LabReport {
  const factory _LabReport({
    required final String id,
    required final String patientName,
    required final String testName,
    required final String orderedDate,
    required final String resultSummary,
    required final bool isUrgent,
    required final String status,
  }) = _$LabReportImpl;

  @override
  String get id;
  @override
  String get patientName;
  @override
  String get testName;
  @override
  String get orderedDate;
  @override
  String get resultSummary;
  @override
  bool get isUrgent;
  @override
  String get status;

  /// Create a copy of LabReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LabReportImplCopyWith<_$LabReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DoctorDashboardState {
  DoctorTab get activeTab => throw _privateConstructorUsedError;
  int get completedOpdCount => throw _privateConstructorUsedError;
  int get activeIpdCount => throw _privateConstructorUsedError;
  int get pendingLabCount => throw _privateConstructorUsedError;
  List<OpdPatient> get opdPatients => throw _privateConstructorUsedError;
  List<IpdPatient> get ipdPatients => throw _privateConstructorUsedError;
  List<LabReport> get labReports => throw _privateConstructorUsedError;
  List<String> get urgentAlerts => throw _privateConstructorUsedError;
  OpdPatient? get consultingPatient => throw _privateConstructorUsedError;
  LabReport? get selectedReportToReview => throw _privateConstructorUsedError;

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DoctorDashboardStateCopyWith<DoctorDashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DoctorDashboardStateCopyWith<$Res> {
  factory $DoctorDashboardStateCopyWith(
    DoctorDashboardState value,
    $Res Function(DoctorDashboardState) then,
  ) = _$DoctorDashboardStateCopyWithImpl<$Res, DoctorDashboardState>;
  @useResult
  $Res call({
    DoctorTab activeTab,
    int completedOpdCount,
    int activeIpdCount,
    int pendingLabCount,
    List<OpdPatient> opdPatients,
    List<IpdPatient> ipdPatients,
    List<LabReport> labReports,
    List<String> urgentAlerts,
    OpdPatient? consultingPatient,
    LabReport? selectedReportToReview,
  });

  $OpdPatientCopyWith<$Res>? get consultingPatient;
  $LabReportCopyWith<$Res>? get selectedReportToReview;
}

/// @nodoc
class _$DoctorDashboardStateCopyWithImpl<
  $Res,
  $Val extends DoctorDashboardState
>
    implements $DoctorDashboardStateCopyWith<$Res> {
  _$DoctorDashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeTab = null,
    Object? completedOpdCount = null,
    Object? activeIpdCount = null,
    Object? pendingLabCount = null,
    Object? opdPatients = null,
    Object? ipdPatients = null,
    Object? labReports = null,
    Object? urgentAlerts = null,
    Object? consultingPatient = freezed,
    Object? selectedReportToReview = freezed,
  }) {
    return _then(
      _value.copyWith(
            activeTab: null == activeTab
                ? _value.activeTab
                : activeTab // ignore: cast_nullable_to_non_nullable
                      as DoctorTab,
            completedOpdCount: null == completedOpdCount
                ? _value.completedOpdCount
                : completedOpdCount // ignore: cast_nullable_to_non_nullable
                      as int,
            activeIpdCount: null == activeIpdCount
                ? _value.activeIpdCount
                : activeIpdCount // ignore: cast_nullable_to_non_nullable
                      as int,
            pendingLabCount: null == pendingLabCount
                ? _value.pendingLabCount
                : pendingLabCount // ignore: cast_nullable_to_non_nullable
                      as int,
            opdPatients: null == opdPatients
                ? _value.opdPatients
                : opdPatients // ignore: cast_nullable_to_non_nullable
                      as List<OpdPatient>,
            ipdPatients: null == ipdPatients
                ? _value.ipdPatients
                : ipdPatients // ignore: cast_nullable_to_non_nullable
                      as List<IpdPatient>,
            labReports: null == labReports
                ? _value.labReports
                : labReports // ignore: cast_nullable_to_non_nullable
                      as List<LabReport>,
            urgentAlerts: null == urgentAlerts
                ? _value.urgentAlerts
                : urgentAlerts // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            consultingPatient: freezed == consultingPatient
                ? _value.consultingPatient
                : consultingPatient // ignore: cast_nullable_to_non_nullable
                      as OpdPatient?,
            selectedReportToReview: freezed == selectedReportToReview
                ? _value.selectedReportToReview
                : selectedReportToReview // ignore: cast_nullable_to_non_nullable
                      as LabReport?,
          )
          as $Val,
    );
  }

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $OpdPatientCopyWith<$Res>? get consultingPatient {
    if (_value.consultingPatient == null) {
      return null;
    }

    return $OpdPatientCopyWith<$Res>(_value.consultingPatient!, (value) {
      return _then(_value.copyWith(consultingPatient: value) as $Val);
    });
  }

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LabReportCopyWith<$Res>? get selectedReportToReview {
    if (_value.selectedReportToReview == null) {
      return null;
    }

    return $LabReportCopyWith<$Res>(_value.selectedReportToReview!, (value) {
      return _then(_value.copyWith(selectedReportToReview: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DoctorDashboardStateImplCopyWith<$Res>
    implements $DoctorDashboardStateCopyWith<$Res> {
  factory _$$DoctorDashboardStateImplCopyWith(
    _$DoctorDashboardStateImpl value,
    $Res Function(_$DoctorDashboardStateImpl) then,
  ) = __$$DoctorDashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DoctorTab activeTab,
    int completedOpdCount,
    int activeIpdCount,
    int pendingLabCount,
    List<OpdPatient> opdPatients,
    List<IpdPatient> ipdPatients,
    List<LabReport> labReports,
    List<String> urgentAlerts,
    OpdPatient? consultingPatient,
    LabReport? selectedReportToReview,
  });

  @override
  $OpdPatientCopyWith<$Res>? get consultingPatient;
  @override
  $LabReportCopyWith<$Res>? get selectedReportToReview;
}

/// @nodoc
class __$$DoctorDashboardStateImplCopyWithImpl<$Res>
    extends _$DoctorDashboardStateCopyWithImpl<$Res, _$DoctorDashboardStateImpl>
    implements _$$DoctorDashboardStateImplCopyWith<$Res> {
  __$$DoctorDashboardStateImplCopyWithImpl(
    _$DoctorDashboardStateImpl _value,
    $Res Function(_$DoctorDashboardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeTab = null,
    Object? completedOpdCount = null,
    Object? activeIpdCount = null,
    Object? pendingLabCount = null,
    Object? opdPatients = null,
    Object? ipdPatients = null,
    Object? labReports = null,
    Object? urgentAlerts = null,
    Object? consultingPatient = freezed,
    Object? selectedReportToReview = freezed,
  }) {
    return _then(
      _$DoctorDashboardStateImpl(
        activeTab: null == activeTab
            ? _value.activeTab
            : activeTab // ignore: cast_nullable_to_non_nullable
                  as DoctorTab,
        completedOpdCount: null == completedOpdCount
            ? _value.completedOpdCount
            : completedOpdCount // ignore: cast_nullable_to_non_nullable
                  as int,
        activeIpdCount: null == activeIpdCount
            ? _value.activeIpdCount
            : activeIpdCount // ignore: cast_nullable_to_non_nullable
                  as int,
        pendingLabCount: null == pendingLabCount
            ? _value.pendingLabCount
            : pendingLabCount // ignore: cast_nullable_to_non_nullable
                  as int,
        opdPatients: null == opdPatients
            ? _value._opdPatients
            : opdPatients // ignore: cast_nullable_to_non_nullable
                  as List<OpdPatient>,
        ipdPatients: null == ipdPatients
            ? _value._ipdPatients
            : ipdPatients // ignore: cast_nullable_to_non_nullable
                  as List<IpdPatient>,
        labReports: null == labReports
            ? _value._labReports
            : labReports // ignore: cast_nullable_to_non_nullable
                  as List<LabReport>,
        urgentAlerts: null == urgentAlerts
            ? _value._urgentAlerts
            : urgentAlerts // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        consultingPatient: freezed == consultingPatient
            ? _value.consultingPatient
            : consultingPatient // ignore: cast_nullable_to_non_nullable
                  as OpdPatient?,
        selectedReportToReview: freezed == selectedReportToReview
            ? _value.selectedReportToReview
            : selectedReportToReview // ignore: cast_nullable_to_non_nullable
                  as LabReport?,
      ),
    );
  }
}

/// @nodoc

class _$DoctorDashboardStateImpl implements _DoctorDashboardState {
  const _$DoctorDashboardStateImpl({
    this.activeTab = DoctorTab.console,
    this.completedOpdCount = 12,
    this.activeIpdCount = 8,
    this.pendingLabCount = 5,
    final List<OpdPatient> opdPatients = const [],
    final List<IpdPatient> ipdPatients = const [],
    final List<LabReport> labReports = const [],
    final List<String> urgentAlerts = const [],
    this.consultingPatient = null,
    this.selectedReportToReview = null,
  }) : _opdPatients = opdPatients,
       _ipdPatients = ipdPatients,
       _labReports = labReports,
       _urgentAlerts = urgentAlerts;

  @override
  @JsonKey()
  final DoctorTab activeTab;
  @override
  @JsonKey()
  final int completedOpdCount;
  @override
  @JsonKey()
  final int activeIpdCount;
  @override
  @JsonKey()
  final int pendingLabCount;
  final List<OpdPatient> _opdPatients;
  @override
  @JsonKey()
  List<OpdPatient> get opdPatients {
    if (_opdPatients is EqualUnmodifiableListView) return _opdPatients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_opdPatients);
  }

  final List<IpdPatient> _ipdPatients;
  @override
  @JsonKey()
  List<IpdPatient> get ipdPatients {
    if (_ipdPatients is EqualUnmodifiableListView) return _ipdPatients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ipdPatients);
  }

  final List<LabReport> _labReports;
  @override
  @JsonKey()
  List<LabReport> get labReports {
    if (_labReports is EqualUnmodifiableListView) return _labReports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_labReports);
  }

  final List<String> _urgentAlerts;
  @override
  @JsonKey()
  List<String> get urgentAlerts {
    if (_urgentAlerts is EqualUnmodifiableListView) return _urgentAlerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_urgentAlerts);
  }

  @override
  @JsonKey()
  final OpdPatient? consultingPatient;
  @override
  @JsonKey()
  final LabReport? selectedReportToReview;

  @override
  String toString() {
    return 'DoctorDashboardState(activeTab: $activeTab, completedOpdCount: $completedOpdCount, activeIpdCount: $activeIpdCount, pendingLabCount: $pendingLabCount, opdPatients: $opdPatients, ipdPatients: $ipdPatients, labReports: $labReports, urgentAlerts: $urgentAlerts, consultingPatient: $consultingPatient, selectedReportToReview: $selectedReportToReview)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DoctorDashboardStateImpl &&
            (identical(other.activeTab, activeTab) ||
                other.activeTab == activeTab) &&
            (identical(other.completedOpdCount, completedOpdCount) ||
                other.completedOpdCount == completedOpdCount) &&
            (identical(other.activeIpdCount, activeIpdCount) ||
                other.activeIpdCount == activeIpdCount) &&
            (identical(other.pendingLabCount, pendingLabCount) ||
                other.pendingLabCount == pendingLabCount) &&
            const DeepCollectionEquality().equals(
              other._opdPatients,
              _opdPatients,
            ) &&
            const DeepCollectionEquality().equals(
              other._ipdPatients,
              _ipdPatients,
            ) &&
            const DeepCollectionEquality().equals(
              other._labReports,
              _labReports,
            ) &&
            const DeepCollectionEquality().equals(
              other._urgentAlerts,
              _urgentAlerts,
            ) &&
            (identical(other.consultingPatient, consultingPatient) ||
                other.consultingPatient == consultingPatient) &&
            (identical(other.selectedReportToReview, selectedReportToReview) ||
                other.selectedReportToReview == selectedReportToReview));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    activeTab,
    completedOpdCount,
    activeIpdCount,
    pendingLabCount,
    const DeepCollectionEquality().hash(_opdPatients),
    const DeepCollectionEquality().hash(_ipdPatients),
    const DeepCollectionEquality().hash(_labReports),
    const DeepCollectionEquality().hash(_urgentAlerts),
    consultingPatient,
    selectedReportToReview,
  );

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DoctorDashboardStateImplCopyWith<_$DoctorDashboardStateImpl>
  get copyWith =>
      __$$DoctorDashboardStateImplCopyWithImpl<_$DoctorDashboardStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DoctorDashboardState implements DoctorDashboardState {
  const factory _DoctorDashboardState({
    final DoctorTab activeTab,
    final int completedOpdCount,
    final int activeIpdCount,
    final int pendingLabCount,
    final List<OpdPatient> opdPatients,
    final List<IpdPatient> ipdPatients,
    final List<LabReport> labReports,
    final List<String> urgentAlerts,
    final OpdPatient? consultingPatient,
    final LabReport? selectedReportToReview,
  }) = _$DoctorDashboardStateImpl;

  @override
  DoctorTab get activeTab;
  @override
  int get completedOpdCount;
  @override
  int get activeIpdCount;
  @override
  int get pendingLabCount;
  @override
  List<OpdPatient> get opdPatients;
  @override
  List<IpdPatient> get ipdPatients;
  @override
  List<LabReport> get labReports;
  @override
  List<String> get urgentAlerts;
  @override
  OpdPatient? get consultingPatient;
  @override
  LabReport? get selectedReportToReview;

  /// Create a copy of DoctorDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DoctorDashboardStateImplCopyWith<_$DoctorDashboardStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
