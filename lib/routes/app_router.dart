import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/features/auth/view/login_screen.dart';
import 'package:paracareplus/features/dashboard/view/dashboard_screen.dart';
import 'package:paracareplus/features/opd/view/opd_token_screen.dart';
import 'package:paracareplus/features/patient/view/patient_registration_screen.dart';
import 'package:paracareplus/features/ipd/view/ipd_admission_screen.dart';
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
    ],
    // Redirect logic for Auth Guards will be added here
    redirect: (context, state) {
      // TODO(arch): Implement Auth Logic
      return null;
    },
  );
});
