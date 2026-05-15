import 'package:flutter/material.dart';

class SidebarItem {
  final String title;
  final IconData icon;
  final String routeName;
  final bool isSeparator;

  const SidebarItem({
    required this.title,
    required this.icon,
    required this.routeName,
    this.isSeparator = false,
  });

  static const List<SidebarItem> items = [
    SidebarItem(title: 'Executive Dashboard', icon: Icons.dashboard_outlined, routeName: '/dashboard'),
    SidebarItem(title: 'Patient Registration', icon: Icons.person_add_alt_1_outlined, routeName: '/patient-registration'),
    SidebarItem(title: 'OPD Management', icon: Icons.medical_services_outlined, routeName: '/opd'),
    SidebarItem(title: 'IPD / ADT', icon: Icons.hotel_outlined, routeName: '/ipd'),
    SidebarItem(title: 'Billing & Finance', icon: Icons.payments_outlined, routeName: '/billing'),
    SidebarItem(title: 'Pharmacy', icon: Icons.medication_outlined, routeName: '/pharmacy'),
    SidebarItem(title: 'Lab / Pathology', icon: Icons.science_outlined, routeName: '/lab'),
    SidebarItem(title: 'Radiology / RIS', icon: Icons.settings_remote_outlined, routeName: '/radiology'),
    SidebarItem(title: 'Operation Theatre', icon: Icons.emergency_outlined, routeName: '/ot'),
    SidebarItem(title: 'Blood Bank', icon: Icons.bloodtype_outlined, routeName: '/bloodbank'),
    SidebarItem(title: 'Vaccination', icon: Icons.vaccines_outlined, routeName: '/vaccination'),
    SidebarItem(title: 'Ambulance', icon: Icons.local_shipping_outlined, routeName: '/ambulance'),
    SidebarItem(title: 'Inventory', icon: Icons.inventory_2_outlined, routeName: '/inventory'),
    SidebarItem(title: 'Human Resource', icon: Icons.groups_outlined, routeName: '/hr'),
  ];
}
