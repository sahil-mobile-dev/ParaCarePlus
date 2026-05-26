import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:paracareplus/features/doctor/model/doctor_sidebar_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'doctor_dashboard_view_model.freezed.dart';
part 'doctor_dashboard_view_model.g.dart';

@freezed
class OpdPatient with _$OpdPatient {
  const factory OpdPatient({
    required String token,
    required String name,
    required int age,
    required String gender,
    required String symptom,
    required String urgency,
    required String status, // 'Waiting', 'Consulting', 'Completed'
  }) = _OpdPatient;
}

@freezed
class IpdPatient with _$IpdPatient {
  const factory IpdPatient({
    required String bed,
    required String name,
    required int age,
    required String gender,
    required String diagnosis,
    required int systolicBP,
    required int diastolicBP,
    required int pulse,
    required String vitalsStatus, // 'Stable', 'Warning', 'Critical'
    required String roundStatus, // 'Pending', 'Done'
    required String clinicalNotes,
  }) = _IpdPatient;
}

@freezed
class LabReport with _$LabReport {
  const factory LabReport({
    required String id,
    required String patientName,
    required String testName,
    required String orderedDate,
    required String resultSummary,
    required bool isUrgent,
    required String status, // 'Pending Review', 'Approved'
  }) = _LabReport;
}

@freezed
class DoctorDashboardState with _$DoctorDashboardState {
  const factory DoctorDashboardState({
    @Default(DoctorTab.console) DoctorTab activeTab,
    @Default(12) int completedOpdCount,
    @Default(8) int activeIpdCount,
    @Default(5) int pendingLabCount,
    @Default([]) List<OpdPatient> opdPatients,
    @Default([]) List<IpdPatient> ipdPatients,
    @Default([]) List<LabReport> labReports,
    @Default([]) List<String> urgentAlerts,
    @Default(null) OpdPatient? consultingPatient,
    @Default(null) LabReport? selectedReportToReview,
  }) = _DoctorDashboardState;
}

@riverpod
class DoctorDashboardViewModel extends _$DoctorDashboardViewModel {
  @override
  DoctorDashboardState build() {
    return const DoctorDashboardState(
      completedOpdCount: 8,
      activeIpdCount: 6,
      pendingLabCount: 4,
      urgentAlerts: [
        '🚨 EMERGENCY ALERT: Bed 102-B (Amit Bisht) reports Pulse rate spike (112 bpm). Please review.',
        '⚠️ LAB URGENT: Lipid Profile for Sunita Devi is ready and shows critically high LDL (180 mg/dL).',
        '💡 ROSTER INFO: You are scheduled for Surgery Slot B tomorrow from 09:00 AM to 11:30 AM.',
      ],
      opdPatients: [
        OpdPatient(
          token: 'OPD-041',
          name: 'Karan Singh',
          age: 42,
          gender: 'Male',
          symptom: 'Substernal tightness & mild dyspnea',
          urgency: 'High',
          status: 'Waiting',
        ),
        OpdPatient(
          token: 'OPD-042',
          name: 'Sunita Devi',
          age: 58,
          gender: 'Female',
          symptom: 'Routine checkup, lipid report review',
          urgency: 'Routine',
          status: 'Waiting',
        ),
        OpdPatient(
          token: 'OPD-045',
          name: 'Rajesh Negi',
          age: 35,
          gender: 'Male',
          symptom: 'Atypical chest wall pain, post-treadmill',
          urgency: 'Routine',
          status: 'Waiting',
        ),
        OpdPatient(
          token: 'OPD-047',
          name: 'Priyanka Semwal',
          age: 29,
          gender: 'Female',
          symptom: 'Palpitations & mild anxiety',
          urgency: 'Routine',
          status: 'Waiting',
        ),
      ],
      ipdPatients: [
        IpdPatient(
          bed: 'Cardiology Ward - Bed 102',
          name: 'Sanjay Rawat',
          age: 55,
          gender: 'Male',
          diagnosis: 'Post Myocardial Infarction',
          systolicBP: 118,
          diastolicBP: 78,
          pulse: 72,
          vitalsStatus: 'Stable',
          roundStatus: 'Pending',
          clinicalNotes: 'Recovering well. Retain aspirin and statin. Check ECG in evening.',
        ),
        IpdPatient(
          bed: 'CCU - Bed 102-B',
          name: 'Amit Bisht',
          age: 63,
          gender: 'Male',
          diagnosis: 'Acute Coronary Syndrome',
          systolicBP: 138,
          diastolicBP: 88,
          pulse: 112,
          vitalsStatus: 'Critical',
          roundStatus: 'Pending',
          clinicalNotes: 'Pulse unstable (Tachycardia). Restrict physical motion. Check cardiac enzymes.',
        ),
        IpdPatient(
          bed: 'Cardiology Ward - Bed 204',
          name: 'Anita Dhyani',
          age: 48,
          gender: 'Female',
          diagnosis: 'Mitral Valve Regurgitation',
          systolicBP: 124,
          diastolicBP: 80,
          pulse: 82,
          vitalsStatus: 'Stable',
          roundStatus: 'Done',
          clinicalNotes: 'Vitals stable. Medication adjusted. Scheduled for echo next Monday.',
        ),
        IpdPatient(
          bed: 'Stepdown ICU - Bed 105',
          name: 'Mohammad Yusuf',
          age: 70,
          gender: 'Male',
          diagnosis: 'Congestive Heart Failure',
          systolicBP: 130,
          diastolicBP: 74,
          pulse: 68,
          vitalsStatus: 'Warning',
          roundStatus: 'Done',
          clinicalNotes: 'Mild peripheral oedema. Increase frusemide dosage slightly.',
        ),
      ],
      labReports: [
        LabReport(
          id: 'LAB-9804',
          patientName: 'Sunita Devi',
          testName: 'Lipid Profile + Serum Creatinine',
          orderedDate: 'Today, 08:30 AM',
          resultSummary: 'Total Cholesterol: 260 mg/dL (High), LDL: 180 mg/dL (Urgent High), Serum Creatinine: 1.1 mg/dL (Normal)',
          isUrgent: true,
          status: 'Pending Review',
        ),
        LabReport(
          id: 'RAD-4012',
          patientName: 'Sanjay Rawat',
          testName: 'Chest X-Ray (AP View)',
          orderedDate: 'Yesterday, 04:15 PM',
          resultSummary: 'Mild cardiomegaly observed. Pulmonary vascularity is normal. No active consolidation.',
          isUrgent: false,
          status: 'Pending Review',
        ),
        LabReport(
          id: 'LAB-9855',
          patientName: 'Amit Bisht',
          testName: 'Cardiac Enzymes (Troponin-I)',
          orderedDate: 'Today, 10:10 AM',
          resultSummary: 'Troponin-I: 0.18 ng/mL (Elevated). Suggests myocardial injury. Urgent clinical assessment required.',
          isUrgent: true,
          status: 'Pending Review',
        ),
        LabReport(
          id: 'RAD-4029',
          patientName: 'Anita Dhyani',
          testName: 'Echocardiogram (Transthoracic)',
          orderedDate: 'Yesterday, 11:30 AM',
          resultSummary: 'EF: 52% (Mildly Reduced). Moderate Mitral Regurgitation. Normal LV/RV dimensions.',
          isUrgent: false,
          status: 'Pending Review',
        ),
      ],
    );
  }

  void changeTab(DoctorTab tab) {
    state = state.copyWith(activeTab: tab);
  }

  void startConsultation(OpdPatient patient) {
    final updatedList = state.opdPatients.map((p) {
      if (p.token == patient.token) {
        return p.copyWith(status: 'Consulting');
      }
      return p;
    }).toList();
    state = state.copyWith(
      opdPatients: updatedList,
      consultingPatient: patient.copyWith(status: 'Consulting'),
    );
  }

  void completeConsultation(String token) {
    final updatedList = state.opdPatients.map((p) {
      if (p.token == token) {
        return p.copyWith(status: 'Completed');
      }
      return p;
    }).toList();
    state = state.copyWith(
      opdPatients: updatedList,
      consultingPatient: null,
      completedOpdCount: state.completedOpdCount + 1,
    );
  }

  void updateClinicalNotes(String bed, String notes) {
    final updatedList = state.ipdPatients.map((p) {
      if (p.bed == bed) {
        return p.copyWith(clinicalNotes: notes, roundStatus: 'Done');
      }
      return p;
    }).toList();
    state = state.copyWith(ipdPatients: updatedList);
  }

  void selectReportToReview(LabReport? report) {
    state = state.copyWith(selectedReportToReview: report);
  }

  void approveReport(String id) {
    final updatedList = state.labReports.map((r) {
      if (r.id == id) {
        return r.copyWith(status: 'Approved');
      }
      return r;
    }).toList();

    final remainingPending = updatedList.where((r) => r.status == 'Pending Review').length;

    state = state.copyWith(
      labReports: updatedList,
      selectedReportToReview: null,
      pendingLabCount: remainingPending,
    );
  }

  void dismissAlert(int index) {
    final list = List<String>.from(state.urgentAlerts);
    if (index >= 0 && index < list.length) {
      list.removeAt(index);
    }
    state = state.copyWith(urgentAlerts: list);
  }
}
