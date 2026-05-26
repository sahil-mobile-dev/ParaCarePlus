import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/doctor/model/doctor_sidebar_item.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';

enum DoctorConsoleViewMode {
  fullConsole,
  opdQueue,
  ipdPatients,
  ePrescriptions,
  clinicalNotes,
}

class DoctorConsoleTab extends ConsumerStatefulWidget {
  const DoctorConsoleTab({
    super.key,
    this.viewMode = DoctorConsoleViewMode.fullConsole,
  });

  final DoctorConsoleViewMode viewMode;

  @override
  ConsumerState<DoctorConsoleTab> createState() => _DoctorConsoleTabState();
}

class _DoctorConsoleTabState extends ConsumerState<DoctorConsoleTab> {
  late Timer _timer;
  String _timeString = '';
  int _activeOrderTab =
      0; // 0 = e-Prescriptions, 1 = Lab Orders, 2 = Radiology Orders, 3 = Clinical Notes

  // Clinical Alerts - Interactive dismissal
  final List<Map<String, String>> _alerts = [
    {
      'icon': '🔴',
      'msg': 'CRITICAL: Potassium 6.8 — Babita Devi (IPD)',
      'sub': 'Immediate action required',
      'time': '08:15 AM',
      'type': 'critical',
    },
    {
      'icon': '🟠',
      'msg': 'Dengue NS1 Positive — Kavita Rawat',
      'sub': 'Isolation ward recommended',
      'time': '09:00 AM',
      'type': 'warn',
    },
    {
      'icon': '🔵',
      'msg': 'INR >3.5 — Mohan Gupta',
      'sub': 'Warfarin dose review needed',
      'time': '07:45 AM',
      'type': 'info',
    },
    {
      'icon': '🟠',
      'msg': 'BP 200/120 — Ramesh Kumar (OPD)',
      'sub': 'STAT management initiated',
      'time': '09:10 AM',
      'type': 'warn',
    },
    {
      'icon': '🔵',
      'msg': 'HbA1c 10.2% — Follow-up needed — Suresh Rawat',
      'sub': 'Medication adjustment required',
      'time': 'Yesterday',
      'type': 'info',
    },
  ];

  // Clinical Notes Timeline - Interactive addition
  final List<Map<String, String>> _notes = [
    {
      'patient': 'Kavita Sharma',
      'type': 'Progress Note',
      'note':
          'BP controlled at 140/90. Continue current medications. Review in 2 days.',
      'time': 'Today 08:30 AM',
      'doctor': 'Dr. Negi',
    },
    {
      'patient': 'Babita Devi',
      'type': 'Nursing Note',
      'note':
          'Fever 103°F at 06:00. Tepid sponging done. Tab. Paracetamol given. Monitoring.',
      'time': 'Today 06:15 AM',
      'doctor': 'Nurse Rawat',
    },
    {
      'patient': 'Mohan Gupta',
      'type': 'Follow-up Note',
      'note':
          'HbA1c 7.8%. Increase Metformin to 1000mg BD. Dietary counselling advised.',
      'time': 'Yesterday 15:30 PM',
      'doctor': 'Dr. Negi',
    },
  ];

  // OPD Patients queue matching doctor.html
  final List<Map<String, String>> _opdQueue = [
    {
      'token': 'GM-001',
      'name': 'Ramesh Kumar Singh',
      'ageSex': '45/M',
      'complaint': 'Chest pain, breathlessness',
      'wait': '42 min',
      'priority': 'urgent',
    },
    {
      'token': 'GM-002',
      'name': 'Sunita Rawat',
      'ageSex': '32/F',
      'complaint': 'Fever, body ache 3 days',
      'wait': '35 min',
      'priority': 'normal',
    },
    {
      'token': 'GM-003',
      'name': 'Priya Negi',
      'ageSex': '24/F',
      'complaint': 'Headache, nausea',
      'wait': '28 min',
      'priority': 'normal',
    },
    {
      'token': 'GM-004',
      'name': 'Mohan Gupta',
      'ageSex': '58/M',
      'complaint': 'Diabetes follow-up',
      'wait': '20 min',
      'priority': 'normal',
    },
    {
      'token': 'GM-005',
      'name': 'Reema Bisht',
      'ageSex': '39/F',
      'complaint': 'Knee pain, swelling',
      'wait': '15 min',
      'priority': 'normal',
    },
  ];

  // IPD Patients ward admissions matching doctor.html
  final List<Map<String, dynamic>> _ipdQueue = [
    {
      'name': 'Kavita Sharma',
      'mrn': 'MRN-10026',
      'bed': 'Ward A-14',
      'diag': 'Hypertensive Crisis',
      'days': 3,
      'status': 'stable',
    },
    {
      'name': 'Mohan Lal Gupta',
      'mrn': 'MRN-10025',
      'bed': 'ICU Bed 3',
      'diag': 'Hemorrhagic Stroke',
      'days': 2,
      'status': 'critical',
    },
    {
      'name': 'Babita Devi',
      'mrn': 'MRN-10031',
      'bed': 'Ward A-08',
      'diag': 'Dengue Fever',
      'days': 5,
      'status': 'improving',
    },
    {
      'name': 'Rajveer Singh',
      'mrn': 'MRN-10033',
      'bed': 'Ward B-02',
      'diag': 'COPD Exacerbation',
      'days': 1,
      'status': 'stable',
    },
    {
      'name': 'Meena Bisht',
      'mrn': 'MRN-10037',
      'bed': 'Ward A-11',
      'diag': 'DM with Cellulitis',
      'days': 4,
      'status': 'stable',
    },
    {
      'name': 'Deepak Rawat',
      'mrn': 'MRN-10039',
      'bed': 'HDU Bed 1',
      'diag': 'Respiratory Failure',
      'days': 1,
      'status': 'critical',
    },
  ];

  // Prescriptions List
  final List<Map<String, String>> _rxList = [
    {
      'patient': 'Ramesh Kumar',
      'drug': 'Tab. Amlodipine 5mg',
      'dose': '1-0-0',
      'days': '30',
      'status': 'sent',
      'time': '09:15',
    },
    {
      'patient': 'Sunita Rawat',
      'drug': 'Tab. Paracetamol 500mg',
      'dose': '1-1-1',
      'days': '5',
      'status': 'sent',
      'time': '09:42',
    },
    {
      'patient': 'Kavita Sharma',
      'drug': 'Tab. Metformin 500mg',
      'dose': '1-0-1',
      'days': '30',
      'status': 'dispensed',
      'time': '08:30',
    },
    {
      'patient': 'Mohan Gupta',
      'drug': 'Inj. Insulin 8u',
      'dose': 'Before meals',
      'days': '7',
      'status': 'sent',
      'time': '10:05',
    },
  ];

  // Lab Orders List
  final List<Map<String, String>> _labOrders = [
    {
      'patient': 'Ramesh Kumar',
      'test': 'CBC + ESR',
      'status': 'sample_collected',
      'time': '09:20',
      'result': 'Pending',
    },
    {
      'patient': 'Kavita Sharma',
      'test': 'LFT + KFT',
      'status': 'processing',
      'time': '08:40',
      'result': 'In Process',
    },
    {
      'patient': 'Mohan Gupta',
      'test': 'HbA1c',
      'status': 'completed',
      'time': '07:30',
      'result': '7.8% — ⬆ High',
    },
    {
      'patient': 'Babita Devi',
      'test': 'Dengue Panel',
      'status': 'critical',
      'time': '08:15',
      'result': 'NS1 Positive ⚠',
    },
  ];

  // Radiology Orders List
  final List<Map<String, String>> _radOrders = [
    {
      'patient': 'Ramesh Kumar',
      'test': 'Chest X-Ray PA',
      'modality': 'X-Ray',
      'status': 'pending',
      'time': '09:30',
    },
    {
      'patient': 'Rajveer Singh',
      'test': 'HRCT Chest',
      'modality': 'CT Scan',
      'status': 'in_progress',
      'time': '10:00',
    },
    {
      'patient': 'Meena Bisht',
      'test': 'USG Lower Limb',
      'modality': 'Ultrasound',
      'status': 'reported',
      'time': '08:00',
    },
  ];

  // Schedule list
  final List<Map<String, String>> _schedule = [
    {
      'time': '09:00 AM',
      'type': 'OPD',
      'label': 'OPD Consulting — Room 2',
      'color': '0xFF1565C0',
    },
    {
      'time': '11:30 AM',
      'type': 'Round',
      'label': 'Ward Round — Medical Ward A',
      'color': '0xFF00897B',
    },
    {
      'time': '01:00 PM',
      'type': 'Op',
      'label': 'OT Assist — Theatre 1 (Dr. Bisht)',
      'color': '0xFF7B1FA2',
    },
    {
      'time': '03:00 PM',
      'type': 'CME',
      'label': 'CME: Diabetes Management Update',
      'color': '0xFFF57C00',
    },
    {
      'time': '04:00 PM',
      'type': 'OPD',
      'label': 'Afternoon OPD — Room 2',
      'color': '0xFF1565C0',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timeString = _formatDateTime(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (mounted) {
        setState(() {
          _timeString = _formatDateTime(DateTime.now());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDateTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final second = dt.second.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute:$second $ampm';
  }

  void _callNextPatient() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.volume_up_rounded, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Calling GM-001 — Ramesh Kumar Singh to Consultation Room 2',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.primaryLight,
      ),
    );
  }

  void _showNewConsultModal([String? initialPatientName]) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => DoctorConsultationDialog(
        patientName: initialPatientName ?? 'Ramesh Kumar Singh',
        onComplete: (msg) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: AppColors.success),
          );
        },
      ),
    );
  }

  void _showAddClinicalNoteDialog() {
    final patientController = TextEditingController();
    final noteController = TextEditingController();
    var noteType = 'Progress Note';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setStateBuilder) {
            return AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                side: const BorderSide(color: AppColors.border, width: 1.5),
              ),
              title: const Text(
                '📝 Add Clinical Note',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      dropdownColor: AppColors.surface,
                      initialValue: noteType,
                      style: const TextStyle(color: AppColors.primaryText),
                      decoration: const InputDecoration(
                        labelText: 'Note Type',
                        labelStyle: TextStyle(color: AppColors.secondaryText),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                      ),
                      items: ['Progress Note', 'Nursing Note', 'Follow-up Note']
                          .map(
                            (type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setStateBuilder(() {
                            noteType = val;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: patientController,
                      style: const TextStyle(color: AppColors.primaryText),
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',
                        labelStyle: TextStyle(color: AppColors.secondaryText),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: noteController,
                      style: const TextStyle(color: AppColors.primaryText),
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Clinical Note Details',
                        labelStyle: TextStyle(color: AppColors.secondaryText),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                    if (patientController.text.isNotEmpty &&
                        noteController.text.isNotEmpty) {
                      setState(() {
                        _notes.insert(0, {
                          'patient': patientController.text,
                          'type': noteType,
                          'note': noteController.text,
                          'time': 'Just Now',
                          'doctor': 'Dr. Negi',
                        });
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Clinical note added successfully.'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Save Note',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 950;

    switch (widget.viewMode) {
      case DoctorConsoleViewMode.fullConsole:
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWorkspaceHeader(),
                const SizedBox(height: 16),
                _buildStatsTelemetryGrid(),
                const SizedBox(height: 20),

                // Queue & IPD grid/row
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _buildOPDQueueCard()),
                      const SizedBox(width: 16),
                      Expanded(flex: 5, child: _buildIPDPatientsCard()),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildOPDQueueCard(),
                      const SizedBox(height: 16),
                      _buildIPDPatientsCard(),
                    ],
                  ),

                const SizedBox(height: 20),
                _buildOrdersAndPrescriptionsCard(),
                const SizedBox(height: 20),

                // Schedule & Alerts Row
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildTodayScheduleCard()),
                      const SizedBox(width: 16),
                      Expanded(child: _buildClinicalAlertsCard()),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildTodayScheduleCard(),
                      const SizedBox(height: 16),
                      _buildClinicalAlertsCard(),
                    ],
                  ),
              ],
            ),
          ),
        );

      case DoctorConsoleViewMode.opdQueue:
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _buildOPDQueueCard(),
          ),
        );

      case DoctorConsoleViewMode.ipdPatients:
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _buildIPDPatientsCard(),
          ),
        );

      case DoctorConsoleViewMode.ePrescriptions:
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _buildOrdersAndPrescriptionsCard(),
          ),
        );

      case DoctorConsoleViewMode.clinicalNotes:
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _buildClinicalAlertsCard(),
          ),
        );
    }
  }

  Widget _buildWorkspaceHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('🩺 ', style: TextStyle(fontSize: 20)),
                        Expanded(
                          child: Text(
                            'My Clinical Workspace',
                            style: AppTextStyles.titleMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.secondaryText,
                        ),
                        children: [
                          const TextSpan(text: 'Morning Shift — '),
                          TextSpan(
                            text: _timeString.isNotEmpty
                                ? _timeString
                                : 'Loading clock...',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryLight,
                            ),
                          ),
                          const TextSpan(
                            text: ' | Dr. Rajesh Negi | General Medicine',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutlinedButton.icon(
                onPressed: _showNewConsultModal,
                icon: const Icon(
                  Icons.add,
                  size: 16,
                  color: AppColors.primaryLight,
                ),
                label: const Text(
                  'Start Consultation',
                  style: TextStyle(fontSize: 12),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryLight,
                  side: const BorderSide(color: AppColors.primaryLight),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _showNewConsultModal('New Anonymous Patient'),
                icon: const Icon(
                  Icons.person_add_alt_1_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                label: const Text(
                  'New Patient',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsTelemetryGrid() {
    final stats = <(String, String, String, IconData, Color)>[
      (
        '14',
        'OPD Queue Today',
        '3 seen, 11 waiting',
        Icons.assignment_outlined,
        AppColors.primaryLight,
      ),
      ('6', 'My IPD Patients', '1 critical', Icons.hotel_outlined, Colors.teal),
      (
        '8',
        'Pending Lab Results',
        '3 urgent',
        Icons.science_outlined,
        Colors.orange,
      ),
      (
        '12',
        'Prescriptions Today',
        'All sent to pharmacy',
        Icons.medication_outlined,
        Colors.purple,
      ),
      (
        '4',
        'Discharge Pending',
        'Summaries needed',
        Icons.assignment_late_outlined,
        AppColors.error,
      ),
      (
        '18',
        'Completed Today',
        'Good progress',
        Icons.check_circle_outline_rounded,
        AppColors.success,
      ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200 ? 6 : (screenWidth > 800 ? 3 : 2);
    final childAspectRatio = screenWidth > 1200 ? 1.3 : 1.6;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: stats.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, i) {
        final item = stats[i];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border, width: 1.2),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: item.$5.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Icon(item.$4, color: item.$5, size: 20),
                  ),
                  const Spacer(),
                  Text(
                    item.$1,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.primaryText,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.$2,
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                item.$3,
                style: AppTextStyles.labelSmall.copyWith(
                  color: item.$5 == AppColors.primaryLight
                      ? AppColors.secondaryText
                      : item.$5,
                  fontSize: 10,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOPDQueueCard() {
    return Container(
      height: widget.viewMode == DoctorConsoleViewMode.fullConsole ? 400 : 700,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('📋 OPD Queue', style: AppTextStyles.titleSmall),
                  Text(
                    'Patients waiting for consultation',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange, width: 0.5),
                    ),
                    child: const Text(
                      '11 Waiting',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _callNextPatient,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    child: const Text(
                      '📣 Call Next',
                      style: TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 580,
                child: ListView.separated(
                  itemCount: _opdQueue.length,
                  separatorBuilder: (_, __) =>
                      const Divider(color: AppColors.border, height: 1),
                  itemBuilder: (context, idx) {
                    final p = _opdQueue[idx];
                    final isUrgent = p['priority'] == 'urgent';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  (isUrgent
                                          ? AppColors.error
                                          : AppColors.primaryLight)
                                      .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              p['token']!,
                              style: TextStyle(
                                color: isUrgent
                                    ? AppColors.error
                                    : AppColors.primaryLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p['name']!,
                                  style: const TextStyle(
                                    color: AppColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  p['complaint']!,
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              p['ageSex']!,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              p['wait']!,
                              style: TextStyle(
                                color: isUrgent
                                    ? AppColors.error
                                    : AppColors.secondaryText,
                                fontSize: 11,
                                fontWeight: isUrgent
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () =>
                                    _showNewConsultModal(p['name']),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryLight,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.sm,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  '🩺 See',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(
                                  Icons.assignment_outlined,
                                  size: 18,
                                  color: AppColors.secondaryText,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                tooltip: 'Patient History',
                                onPressed: () {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Opening Electronic Medical Record (EMR) for ${p['name']}',
                                      ),
                                      backgroundColor: AppColors.primary,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIPDPatientsCard() {
    return Container(
      height: widget.viewMode == DoctorConsoleViewMode.fullConsole ? 400 : 700,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🛏️ My IPD Patients',
                    style: AppTextStyles.titleSmall,
                  ),
                  Text(
                    'Current ward admissions under my care',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  ref
                      .read(doctorDashboardViewModelProvider.notifier)
                      .changeTab(DoctorTab.ipdRound);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondaryText,
                  side: const BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                child: const Text('View All', style: TextStyle(fontSize: 10)),
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: _ipdQueue.length,
              separatorBuilder: (_, __) =>
                  const Divider(color: AppColors.border, height: 1),
              itemBuilder: (context, idx) {
                final p = _ipdQueue[idx];
                final name = p['name'] as String;
                final mrn = p['mrn'] as String;
                final bed = p['bed'] as String;
                final diag = p['diag'] as String;
                final days = p['days'] as int;
                final status = p['status'] as String;

                final colors = {
                  'stable': Colors.green,
                  'critical': AppColors.error,
                  'improving': AppColors.primaryLight,
                };
                final stateColor = colors[status] ?? AppColors.secondaryText;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: stateColor.withValues(alpha: 0.15),
                        child: Text(
                          name.substring(0, 1),
                          style: TextStyle(
                            color: stateColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: name,
                                    style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.5,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' — $mrn',
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '$bed | $diag',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: stateColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: stateColor,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Day $days',
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Conducting Ward Round: Opening clinical charts for $name',
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                        ),
                        child: const Text(
                          'Round',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersAndPrescriptionsCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Row(
                  children: [
                    Text('📝 ', style: TextStyle(fontSize: 18)),
                    Expanded(
                      child: Text(
                        'Clinical Orders & Prescriptions',
                        style: AppTextStyles.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Opening clinical order entry portal...'),
                      backgroundColor: AppColors.primaryLight,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
                child: const Text(
                  '+ New Order',
                  style: TextStyle(fontSize: 11, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Custom tab headers
          Container(
            height: 38,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabBtn(0, '💊 e-Prescriptions', '12'),
                  _buildTabBtn(1, '🧪 Lab Orders', '8'),
                  _buildTabBtn(2, '🩻 Radiology Orders', '3'),
                  _buildTabBtn(3, '📝 Clinical Notes', ''),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Render active pane
          IndexedStack(
            index: _activeOrderTab,
            children: [
              _buildEPrescriptionsPane(),
              _buildLabOrdersPane(),
              _buildRadiologyOrdersPane(),
              _buildClinicalNotesPane(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBtn(int tabIndex, String label, String badgeVal) {
    final isActive = _activeOrderTab == tabIndex;
    return InkWell(
      onTap: () {
        setState(() {
          _activeOrderTab = tabIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? AppColors.primaryLight : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? AppColors.primaryText
                    : AppColors.secondaryText,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
            if (badgeVal.isNotEmpty) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border, width: 0.5),
                ),
                child: Text(
                  badgeVal,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEPrescriptionsPane() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 720,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(3.5),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(1.2),
            4: FlexColumnWidth(1.5),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(1.5),
          },
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.border, width: 0.5),
          ),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: AppColors.surface),
              children:
                  [
                    'Patient',
                    'Drug',
                    'Dose/Freq',
                    'Days',
                    'Status',
                    'Time',
                    'Action',
                  ].map((h) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Text(
                        h,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            ..._rxList.map((r) {
              final isDispensed = r['status'] == 'dispensed';
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      r['patient']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      r['drug']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      r['dose']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      r['days']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            (isDispensed
                                    ? AppColors.success
                                    : AppColors.primaryLight)
                                .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        r['status']!.toUpperCase(),
                        style: TextStyle(
                          color: isDispensed
                              ? AppColors.success
                              : AppColors.primaryLight,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      r['time']!,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Viewing Prescription details for ${r['patient']}',
                            ),
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildLabOrdersPane() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 720,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(2.2),
            3: FlexColumnWidth(2.5),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.5),
          },
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.border, width: 0.5),
          ),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: AppColors.surface),
              children:
                  ['Patient', 'Test', 'Status', 'Result', 'Time', 'Action'].map(
                    (h) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Text(
                          h,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ).toList(),
            ),
            ..._labOrders.map((o) {
              final isCritical = o['status'] == 'critical';
              final isCompleted = o['status'] == 'completed';
              final badgeColor = isCritical
                  ? AppColors.error
                  : (isCompleted ? AppColors.success : Colors.orange);

              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['patient']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['test']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        o['status']!.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['result']!,
                      style: TextStyle(
                        color: isCritical
                            ? AppColors.error
                            : AppColors.primaryText,
                        fontWeight: isCritical
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['time']!,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(doctorDashboardViewModelProvider.notifier)
                            .changeTab(DoctorTab.labOrders);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildRadiologyOrdersPane() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 720,
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(2),
            3: FlexColumnWidth(2),
            4: FlexColumnWidth(1.2),
            5: FlexColumnWidth(1.5),
          },
          border: const TableBorder(
            horizontalInside: BorderSide(color: AppColors.border, width: 0.5),
          ),
          children: [
            TableRow(
              decoration: const BoxDecoration(color: AppColors.surface),
              children:
                  [
                    'Patient',
                    'Test',
                    'Modality',
                    'Status',
                    'Time',
                    'Action',
                  ].map((h) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 10,
                      ),
                      child: Text(
                        h,
                        style: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            ..._radOrders.map((o) {
              final isReported = o['status'] == 'reported';
              final isInProgress = o['status'] == 'in_progress';
              final badgeColor = isReported
                  ? AppColors.success
                  : (isInProgress ? Colors.orange : AppColors.secondaryText);

              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['patient']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['test']!,
                      style: const TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.indigo, width: 0.5),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        o['modality']!,
                        style: const TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        o['status']!.replaceAll('_', ' ').toUpperCase(),
                        style: TextStyle(
                          color: badgeColor,
                          fontSize: 8.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    child: Text(
                      o['time']!,
                      style: const TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(doctorDashboardViewModelProvider.notifier)
                            .changeTab(DoctorTab.radiologyOrders);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                      ),
                      child: const Text(
                        'View',
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildClinicalNotesPane() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _notes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, idx) {
            final n = _notes[idx];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.border, width: 0.8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 2),
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              n['patient']!,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                n['type']!,
                                style: const TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${n['time']} — ${n['doctor']}',
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          n['note']!,
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: _showAddClinicalNoteDialog,
          icon: const Icon(Icons.add, size: 16, color: Colors.white),
          label: const Text(
            'Add Clinical Note',
            style: TextStyle(fontSize: 11, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayScheduleCard() {
    return Container(
      height: 380,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('📅 ', style: TextStyle(fontSize: 18)),
              Text("Today's Schedule", style: AppTextStyles.titleSmall),
            ],
          ),
          const Divider(color: AppColors.border, height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: _schedule.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, idx) {
                final s = _schedule[idx];
                final hexColor = int.parse(s['color']!);
                final categoryColor = Color(hexColor);

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(color: AppColors.border, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: categoryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: categoryColor, width: 0.5),
                        ),
                        child: Text(
                          s['time']!,
                          style: TextStyle(
                            color: categoryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              s['label']!,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              s['type']!,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalAlertsCard() {
    return Container(
      height: widget.viewMode == DoctorConsoleViewMode.fullConsole ? 380 : 700,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('🚨 ', style: TextStyle(fontSize: 18)),
                  Text('Clinical Alerts', style: AppTextStyles.titleSmall),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${_alerts.length} Active',
                  style: const TextStyle(
                    color: AppColors.error,
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.border, height: 20),
          Expanded(
            child: _alerts.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 40,
                          color: AppColors.success,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'No Clinical Alerts',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: _alerts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, idx) {
                      final a = _alerts[idx];
                      final type = a['type']!;
                      final alertColor = type == 'critical'
                          ? AppColors.error
                          : (type == 'warn'
                                ? Colors.orange
                                : AppColors.primaryLight);

                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: alertColor.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          border: Border(
                            left: BorderSide(color: alertColor, width: 3.5),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a['icon']!,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    a['msg']!,
                                    style: const TextStyle(
                                      color: AppColors.primaryText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    a['sub']!,
                                    style: const TextStyle(
                                      color: AppColors.secondaryText,
                                      fontSize: 10.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  a['time']!,
                                  style: const TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 9.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _alerts.removeAt(idx);
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    child: Text(
                                      'Dismiss',
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 9,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ─── Complete Consultation / SOAP Dialog ───
class DoctorConsultationDialog extends StatefulWidget {
  const DoctorConsultationDialog({
    required this.patientName,
    required void Function(String message) onComplete,
    super.key,
  }) : _onComplete = onComplete;

  final String patientName;
  final void Function(String message) _onComplete;

  @override
  State<DoctorConsultationDialog> createState() =>
      _DoctorConsultationDialogState();
}

class _DoctorConsultationDialogState extends State<DoctorConsultationDialog> {
  // Input fields controllers
  final _subjectiveController = TextEditingController();
  final _objectiveController = TextEditingController();
  final _assessmentController = TextEditingController();
  final _planController = TextEditingController();

  final _vBPController = TextEditingController(text: '120/80');
  final _vPulseController = TextEditingController(text: '72');
  final _vTempController = TextEditingController(text: '98.6');
  final _vSPO2Controller = TextEditingController(text: '99');
  final _vRRController = TextEditingController(text: '16');
  final _vWtController = TextEditingController(text: '65');

  final _rxInstructionsController = TextEditingController();

  // Dynamic e-Prescription rows
  final List<Map<String, String>> _consultRxBuilder = [];

  // Dynamic Lab Tests ordered list
  final List<String> _consultLabBuilder = [];

  // Suggestion sets
  final List<String> _diagnosisSuggestions = [
    'J45 — Asthma',
    'I10 — Essential Hypertension',
    'E11 — Type 2 Diabetes',
    'J06 — URTI',
    'K29 — Gastritis',
  ];
  final Set<String> _selectedDiagnosisBadges = {};

  final List<String> _availableDrugs = [
    'Tab. Paracetamol 500mg',
    'Tab. Metformin 500mg',
    'Tab. Amlodipine 5mg',
    'Inj. Ceftriaxone 1g',
    'Syr. Amoxicillin 125mg/5ml',
  ];

  final List<String> _availableLabTests = [
    'CBC',
    'LFT',
    'KFT',
    'Blood Glucose (F)',
    'HbA1c',
    'Dengue Panel',
  ];

  String _disposition = 'Discharge — OPD';
  String _followUpDate = '';

  @override
  void dispose() {
    _subjectiveController.dispose();
    _objectiveController.dispose();
    _assessmentController.dispose();
    _planController.dispose();
    _vBPController.dispose();
    _vPulseController.dispose();
    _vTempController.dispose();
    _vSPO2Controller.dispose();
    _vRRController.dispose();
    _vWtController.dispose();
    _rxInstructionsController.dispose();
    super.dispose();
  }

  void _addDrugRow() {
    setState(() {
      final defaultDrug =
          _availableDrugs[_consultRxBuilder.length % _availableDrugs.length];
      _consultRxBuilder.add({
        'drug': defaultDrug,
        'dose': '1 tab',
        'freq': '1-0-1',
        'days': '5',
        'route': 'Oral',
      });
    });
  }

  void _addLabTest(String test) {
    if (!_consultLabBuilder.contains(test)) {
      setState(() {
        _consultLabBuilder.add(test);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 900;

    return Dialog(
      backgroundColor: AppColors.background,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.border, width: 1.5),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text('🩺 ', style: TextStyle(fontSize: 22)),
                      Text(
                        'New Consultation — OPD Visit',
                        style: AppTextStyles.titleMedium,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.secondaryText,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Patient chip matching HTML
              _buildPatientChip(),
              const SizedBox(height: 12),

              // Body
              Expanded(
                child: SingleChildScrollView(
                  child: isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildLeftSOAPPanel()),
                            const SizedBox(width: 16),
                            Expanded(child: _buildRightOrdersPanel()),
                          ],
                        )
                      : Column(
                          children: [
                            _buildLeftSOAPPanel(),
                            const SizedBox(height: 16),
                            _buildRightOrdersPanel(),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: 12),

              // Footer actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.secondaryText),
                    ),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget._onComplete(
                        'Draft Saved: Consultation notes saved as draft.',
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryLight,
                      side: const BorderSide(color: AppColors.primaryLight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    child: const Text('💾 Save Draft'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget._onComplete(
                        'Consultation Complete: Prescription sent to pharmacy. Lab orders raised.',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    child: const Text(
                      '✅ Complete & Print',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primaryLight.withValues(alpha: 0.15),
            child: const Text(
              'R',
              style: TextStyle(
                color: AppColors.primaryLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.patientName,
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.5,
                        ),
                      ),
                      const TextSpan(
                        text: '  MRN-10021',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  '45 Yrs / Male | B+ | Token: GM-001 | Gen. Medicine OPD',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              '🔴 Urgent',
              style: TextStyle(
                color: AppColors.error,
                fontSize: 9.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftSOAPPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SOAP Notes card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('📋 ', style: TextStyle(fontSize: 16)),
                  Text('SOAP Notes', style: AppTextStyles.labelLarge),
                ],
              ),
              const Divider(color: AppColors.border, height: 16),

              _buildClinicalField(
                'Subjective — Chief Complaint',
                _subjectiveController,
                "Patient's main complaint in their own words…",
              ),
              const SizedBox(height: 12),
              _buildClinicalField(
                'Objective — Examination Findings',
                _objectiveController,
                'BP, HR, Temp, O2 Sat, examination findings…',
              ),
              const SizedBox(height: 12),

              // Assessment with suggestions
              const Text(
                'Assessment — Diagnosis',
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: _assessmentController,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 12.5,
                  ),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.secondaryText,
                      size: 18,
                    ),
                    hintText: 'Search ICD-10 diagnosis…',
                    hintStyle: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 11.5,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 5,
                runSpacing: 5,
                children: _diagnosisSuggestions.map((diag) {
                  final isSelected = _selectedDiagnosisBadges.contains(diag);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedDiagnosisBadges.remove(diag);
                          final currentText = _assessmentController.text;
                          _assessmentController.text = currentText
                              .replaceAll(diag, '')
                              .trim();
                        } else {
                          _selectedDiagnosisBadges.add(diag);
                          if (_assessmentController.text.isEmpty) {
                            _assessmentController.text = diag;
                          } else {
                            _assessmentController.text += ', $diag';
                          }
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryLight
                              : AppColors.border,
                        ),
                      ),
                      child: Text(
                        diag,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.secondaryText,
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              _buildClinicalField(
                'Plan — Treatment Plan',
                _planController,
                'Treatment plan, follow-up instructions, referrals…',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Vitals card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('❤️ ', style: TextStyle(fontSize: 16)),
                  Text('Vitals', style: AppTextStyles.labelLarge),
                ],
              ),
              const Divider(color: AppColors.border, height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final gridCols = constraints.maxWidth > 400 ? 3 : 2;
                  return GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: gridCols,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 1.8,
                    ),
                    children: [
                      _buildVitalInput('BP (mmHg)', _vBPController, '120/80'),
                      _buildVitalInput('Pulse (/min)', _vPulseController, '72'),
                      _buildVitalInput('Temp (°F)', _vTempController, '98.6'),
                      _buildVitalInput('SpO2 (%)', _vSPO2Controller, '99'),
                      _buildVitalInput('RR (/min)', _vRRController, '16'),
                      _buildVitalInput('Weight (kg)', _vWtController, '65'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClinicalField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.primaryText,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(
              color: AppColors.primaryText,
              fontSize: 12.5,
            ),
            maxLines: 2,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 11.5,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVitalInput(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.background.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.border),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightOrdersPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // e-Prescription Drug builder
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text('💊 ', style: TextStyle(fontSize: 16)),
                      Text('e-Prescription', style: AppTextStyles.labelLarge),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _addDrugRow,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                    ),
                    child: const Text(
                      '+ Add Drug',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.border, height: 16),
              if (_consultRxBuilder.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'No drugs added yet',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              else
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    columnWidths: const {
                      0: FixedColumnWidth(130),
                      1: FixedColumnWidth(60),
                      2: FixedColumnWidth(80),
                      3: FixedColumnWidth(55),
                      4: FixedColumnWidth(75),
                      5: FixedColumnWidth(40),
                    },
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: AppColors.border,
                        width: 0.5,
                      ),
                    ),
                    children: _consultRxBuilder.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final row = entry.value;
                      return TableRow(
                        children: [
                          // Drug
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TextField(
                              controller:
                                  TextEditingController(text: row['drug'])
                                    ..selection = TextSelection.fromPosition(
                                      TextPosition(offset: row['drug']!.length),
                                    ),
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(6),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) =>
                                  _consultRxBuilder[idx]['drug'] = val,
                            ),
                          ),
                          // Dose
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 2,
                            ),
                            child: TextField(
                              controller: TextEditingController(
                                text: row['dose'],
                              ),
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(6),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) =>
                                  _consultRxBuilder[idx]['dose'] = val,
                            ),
                          ),
                          // Freq Dropdown
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 2,
                            ),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: AppColors.surface,
                              initialValue: row['freq'],
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 6,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              items: ['1-0-0', '1-1-1', '0-0-1', '1-0-1']
                                  .map(
                                    (f) => DropdownMenuItem(
                                      value: f,
                                      child: Text(f),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _consultRxBuilder[idx]['freq'] = val;
                                  });
                                }
                              },
                            ),
                          ),
                          // Days
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 2,
                            ),
                            child: TextField(
                              controller: TextEditingController(
                                text: row['days'],
                              ),
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(6),
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) =>
                                  _consultRxBuilder[idx]['days'] = val,
                            ),
                          ),
                          // Route Dropdown
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 2,
                            ),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: AppColors.surface,
                              initialValue: row['route'],
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 6,
                                ),
                                border: OutlineInputBorder(),
                              ),
                              items: ['Oral', 'IV', 'IM', 'Topical']
                                  .map(
                                    (r) => DropdownMenuItem(
                                      value: r,
                                      child: Text(r),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _consultRxBuilder[idx]['route'] = val;
                                  });
                                }
                              },
                            ),
                          ),
                          // Action delete
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.error,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _consultRxBuilder.removeAt(idx);
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Lab Tests test-selector card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text('🧪 ', style: TextStyle(fontSize: 16)),
                      Text('Lab Tests', style: AppTextStyles.labelLarge),
                    ],
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.add,
                      size: 20,
                      color: AppColors.primaryLight,
                    ),
                    color: AppColors.surface,
                    onSelected: _addLabTest,
                    itemBuilder: (context) {
                      return _availableLabTests
                          .map(
                            (test) => PopupMenuItem(
                              value: test,
                              child: Text(
                                test,
                                style: const TextStyle(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              ),
              const Divider(color: AppColors.border, height: 16),
              if (_consultLabBuilder.isEmpty)
                const Text(
                  'No tests added',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                )
              else
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: _consultLabBuilder.map((test) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 0.5,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '🧪 $test',
                            style: const TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _consultLabBuilder.remove(test);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              size: 12,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Advice & Follow-up card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('📋 ', style: TextStyle(fontSize: 16)),
                  Text('Advice & Follow-up', style: AppTextStyles.labelLarge),
                ],
              ),
              const Divider(color: AppColors.border, height: 16),

              _buildClinicalField(
                'Patient Instructions',
                _rxInstructionsController,
                'Diet, rest, restrictions…',
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Follow-up Date',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now().add(
                                const Duration(days: 7),
                              ),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (picked != null) {
                              setState(() {
                                _followUpDate =
                                    "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.background.withValues(
                                alpha: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 14,
                                  color: AppColors.secondaryText,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _followUpDate.isEmpty
                                      ? 'Select date'
                                      : _followUpDate,
                                  style: TextStyle(
                                    color: _followUpDate.isEmpty
                                        ? AppColors.secondaryText
                                        : AppColors.primaryText,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Disposition',
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          dropdownColor: AppColors.surface,
                          initialValue: _disposition,
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 12,
                          ),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          items:
                              [
                                    'Discharge — OPD',
                                    'Admit to IPD',
                                    'Refer to Specialist',
                                    'Emergency Referral',
                                  ]
                                  .map(
                                    (disp) => DropdownMenuItem(
                                      value: disp,
                                      child: Text(disp),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _disposition = val;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
