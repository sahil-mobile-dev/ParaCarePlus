import 'package:flutter/material.dart';

enum DoctorTab {
  console('Clinical Console', Icons.dashboard_outlined),
  opdQueue('OPD Queue', Icons.assignment_ind_outlined),
  ipdRound('My IPD Patients', Icons.hotel_outlined),
  ePrescriptions('e-Prescriptions', Icons.medication_outlined),
  clinicalNotes('Clinical Notes / SOAP', Icons.assignment_outlined),
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
      title: 'My IPD Patients',
      icon: Icons.hotel_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.ePrescriptions,
      title: 'e-Prescriptions',
      icon: Icons.medication_outlined,
    ),
    DoctorSidebarItem(
      tab: DoctorTab.clinicalNotes,
      title: 'Clinical Notes / SOAP',
      icon: Icons.assignment_outlined,
    ),
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
