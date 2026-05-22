enum UserRole {
  masterAdmin,
  stateSuperAdmin,
  administrator,
  doctor,
  nurse,
  hr,
  billingStaff,
  pharmacist,
  labTechnician,
  radiologist,
  bloodbank,
  ambulanceDriver;

  String get displayName {
    switch (this) {
      case UserRole.masterAdmin:
        return 'Master Admin';
      case UserRole.stateSuperAdmin:
        return 'State Super Admin';
      case UserRole.administrator:
        return 'Administrator';
      case UserRole.doctor:
        return 'Doctor';
      case UserRole.nurse:
        return 'Nurse';
      case UserRole.hr:
        return 'HR';
      case UserRole.billingStaff:
        return 'Billing Staff';
      case UserRole.pharmacist:
        return 'Pharmacist';
      case UserRole.labTechnician:
        return 'Lab Technician';
      case UserRole.radiologist:
        return 'Radiologist';
      case UserRole.bloodbank:
        return 'Blood Bank';
      case UserRole.ambulanceDriver:
        return 'Ambulance Driver';
    }
  }
}
