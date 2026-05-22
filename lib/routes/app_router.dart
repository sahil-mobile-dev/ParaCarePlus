import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/features/auth/view/login_screen.dart';
import 'package:paracareplus/features/billing/view/billing_screen.dart';
import 'package:paracareplus/features/dashboard/view/dashboard_screen.dart';
import 'package:paracareplus/features/hr/view/hr_screen.dart';
import 'package:paracareplus/features/ipd/view/ipd_admission_screen.dart';
import 'package:paracareplus/features/laboratory/view/laboratory_screen.dart';
import 'package:paracareplus/features/opd/view/opd_token_screen.dart';
import 'package:paracareplus/features/patient/view/patient_registration_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_ai_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_chronic_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_emergency_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_emr_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_family_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_feedback_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_finance_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_health_analytics_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_home_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_lab_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_login_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_maps_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_mch_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_notifications_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_opd_booking_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_prescription_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_radiology_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_tele_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_vaccination_screen.dart';
import 'package:paracareplus/features/patient/view/portal/patient_wellness_screen.dart';
import 'package:paracareplus/features/pharmacy/view/pharmacy_screen.dart';
import 'package:paracareplus/features/radiology/view/radiology_screen.dart';
import 'package:paracareplus/features/tpa/view/tpa_screen.dart';
import 'package:paracareplus/routes/route_names.dart';
import 'package:paracareplus/routes/route_paths.dart';

final appRouterStateProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RoutePaths.login,
    routes: [
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.dashboard,
        name: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientRegistration,
        name: RouteNames.patientRegistration,
        builder: (context, state) => const PatientRegistrationScreen(),
      ),
      GoRoute(
        path: RoutePaths.opdToken,
        name: RouteNames.opdToken,
        builder: (context, state) => const OpdTokenScreen(),
      ),
      GoRoute(
        path: RoutePaths.ipdAdmission,
        name: RouteNames.ipdAdmission,
        builder: (context, state) => const IpdAdmissionScreen(),
      ),
      GoRoute(
        path: RoutePaths.billing,
        name: RouteNames.billing,
        builder: (context, state) => const BillingScreen(),
      ),
      GoRoute(
        path: RoutePaths.pharmacy,
        name: RouteNames.pharmacy,
        builder: (context, state) => const PharmacyScreen(),
      ),
      GoRoute(
        path: RoutePaths.laboratory,
        name: RouteNames.laboratory,
        builder: (context, state) => const LaboratoryScreen(),
      ),
      GoRoute(
        path: RoutePaths.radiology,
        name: RouteNames.radiology,
        builder: (context, state) => const RadiologyScreen(),
      ),
      GoRoute(
        path: RoutePaths.hr,
        name: RouteNames.hr,
        builder: (context, state) => const HrScreen(),
      ),
      GoRoute(
        path: RoutePaths.tpa,
        name: RouteNames.tpa,
        builder: (context, state) => const TpaScreen(),
      ),

      // Patient Portal (Phase C)
      GoRoute(
        path: RoutePaths.patientLogin,
        name: RouteNames.patientLogin,
        builder: (context, state) => const PatientLoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientHome,
        name: RouteNames.patientHome,
        builder: (context, state) => const PatientHomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientEMR,
        name: RouteNames.patientEMR,
        builder: (context, state) => const PatientEMRScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientAI,
        name: RouteNames.patientAI,
        builder: (context, state) => const PatientAiScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientOPD,
        name: RouteNames.patientOPD,
        builder: (context, state) => const PatientOpdBookingScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientEmergency,
        name: RouteNames.patientEmergency,
        builder: (context, state) => const PatientEmergencyScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientHealthAnalytics,
        name: RouteNames.patientHealthAnalytics,
        builder: (context, state) => const PatientHealthAnalyticsScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientLab,
        name: RouteNames.patientLab,
        builder: (context, state) => const PatientLabScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientRadiology,
        name: RouteNames.patientRadiology,
        builder: (context, state) => const PatientRadiologyScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientPrescription,
        name: RouteNames.patientPrescription,
        builder: (context, state) => const PatientPrescriptionScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientVaccination,
        name: RouteNames.patientVaccination,
        builder: (context, state) => const PatientVaccinationScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientChronic,
        name: RouteNames.patientChronic,
        builder: (context, state) => const PatientChronicScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientMch,
        name: RouteNames.patientMch,
        builder: (context, state) => const PatientMchScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientTele,
        name: RouteNames.patientTele,
        builder: (context, state) => const PatientTeleScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientFinance,
        name: RouteNames.patientFinance,
        builder: (context, state) => const PatientFinanceScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientWellness,
        name: RouteNames.patientWellness,
        builder: (context, state) => const PatientWellnessScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientFamily,
        name: RouteNames.patientFamily,
        builder: (context, state) => const PatientFamilyScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientNotifications,
        name: RouteNames.patientNotifications,
        builder: (context, state) => const PatientNotificationsScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientMaps,
        name: RouteNames.patientMaps,
        builder: (context, state) => const PatientMapsScreen(),
      ),
      GoRoute(
        path: RoutePaths.patientFeedback,
        name: RouteNames.patientFeedback,
        builder: (context, state) => const PatientFeedbackScreen(),
      ),
    ],
    // Redirect logic for Auth Guards will be added here
    redirect: (context, state) {
      // TODO(arch): Implement Auth Logic
      return null;
    },
  );
});
