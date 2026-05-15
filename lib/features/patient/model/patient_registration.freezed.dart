// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_registration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PatientRegistration _$PatientRegistrationFromJson(Map<String, dynamic> json) {
  return _PatientRegistration.fromJson(json);
}

/// @nodoc
mixin _$PatientRegistration {
  // Step 1: Personal Info
  PatientTitle get title => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;
  BloodGroup get bloodGroup => throw _privateConstructorUsedError;
  String get aadhaarNumber => throw _privateConstructorUsedError;
  String get ayushmanBharatId => throw _privateConstructorUsedError;
  MaritalStatus get maritalStatus => throw _privateConstructorUsedError;
  Religion get religion => throw _privateConstructorUsedError;
  String get occupation => throw _privateConstructorUsedError;
  Category get category =>
      throw _privateConstructorUsedError; // Step 2: Contact & Address
  String get mobileNumber => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get state => throw _privateConstructorUsedError;
  String get pincode => throw _privateConstructorUsedError;
  String get emergencyContactName => throw _privateConstructorUsedError;
  String get emergencyContactNumber =>
      throw _privateConstructorUsedError; // Step 3: Medical History
  List<String> get allergies => throw _privateConstructorUsedError;
  List<String> get chronicIllnesses => throw _privateConstructorUsedError;
  String get smokingHabit => throw _privateConstructorUsedError;
  String get alcoholHabit => throw _privateConstructorUsedError;
  String get familyHistory => throw _privateConstructorUsedError;
  String get vaccinationHistory => throw _privateConstructorUsedError;
  String get currentMedications => throw _privateConstructorUsedError;
  String get pastSurgeries =>
      throw _privateConstructorUsedError; // Step 4: Visit Type
  String get visitType =>
      throw _privateConstructorUsedError; // OPD, IPD, Emergency
  String get department => throw _privateConstructorUsedError;
  String get doctorName => throw _privateConstructorUsedError;
  DateTime? get appointmentDate => throw _privateConstructorUsedError;
  String get appointmentSlot => throw _privateConstructorUsedError;
  String get bedNumber => throw _privateConstructorUsedError;
  String get paymentMode => throw _privateConstructorUsedError;
  String get registrationFee => throw _privateConstructorUsedError;
  String get admissionReason => throw _privateConstructorUsedError;
  String get primaryComplaint => throw _privateConstructorUsedError;
  String get referredBy => throw _privateConstructorUsedError; // Meta
  int get currentStep => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;

  /// Serializes this PatientRegistration to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PatientRegistration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientRegistrationCopyWith<PatientRegistration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientRegistrationCopyWith<$Res> {
  factory $PatientRegistrationCopyWith(
    PatientRegistration value,
    $Res Function(PatientRegistration) then,
  ) = _$PatientRegistrationCopyWithImpl<$Res, PatientRegistration>;
  @useResult
  $Res call({
    PatientTitle title,
    String fullName,
    DateTime? dateOfBirth,
    String age,
    Gender gender,
    BloodGroup bloodGroup,
    String aadhaarNumber,
    String ayushmanBharatId,
    MaritalStatus maritalStatus,
    Religion religion,
    String occupation,
    Category category,
    String mobileNumber,
    String email,
    String address,
    String city,
    String state,
    String pincode,
    String emergencyContactName,
    String emergencyContactNumber,
    List<String> allergies,
    List<String> chronicIllnesses,
    String smokingHabit,
    String alcoholHabit,
    String familyHistory,
    String vaccinationHistory,
    String currentMedications,
    String pastSurgeries,
    String visitType,
    String department,
    String doctorName,
    DateTime? appointmentDate,
    String appointmentSlot,
    String bedNumber,
    String paymentMode,
    String registrationFee,
    String admissionReason,
    String primaryComplaint,
    String referredBy,
    int currentStep,
    bool isSubmitting,
  });
}

/// @nodoc
class _$PatientRegistrationCopyWithImpl<$Res, $Val extends PatientRegistration>
    implements $PatientRegistrationCopyWith<$Res> {
  _$PatientRegistrationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientRegistration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? fullName = null,
    Object? dateOfBirth = freezed,
    Object? age = null,
    Object? gender = null,
    Object? bloodGroup = null,
    Object? aadhaarNumber = null,
    Object? ayushmanBharatId = null,
    Object? maritalStatus = null,
    Object? religion = null,
    Object? occupation = null,
    Object? category = null,
    Object? mobileNumber = null,
    Object? email = null,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? pincode = null,
    Object? emergencyContactName = null,
    Object? emergencyContactNumber = null,
    Object? allergies = null,
    Object? chronicIllnesses = null,
    Object? smokingHabit = null,
    Object? alcoholHabit = null,
    Object? familyHistory = null,
    Object? vaccinationHistory = null,
    Object? currentMedications = null,
    Object? pastSurgeries = null,
    Object? visitType = null,
    Object? department = null,
    Object? doctorName = null,
    Object? appointmentDate = freezed,
    Object? appointmentSlot = null,
    Object? bedNumber = null,
    Object? paymentMode = null,
    Object? registrationFee = null,
    Object? admissionReason = null,
    Object? primaryComplaint = null,
    Object? referredBy = null,
    Object? currentStep = null,
    Object? isSubmitting = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as PatientTitle,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as String,
            gender: null == gender
                ? _value.gender
                : gender // ignore: cast_nullable_to_non_nullable
                      as Gender,
            bloodGroup: null == bloodGroup
                ? _value.bloodGroup
                : bloodGroup // ignore: cast_nullable_to_non_nullable
                      as BloodGroup,
            aadhaarNumber: null == aadhaarNumber
                ? _value.aadhaarNumber
                : aadhaarNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            ayushmanBharatId: null == ayushmanBharatId
                ? _value.ayushmanBharatId
                : ayushmanBharatId // ignore: cast_nullable_to_non_nullable
                      as String,
            maritalStatus: null == maritalStatus
                ? _value.maritalStatus
                : maritalStatus // ignore: cast_nullable_to_non_nullable
                      as MaritalStatus,
            religion: null == religion
                ? _value.religion
                : religion // ignore: cast_nullable_to_non_nullable
                      as Religion,
            occupation: null == occupation
                ? _value.occupation
                : occupation // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as Category,
            mobileNumber: null == mobileNumber
                ? _value.mobileNumber
                : mobileNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            state: null == state
                ? _value.state
                : state // ignore: cast_nullable_to_non_nullable
                      as String,
            pincode: null == pincode
                ? _value.pincode
                : pincode // ignore: cast_nullable_to_non_nullable
                      as String,
            emergencyContactName: null == emergencyContactName
                ? _value.emergencyContactName
                : emergencyContactName // ignore: cast_nullable_to_non_nullable
                      as String,
            emergencyContactNumber: null == emergencyContactNumber
                ? _value.emergencyContactNumber
                : emergencyContactNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            allergies: null == allergies
                ? _value.allergies
                : allergies // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            chronicIllnesses: null == chronicIllnesses
                ? _value.chronicIllnesses
                : chronicIllnesses // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            smokingHabit: null == smokingHabit
                ? _value.smokingHabit
                : smokingHabit // ignore: cast_nullable_to_non_nullable
                      as String,
            alcoholHabit: null == alcoholHabit
                ? _value.alcoholHabit
                : alcoholHabit // ignore: cast_nullable_to_non_nullable
                      as String,
            familyHistory: null == familyHistory
                ? _value.familyHistory
                : familyHistory // ignore: cast_nullable_to_non_nullable
                      as String,
            vaccinationHistory: null == vaccinationHistory
                ? _value.vaccinationHistory
                : vaccinationHistory // ignore: cast_nullable_to_non_nullable
                      as String,
            currentMedications: null == currentMedications
                ? _value.currentMedications
                : currentMedications // ignore: cast_nullable_to_non_nullable
                      as String,
            pastSurgeries: null == pastSurgeries
                ? _value.pastSurgeries
                : pastSurgeries // ignore: cast_nullable_to_non_nullable
                      as String,
            visitType: null == visitType
                ? _value.visitType
                : visitType // ignore: cast_nullable_to_non_nullable
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
            bedNumber: null == bedNumber
                ? _value.bedNumber
                : bedNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMode: null == paymentMode
                ? _value.paymentMode
                : paymentMode // ignore: cast_nullable_to_non_nullable
                      as String,
            registrationFee: null == registrationFee
                ? _value.registrationFee
                : registrationFee // ignore: cast_nullable_to_non_nullable
                      as String,
            admissionReason: null == admissionReason
                ? _value.admissionReason
                : admissionReason // ignore: cast_nullable_to_non_nullable
                      as String,
            primaryComplaint: null == primaryComplaint
                ? _value.primaryComplaint
                : primaryComplaint // ignore: cast_nullable_to_non_nullable
                      as String,
            referredBy: null == referredBy
                ? _value.referredBy
                : referredBy // ignore: cast_nullable_to_non_nullable
                      as String,
            currentStep: null == currentStep
                ? _value.currentStep
                : currentStep // ignore: cast_nullable_to_non_nullable
                      as int,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PatientRegistrationImplCopyWith<$Res>
    implements $PatientRegistrationCopyWith<$Res> {
  factory _$$PatientRegistrationImplCopyWith(
    _$PatientRegistrationImpl value,
    $Res Function(_$PatientRegistrationImpl) then,
  ) = __$$PatientRegistrationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PatientTitle title,
    String fullName,
    DateTime? dateOfBirth,
    String age,
    Gender gender,
    BloodGroup bloodGroup,
    String aadhaarNumber,
    String ayushmanBharatId,
    MaritalStatus maritalStatus,
    Religion religion,
    String occupation,
    Category category,
    String mobileNumber,
    String email,
    String address,
    String city,
    String state,
    String pincode,
    String emergencyContactName,
    String emergencyContactNumber,
    List<String> allergies,
    List<String> chronicIllnesses,
    String smokingHabit,
    String alcoholHabit,
    String familyHistory,
    String vaccinationHistory,
    String currentMedications,
    String pastSurgeries,
    String visitType,
    String department,
    String doctorName,
    DateTime? appointmentDate,
    String appointmentSlot,
    String bedNumber,
    String paymentMode,
    String registrationFee,
    String admissionReason,
    String primaryComplaint,
    String referredBy,
    int currentStep,
    bool isSubmitting,
  });
}

/// @nodoc
class __$$PatientRegistrationImplCopyWithImpl<$Res>
    extends _$PatientRegistrationCopyWithImpl<$Res, _$PatientRegistrationImpl>
    implements _$$PatientRegistrationImplCopyWith<$Res> {
  __$$PatientRegistrationImplCopyWithImpl(
    _$PatientRegistrationImpl _value,
    $Res Function(_$PatientRegistrationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PatientRegistration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? fullName = null,
    Object? dateOfBirth = freezed,
    Object? age = null,
    Object? gender = null,
    Object? bloodGroup = null,
    Object? aadhaarNumber = null,
    Object? ayushmanBharatId = null,
    Object? maritalStatus = null,
    Object? religion = null,
    Object? occupation = null,
    Object? category = null,
    Object? mobileNumber = null,
    Object? email = null,
    Object? address = null,
    Object? city = null,
    Object? state = null,
    Object? pincode = null,
    Object? emergencyContactName = null,
    Object? emergencyContactNumber = null,
    Object? allergies = null,
    Object? chronicIllnesses = null,
    Object? smokingHabit = null,
    Object? alcoholHabit = null,
    Object? familyHistory = null,
    Object? vaccinationHistory = null,
    Object? currentMedications = null,
    Object? pastSurgeries = null,
    Object? visitType = null,
    Object? department = null,
    Object? doctorName = null,
    Object? appointmentDate = freezed,
    Object? appointmentSlot = null,
    Object? bedNumber = null,
    Object? paymentMode = null,
    Object? registrationFee = null,
    Object? admissionReason = null,
    Object? primaryComplaint = null,
    Object? referredBy = null,
    Object? currentStep = null,
    Object? isSubmitting = null,
  }) {
    return _then(
      _$PatientRegistrationImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as PatientTitle,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as String,
        gender: null == gender
            ? _value.gender
            : gender // ignore: cast_nullable_to_non_nullable
                  as Gender,
        bloodGroup: null == bloodGroup
            ? _value.bloodGroup
            : bloodGroup // ignore: cast_nullable_to_non_nullable
                  as BloodGroup,
        aadhaarNumber: null == aadhaarNumber
            ? _value.aadhaarNumber
            : aadhaarNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        ayushmanBharatId: null == ayushmanBharatId
            ? _value.ayushmanBharatId
            : ayushmanBharatId // ignore: cast_nullable_to_non_nullable
                  as String,
        maritalStatus: null == maritalStatus
            ? _value.maritalStatus
            : maritalStatus // ignore: cast_nullable_to_non_nullable
                  as MaritalStatus,
        religion: null == religion
            ? _value.religion
            : religion // ignore: cast_nullable_to_non_nullable
                  as Religion,
        occupation: null == occupation
            ? _value.occupation
            : occupation // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as Category,
        mobileNumber: null == mobileNumber
            ? _value.mobileNumber
            : mobileNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        state: null == state
            ? _value.state
            : state // ignore: cast_nullable_to_non_nullable
                  as String,
        pincode: null == pincode
            ? _value.pincode
            : pincode // ignore: cast_nullable_to_non_nullable
                  as String,
        emergencyContactName: null == emergencyContactName
            ? _value.emergencyContactName
            : emergencyContactName // ignore: cast_nullable_to_non_nullable
                  as String,
        emergencyContactNumber: null == emergencyContactNumber
            ? _value.emergencyContactNumber
            : emergencyContactNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        allergies: null == allergies
            ? _value._allergies
            : allergies // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        chronicIllnesses: null == chronicIllnesses
            ? _value._chronicIllnesses
            : chronicIllnesses // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        smokingHabit: null == smokingHabit
            ? _value.smokingHabit
            : smokingHabit // ignore: cast_nullable_to_non_nullable
                  as String,
        alcoholHabit: null == alcoholHabit
            ? _value.alcoholHabit
            : alcoholHabit // ignore: cast_nullable_to_non_nullable
                  as String,
        familyHistory: null == familyHistory
            ? _value.familyHistory
            : familyHistory // ignore: cast_nullable_to_non_nullable
                  as String,
        vaccinationHistory: null == vaccinationHistory
            ? _value.vaccinationHistory
            : vaccinationHistory // ignore: cast_nullable_to_non_nullable
                  as String,
        currentMedications: null == currentMedications
            ? _value.currentMedications
            : currentMedications // ignore: cast_nullable_to_non_nullable
                  as String,
        pastSurgeries: null == pastSurgeries
            ? _value.pastSurgeries
            : pastSurgeries // ignore: cast_nullable_to_non_nullable
                  as String,
        visitType: null == visitType
            ? _value.visitType
            : visitType // ignore: cast_nullable_to_non_nullable
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
        bedNumber: null == bedNumber
            ? _value.bedNumber
            : bedNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMode: null == paymentMode
            ? _value.paymentMode
            : paymentMode // ignore: cast_nullable_to_non_nullable
                  as String,
        registrationFee: null == registrationFee
            ? _value.registrationFee
            : registrationFee // ignore: cast_nullable_to_non_nullable
                  as String,
        admissionReason: null == admissionReason
            ? _value.admissionReason
            : admissionReason // ignore: cast_nullable_to_non_nullable
                  as String,
        primaryComplaint: null == primaryComplaint
            ? _value.primaryComplaint
            : primaryComplaint // ignore: cast_nullable_to_non_nullable
                  as String,
        referredBy: null == referredBy
            ? _value.referredBy
            : referredBy // ignore: cast_nullable_to_non_nullable
                  as String,
        currentStep: null == currentStep
            ? _value.currentStep
            : currentStep // ignore: cast_nullable_to_non_nullable
                  as int,
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
class _$PatientRegistrationImpl implements _PatientRegistration {
  const _$PatientRegistrationImpl({
    this.title = PatientTitle.mr,
    this.fullName = '',
    this.dateOfBirth,
    this.age = '',
    this.gender = Gender.male,
    this.bloodGroup = BloodGroup.unknown,
    this.aadhaarNumber = '',
    this.ayushmanBharatId = '',
    this.maritalStatus = MaritalStatus.single,
    this.religion = Religion.hindu,
    this.occupation = '',
    this.category = Category.general,
    this.mobileNumber = '',
    this.email = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.pincode = '',
    this.emergencyContactName = '',
    this.emergencyContactNumber = '',
    final List<String> allergies = const [],
    final List<String> chronicIllnesses = const [],
    this.smokingHabit = 'Never',
    this.alcoholHabit = 'Never',
    this.familyHistory = '',
    this.vaccinationHistory = 'Unknown',
    this.currentMedications = '',
    this.pastSurgeries = '',
    this.visitType = 'OPD',
    this.department = 'General Medicine',
    this.doctorName = 'Dr. Sharma (Medicine)',
    this.appointmentDate,
    this.appointmentSlot = '09:00 AM - 10:00 AM',
    this.bedNumber = 'General Ward - B101',
    this.paymentMode = 'Cash',
    this.registrationFee = '0.00',
    this.admissionReason = '',
    this.primaryComplaint = '',
    this.referredBy = '',
    this.currentStep = 0,
    this.isSubmitting = false,
  }) : _allergies = allergies,
       _chronicIllnesses = chronicIllnesses;

  factory _$PatientRegistrationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PatientRegistrationImplFromJson(json);

  // Step 1: Personal Info
  @override
  @JsonKey()
  final PatientTitle title;
  @override
  @JsonKey()
  final String fullName;
  @override
  final DateTime? dateOfBirth;
  @override
  @JsonKey()
  final String age;
  @override
  @JsonKey()
  final Gender gender;
  @override
  @JsonKey()
  final BloodGroup bloodGroup;
  @override
  @JsonKey()
  final String aadhaarNumber;
  @override
  @JsonKey()
  final String ayushmanBharatId;
  @override
  @JsonKey()
  final MaritalStatus maritalStatus;
  @override
  @JsonKey()
  final Religion religion;
  @override
  @JsonKey()
  final String occupation;
  @override
  @JsonKey()
  final Category category;
  // Step 2: Contact & Address
  @override
  @JsonKey()
  final String mobileNumber;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey()
  final String city;
  @override
  @JsonKey()
  final String state;
  @override
  @JsonKey()
  final String pincode;
  @override
  @JsonKey()
  final String emergencyContactName;
  @override
  @JsonKey()
  final String emergencyContactNumber;
  // Step 3: Medical History
  final List<String> _allergies;
  // Step 3: Medical History
  @override
  @JsonKey()
  List<String> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  final List<String> _chronicIllnesses;
  @override
  @JsonKey()
  List<String> get chronicIllnesses {
    if (_chronicIllnesses is EqualUnmodifiableListView)
      return _chronicIllnesses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chronicIllnesses);
  }

  @override
  @JsonKey()
  final String smokingHabit;
  @override
  @JsonKey()
  final String alcoholHabit;
  @override
  @JsonKey()
  final String familyHistory;
  @override
  @JsonKey()
  final String vaccinationHistory;
  @override
  @JsonKey()
  final String currentMedications;
  @override
  @JsonKey()
  final String pastSurgeries;
  // Step 4: Visit Type
  @override
  @JsonKey()
  final String visitType;
  // OPD, IPD, Emergency
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
  final String bedNumber;
  @override
  @JsonKey()
  final String paymentMode;
  @override
  @JsonKey()
  final String registrationFee;
  @override
  @JsonKey()
  final String admissionReason;
  @override
  @JsonKey()
  final String primaryComplaint;
  @override
  @JsonKey()
  final String referredBy;
  // Meta
  @override
  @JsonKey()
  final int currentStep;
  @override
  @JsonKey()
  final bool isSubmitting;

  @override
  String toString() {
    return 'PatientRegistration(title: $title, fullName: $fullName, dateOfBirth: $dateOfBirth, age: $age, gender: $gender, bloodGroup: $bloodGroup, aadhaarNumber: $aadhaarNumber, ayushmanBharatId: $ayushmanBharatId, maritalStatus: $maritalStatus, religion: $religion, occupation: $occupation, category: $category, mobileNumber: $mobileNumber, email: $email, address: $address, city: $city, state: $state, pincode: $pincode, emergencyContactName: $emergencyContactName, emergencyContactNumber: $emergencyContactNumber, allergies: $allergies, chronicIllnesses: $chronicIllnesses, smokingHabit: $smokingHabit, alcoholHabit: $alcoholHabit, familyHistory: $familyHistory, vaccinationHistory: $vaccinationHistory, currentMedications: $currentMedications, pastSurgeries: $pastSurgeries, visitType: $visitType, department: $department, doctorName: $doctorName, appointmentDate: $appointmentDate, appointmentSlot: $appointmentSlot, bedNumber: $bedNumber, paymentMode: $paymentMode, registrationFee: $registrationFee, admissionReason: $admissionReason, primaryComplaint: $primaryComplaint, referredBy: $referredBy, currentStep: $currentStep, isSubmitting: $isSubmitting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientRegistrationImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.aadhaarNumber, aadhaarNumber) ||
                other.aadhaarNumber == aadhaarNumber) &&
            (identical(other.ayushmanBharatId, ayushmanBharatId) ||
                other.ayushmanBharatId == ayushmanBharatId) &&
            (identical(other.maritalStatus, maritalStatus) ||
                other.maritalStatus == maritalStatus) &&
            (identical(other.religion, religion) ||
                other.religion == religion) &&
            (identical(other.occupation, occupation) ||
                other.occupation == occupation) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.pincode, pincode) || other.pincode == pincode) &&
            (identical(other.emergencyContactName, emergencyContactName) ||
                other.emergencyContactName == emergencyContactName) &&
            (identical(other.emergencyContactNumber, emergencyContactNumber) ||
                other.emergencyContactNumber == emergencyContactNumber) &&
            const DeepCollectionEquality().equals(
              other._allergies,
              _allergies,
            ) &&
            const DeepCollectionEquality().equals(
              other._chronicIllnesses,
              _chronicIllnesses,
            ) &&
            (identical(other.smokingHabit, smokingHabit) ||
                other.smokingHabit == smokingHabit) &&
            (identical(other.alcoholHabit, alcoholHabit) ||
                other.alcoholHabit == alcoholHabit) &&
            (identical(other.familyHistory, familyHistory) ||
                other.familyHistory == familyHistory) &&
            (identical(other.vaccinationHistory, vaccinationHistory) ||
                other.vaccinationHistory == vaccinationHistory) &&
            (identical(other.currentMedications, currentMedications) ||
                other.currentMedications == currentMedications) &&
            (identical(other.pastSurgeries, pastSurgeries) ||
                other.pastSurgeries == pastSurgeries) &&
            (identical(other.visitType, visitType) ||
                other.visitType == visitType) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.doctorName, doctorName) ||
                other.doctorName == doctorName) &&
            (identical(other.appointmentDate, appointmentDate) ||
                other.appointmentDate == appointmentDate) &&
            (identical(other.appointmentSlot, appointmentSlot) ||
                other.appointmentSlot == appointmentSlot) &&
            (identical(other.bedNumber, bedNumber) ||
                other.bedNumber == bedNumber) &&
            (identical(other.paymentMode, paymentMode) ||
                other.paymentMode == paymentMode) &&
            (identical(other.registrationFee, registrationFee) ||
                other.registrationFee == registrationFee) &&
            (identical(other.admissionReason, admissionReason) ||
                other.admissionReason == admissionReason) &&
            (identical(other.primaryComplaint, primaryComplaint) ||
                other.primaryComplaint == primaryComplaint) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    title,
    fullName,
    dateOfBirth,
    age,
    gender,
    bloodGroup,
    aadhaarNumber,
    ayushmanBharatId,
    maritalStatus,
    religion,
    occupation,
    category,
    mobileNumber,
    email,
    address,
    city,
    state,
    pincode,
    emergencyContactName,
    emergencyContactNumber,
    const DeepCollectionEquality().hash(_allergies),
    const DeepCollectionEquality().hash(_chronicIllnesses),
    smokingHabit,
    alcoholHabit,
    familyHistory,
    vaccinationHistory,
    currentMedications,
    pastSurgeries,
    visitType,
    department,
    doctorName,
    appointmentDate,
    appointmentSlot,
    bedNumber,
    paymentMode,
    registrationFee,
    admissionReason,
    primaryComplaint,
    referredBy,
    currentStep,
    isSubmitting,
  ]);

  /// Create a copy of PatientRegistration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientRegistrationImplCopyWith<_$PatientRegistrationImpl> get copyWith =>
      __$$PatientRegistrationImplCopyWithImpl<_$PatientRegistrationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PatientRegistrationImplToJson(this);
  }
}

abstract class _PatientRegistration implements PatientRegistration {
  const factory _PatientRegistration({
    final PatientTitle title,
    final String fullName,
    final DateTime? dateOfBirth,
    final String age,
    final Gender gender,
    final BloodGroup bloodGroup,
    final String aadhaarNumber,
    final String ayushmanBharatId,
    final MaritalStatus maritalStatus,
    final Religion religion,
    final String occupation,
    final Category category,
    final String mobileNumber,
    final String email,
    final String address,
    final String city,
    final String state,
    final String pincode,
    final String emergencyContactName,
    final String emergencyContactNumber,
    final List<String> allergies,
    final List<String> chronicIllnesses,
    final String smokingHabit,
    final String alcoholHabit,
    final String familyHistory,
    final String vaccinationHistory,
    final String currentMedications,
    final String pastSurgeries,
    final String visitType,
    final String department,
    final String doctorName,
    final DateTime? appointmentDate,
    final String appointmentSlot,
    final String bedNumber,
    final String paymentMode,
    final String registrationFee,
    final String admissionReason,
    final String primaryComplaint,
    final String referredBy,
    final int currentStep,
    final bool isSubmitting,
  }) = _$PatientRegistrationImpl;

  factory _PatientRegistration.fromJson(Map<String, dynamic> json) =
      _$PatientRegistrationImpl.fromJson;

  // Step 1: Personal Info
  @override
  PatientTitle get title;
  @override
  String get fullName;
  @override
  DateTime? get dateOfBirth;
  @override
  String get age;
  @override
  Gender get gender;
  @override
  BloodGroup get bloodGroup;
  @override
  String get aadhaarNumber;
  @override
  String get ayushmanBharatId;
  @override
  MaritalStatus get maritalStatus;
  @override
  Religion get religion;
  @override
  String get occupation;
  @override
  Category get category; // Step 2: Contact & Address
  @override
  String get mobileNumber;
  @override
  String get email;
  @override
  String get address;
  @override
  String get city;
  @override
  String get state;
  @override
  String get pincode;
  @override
  String get emergencyContactName;
  @override
  String get emergencyContactNumber; // Step 3: Medical History
  @override
  List<String> get allergies;
  @override
  List<String> get chronicIllnesses;
  @override
  String get smokingHabit;
  @override
  String get alcoholHabit;
  @override
  String get familyHistory;
  @override
  String get vaccinationHistory;
  @override
  String get currentMedications;
  @override
  String get pastSurgeries; // Step 4: Visit Type
  @override
  String get visitType; // OPD, IPD, Emergency
  @override
  String get department;
  @override
  String get doctorName;
  @override
  DateTime? get appointmentDate;
  @override
  String get appointmentSlot;
  @override
  String get bedNumber;
  @override
  String get paymentMode;
  @override
  String get registrationFee;
  @override
  String get admissionReason;
  @override
  String get primaryComplaint;
  @override
  String get referredBy; // Meta
  @override
  int get currentStep;
  @override
  bool get isSubmitting;

  /// Create a copy of PatientRegistration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientRegistrationImplCopyWith<_$PatientRegistrationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
