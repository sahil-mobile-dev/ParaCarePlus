import 'package:flutter/material.dart';

enum DoctorTab {
  console('Console', Icons.dashboard_outlined),
  opdQueue('OPD Queue', Icons.assignment_ind_outlined),
  ipdRound('IPD Rounds', Icons.hotel_outlined),
  labOrders('Lab Orders / Results', Icons.science_outlined),
  radiologyOrders('Radiology Orders', Icons.settings_remote_outlined),
  bloodRequests('Blood Requests', Icons.bloodtype_outlined),
  patientBills('Patient Bills', Icons.credit_card_outlined);

  const DoctorTab(this.label, this.icon);

  final String label;
  final IconData icon;
}

class DoctorSidebarItem {
  const DoctorSidebarItem({
    required this.tab,
    required this.title,
    required this.icon,
    this.isHeader = false,
  });

  final DoctorTab tab;
  final String title;
  final IconData icon;
  final bool isHeader;

  static const List<DoctorSidebarItem> items = [
    DoctorSidebarItem(
      tab: DoctorTab.console,
      title: 'Clinical Console',
      icon: Icons.dashboard_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.opdQueue,
      title: 'OPD Queue',
      icon: Icons.assignment_ind_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.ipdRound,
      title: 'IPD Ward Rounds',
      icon: Icons.hotel_outlined,
    ),
    // Orders Section/Header can be built programmatically in the sidebar,
    // but we define tabs here:
    DoctorSidebarItem(
      tab: DoctorTab.labOrders,
      title: 'Lab Orders / Results',
      icon: Icons.science_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.radiologyOrders,
      title: 'Radiology Orders',
      icon: Icons.settings_remote_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.bloodRequests,
      title: 'Blood Requests',
      icon: Icons.bloodtype_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.patientBills,
      title: 'Patient Bills',
      icon: Icons.credit_card_outlined,
    ),
  ];
}
