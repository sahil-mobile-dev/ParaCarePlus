import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/features/billing/view/billing_screen.dart';
import 'package:paracareplus/features/doctor/model/doctor_sidebar_item.dart';
import 'package:paracareplus/features/doctor/view/tabs/blood_requests_tab.dart';
import 'package:paracareplus/features/doctor/view/tabs/doctor_console_tab.dart';
import 'package:paracareplus/features/doctor/view/widgets/doctor_header.dart';
import 'package:paracareplus/features/doctor/view/widgets/doctor_sidebar.dart';
import 'package:paracareplus/features/doctor/view_model/doctor_dashboard_view_model.dart';
import 'package:paracareplus/features/laboratory/view/laboratory_screen.dart';
import 'package:paracareplus/features/radiology/view/radiology_screen.dart';

class DoctorDashboardScreen extends ConsumerWidget {
  const DoctorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(doctorDashboardViewModelProvider);
    final isWideScreen = MediaQuery.of(context).size.width > 1200;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: DoctorHeader(
        alertCount: state.urgentAlerts.length,
        showMenuButton: !isWideScreen,
      ),
      drawer: isWideScreen ? null : const Drawer(child: DoctorSidebar()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sidebar - permanently visible on wide screens
            if (isWideScreen) const DoctorSidebar(),

            // Main Content Workspace
            Expanded(child: _buildSelectedTabContent(state.activeTab)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTabContent(DoctorTab tab) {
    switch (tab) {
      case DoctorTab.console:
        return const DoctorConsoleTab(
          viewMode: DoctorConsoleViewMode.fullConsole,
        );
      case DoctorTab.opdQueue:
        return const DoctorConsoleTab(
          viewMode: DoctorConsoleViewMode.opdQueue,
        );
      case DoctorTab.ipdRound:
        return const DoctorConsoleTab(
          viewMode: DoctorConsoleViewMode.ipdPatients,
        );
      case DoctorTab.ePrescriptions:
        return const DoctorConsoleTab(
          viewMode: DoctorConsoleViewMode.ePrescriptions,
        );
      case DoctorTab.clinicalNotes:
        return const DoctorConsoleTab(
          viewMode: DoctorConsoleViewMode.clinicalNotes,
        );
      case DoctorTab.labOrders:
        return const LaboratoryScreen();
      case DoctorTab.radiologyOrders:
        return const RadiologyScreen();
      case DoctorTab.bloodRequests:
        return const BloodRequestsTab();
      case DoctorTab.patientBills:
        return const BillingScreen(isDoctor: true);
    }
  }
}
