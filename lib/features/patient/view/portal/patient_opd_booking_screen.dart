import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

// Modular components
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_kpi_row.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_tele_banner.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_queue_monitor.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_ai_suggestions.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_appointments_table.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_heatmaps.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/opd_gis_locator.dart';

// Wizard Steps
import 'package:paracareplus/features/patient/view/portal/widgets/opd/wizard/opd_step_specialty.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/wizard/opd_step_doctor.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/wizard/opd_step_date_slot.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/wizard/opd_step_details.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/wizard/opd_step_confirm.dart';

// Models and Providers
class Hospital {
  const Hospital(this.id, this.name, this.location, this.distanceKm);
  final String id;
  final String name;
  final String location;
  final double distanceKm;
}

class Doctor {
  const Doctor(
    this.name,
    this.specialty,
    this.degree,
    this.availability,
    this.queueInfo,
  );
  final String name;
  final String specialty;
  final String degree;
  final String availability;
  final String queueInfo;
}

final hospitals = [
  const Hospital('1', 'AIIMS Rishikesh', 'Virbhadra Road, Rishikesh', 1.8),
  const Hospital(
    '2',
    'Government Hospital Rishikesh',
    'Koyal Ghati, Rishikesh',
    3.2,
  ),
  const Hospital('3', 'Doon Medical College Hospital', 'Dehradun', 42.5),
];

final doctorsList = [
  const Doctor(
    'Dr. Satish Semwal',
    'General Medicine',
    'MBBS, MD',
    '9:00 AM - 1:00 PM',
    '4 in Queue (Wait: ~12m)',
  ),
  const Doctor(
    'Dr. Anjali Barthwal',
    'Pulmonology',
    'MD, FNB (Pulmonology)',
    '10:00 AM - 3:00 PM',
    '1 in Queue (Wait: ~5m)',
  ),
  const Doctor(
    'Dr. Pankaj Dobhal',
    'Cardiology',
    'MD, DM (Cardio)',
    '11:00 AM - 4:00 PM',
    '8 in Queue (Wait: ~45m)',
  ),
  const Doctor(
    'Dr. Meera Negi',
    'Pediatrics',
    'MBBS, DCH',
    '9:30 AM - 2:00 PM',
    '2 in Queue (Wait: ~8m)',
  ),
];

final selectedHospitalProvider = StateProvider<Hospital?>(
  (ref) => hospitals[0],
);
final selectedSpecialtyProvider = StateProvider<String>(
  (ref) => 'General Medicine',
);
final selectedDoctorProvider = StateProvider<Doctor?>((ref) => doctorsList[0]);
final selectedDateProvider = StateProvider<DateTime>(
  (ref) => DateTime(2026, 5, 20),
);
final selectedSlotProvider = StateProvider<String?>((ref) => null);

class PatientOpdBookingScreen extends ConsumerStatefulWidget {
  const PatientOpdBookingScreen({super.key});

  @override
  ConsumerState<PatientOpdBookingScreen> createState() =>
      _PatientOpdBookingScreenState();
}

class _PatientOpdBookingScreenState
    extends ConsumerState<PatientOpdBookingScreen> {
  int _currentStep = 0;
  bool _isBooking = false;
  String? _generatedToken;

  void _confirmBooking() {
    setState(() {
      _isBooking = true;
    });

    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isBooking = false;
          _generatedToken =
              'OPD-UTK-${10000 + (DateTime.now().millisecond % 90000)}';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(activeRouteName: RouteNames.patientOPD),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'Appointments & Smart OPD',
          style: AppTextStyles.titleSmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.primaryText,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Refreshing queue and live wait predictions...',
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. KPI row (status cards)
                const OpdKpiRow(),
                const SizedBox(height: AppSpacing.md),

                // 2. Telemedicine online banner
                const OpdTeleBanner(),
                const SizedBox(height: AppSpacing.md),

                // 3. Interactive step wizard card
                _buildBookingWizard(),
                const SizedBox(height: AppSpacing.lg),

                // 4. Live queue monitor & AI suggestions row/column
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 900;
                    if (isWide) {
                      return const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: OpdQueueMonitor()),
                          SizedBox(width: AppSpacing.md),
                          Expanded(child: OpdAiSuggestions()),
                        ],
                      );
                    } else {
                      return const Column(
                        children: [
                          OpdQueueMonitor(),
                          SizedBox(height: AppSpacing.md),
                          OpdAiSuggestions(),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: AppSpacing.lg),

                // 5. Historical / Recent appointments list table
                const OpdAppointmentsTable(),
                const SizedBox(height: AppSpacing.lg),

                // 6. Custom departmental heatmaps
                const OpdHeatmaps(),
                const SizedBox(height: AppSpacing.lg),

                // 7. Interactive GIS locations maps
                const OpdGisLocator(),
              ],
            ),
          ),
          if (_isBooking)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primaryLight,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Securing Appointment Slot...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Generating ABDM Token...',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBookingWizard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: AppColors.primaryLight,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Book New Appointment',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening ABHA Scan & Share QR...'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.border,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                icon: const Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.white,
                  size: 14,
                ),
                label: const Text(
                  'Scan & Share',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_generatedToken != null) ...[
            _buildSuccessTicket(),
          ] else ...[
            _buildStepProgress(),
            const SizedBox(height: 16),
            _buildActiveStepBody(),
          ],
        ],
      ),
    );
  }

  Widget _buildStepProgress() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isSmall = constraints.maxWidth < 450;
          return Row(
            children: [
              _buildStepIndicator(
                '1',
                isSmall ? 'Spec' : 'Specialty',
                _currentStep >= 0,
                _currentStep == 0,
              ),
              _buildStepDivider(_currentStep >= 1),
              _buildStepIndicator(
                '2',
                isSmall ? 'Doc' : 'Doctor',
                _currentStep >= 1,
                _currentStep == 1,
              ),
              _buildStepDivider(_currentStep >= 2),
              _buildStepIndicator(
                '3',
                isSmall ? 'Slot' : 'Date & Slot',
                _currentStep >= 2,
                _currentStep == 2,
              ),
              _buildStepDivider(_currentStep >= 3),
              _buildStepIndicator(
                '4',
                isSmall ? 'Detail' : 'Details',
                _currentStep >= 3,
                _currentStep == 3,
              ),
              _buildStepDivider(_currentStep >= 4),
              _buildStepIndicator(
                '5',
                isSmall ? 'Conf' : 'Confirm',
                _currentStep >= 4,
                _currentStep == 4,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStepIndicator(
    String number,
    String label,
    bool isDoneOrActive,
    bool isActive,
  ) {
    return Expanded(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.primary
                  : (isDoneOrActive ? AppColors.success : AppColors.border),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: isDoneOrActive && !isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 13)
                  : Text(
                      number,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 9.5,
              color: isActive
                  ? AppColors.primaryLight
                  : (isDoneOrActive
                        ? AppColors.primaryText
                        : AppColors.secondaryText),
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepDivider(bool isActive) {
    return Container(
      width: 14,
      height: 1.5,
      margin: const EdgeInsets.only(bottom: 15),
      color: isActive ? AppColors.success : AppColors.border,
    );
  }

  Widget _buildActiveStepBody() {
    switch (_currentStep) {
      case 0:
        return OpdStepSpecialty(onNext: () => setState(() => _currentStep = 1));
      case 1:
        return OpdStepDoctor(
          onBack: () => setState(() => _currentStep = 0),
          onNext: () => setState(() => _currentStep = 2),
        );
      case 2:
        return OpdStepDateSlot(
          onBack: () => setState(() => _currentStep = 1),
          onNext: () => setState(() => _currentStep = 3),
        );
      case 3:
        return OpdStepDetails(
          onBack: () => setState(() => _currentStep = 2),
          onNext: () => setState(() => _currentStep = 4),
        );
      case 4:
        return OpdStepConfirm(
          onBack: () => setState(() => _currentStep = 3),
          onConfirm: _confirmBooking,
        );
      default:
        return const SizedBox();
    }
  }

  Widget _buildSuccessTicket() {
    final hosp = ref.read(selectedHospitalProvider);
    final doc = ref.read(selectedDoctorProvider);
    final date = ref.read(selectedDateProvider);
    final slot = ref.read(selectedSlotProvider);
    final patientFor = ref.read(patientForProvider);
    final chiefComplaint = ref.read(chiefComplaintProvider);
    final visitType = ref.read(visitTypeProvider);
    final paymentScheme = ref.read(paymentSchemeProvider);

    final formatStrDate = '${date.day} May 2026';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.01),
        border: Border.all(color: AppColors.success.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.success,
            size: 48,
          ),
          const SizedBox(height: 12),
          const Text(
            'OPD SLOT REGISTERED SECURELY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'ABDM Token generated successfully',
            style: TextStyle(
              color: AppColors.success,
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          _buildReceiptRow('PATIENT', patientFor),
          _buildReceiptRow('ABHA ID', '43-8912-3456-7890'),
          _buildReceiptRow('HOSPITAL', hosp?.name ?? 'AIIMS Rishikesh'),
          _buildReceiptRow('DOCTOR', doc?.name ?? 'Dr. Anjali Sharma'),
          _buildReceiptRow('DEPARTMENT', doc?.specialty ?? 'Cardiology'),
          _buildReceiptRow('APPOINTMENT DATE', formatStrDate),
          _buildReceiptRow('TIME SLOT', slot ?? '10:30 AM'),
          _buildReceiptRow('VISIT TYPE', visitType),
          _buildReceiptRow('CHIEF SYMPTOMS', chiefComplaint),
          _buildReceiptRow('PAYMENT METHOD', paymentScheme),
          const SizedBox(height: 12),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                const Text(
                  'DIGITAL TOKEN NUMBER',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _generatedToken ?? '',
                  style: TextStyle(
                    color: AppColors.secondaryAccent,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Downloading PDF ticket...'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(
                    Icons.download_rounded,
                    color: AppColors.secondaryText,
                    size: 16,
                  ),
                  label: const Text(
                    'Get PDF',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _generatedToken = null;
                      _currentStep = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  icon: const Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  label: const Text(
                    'Book New',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 10,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
