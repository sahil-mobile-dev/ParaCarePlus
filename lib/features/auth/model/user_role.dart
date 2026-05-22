import 'package:flutter/material.dart';

enum UserRole {
  masterAdmin(
    'Master Admin',
    'Master Admin Access',
    Icons.admin_panel_settings_rounded,
  ),
  stateSuperAdmin(
    'State Super Admin',
    'State Super Admin Access',
    Icons.account_balance_rounded,
  ),
  administrator(
    'Administrator',
    'Administrator Access',
    Icons.manage_accounts_rounded,
  ),
  doctor('Doctor', 'Doctor Access', Icons.medical_services_rounded),
  nurse('Nurse', 'Nurse Access', Icons.person_add_alt_1_rounded),
  hr('HR', 'HR Access', Icons.people_alt_rounded),
  billingStaff('Billing Staff', 'Billing Access', Icons.payments_rounded),
  pharmacist('Pharmacist', 'Pharmacist Access', Icons.local_pharmacy_rounded),
  labTechnician(
    'Lab Technician',
    'Lab Technician Access',
    Icons.science_rounded,
  ),
  radiologist('Radiologist', 'Radiologist Access', Icons.biotech_rounded),
  bloodbank('Bloodbank', 'Bloodbank Access', Icons.bloodtype_rounded),
  ambulanceDriver(
    'Ambulance Driver',
    'Ambulance Driver Access',
    Icons.airport_shuttle_rounded,
  );

  final String displayName;
  final String description;
  final IconData icon;

  const UserRole(this.displayName, this.description, this.icon);
}
