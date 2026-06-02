import 'package:flutter/material.dart';
import 'package:paracareplus/routes/route_names.dart';

class DashboardModuleItem {
  const DashboardModuleItem({
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.emoji,
    required this.badge,
    required this.metrics,
    required this.routeName,
    required this.colorTheme,
    this.isFeatured = false,
    this.onTap,
  });
  final String title;
  final String description;
  final String category;
  final List<String> tags;
  final String emoji;
  final String badge;
  final Map<String, String> metrics;
  final String routeName;
  final bool isFeatured;
  final String colorTheme;
  final VoidCallback? onTap;

  static List<DashboardModuleItem> items = [
    DashboardModuleItem(
      title: 'Executive State Health Command Center',
      description:
          '36 Core KPIs · AI Predictions · GIS Heatmaps · Sunburst Drill-down · Real-time Alerts. Complete situational awareness for Health Secretary, DG Health and NHM leadership.',
      category: 'state',
      tags: ['State Secretary', 'DG Health', 'NHM', 'Real-Time'],
      emoji: '🎯',
      badge: 'FLAGSHIP',
      metrics: {
        'KPIs': '36',
        'Sunbursts': '8',
        'GIS Maps': '5',
        'AI': 'Predictions',
      },
      routeName: RouteNames.stateCommand,
      isFeatured: true,
      colorTheme: 'blue',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'ABDM Compliance Dashboard',
      description:
          'ABHA generation, consent tracking, HIP/HIU transactions, API health, Digital Health ID coverage, ePrescription exchange.',
      category: 'state',
      tags: ['ABDM', 'ABHA', 'HIP/HIU'],
      emoji: '🔗',
      badge: 'ABDM',
      metrics: {'KPIs': '16', 'Charts': '7', 'FHIR': 'API'},
      routeName: RouteNames.abdmCompliance,
      colorTheme: 'teal',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'State Disease Surveillance',
      description:
          'Outbreak alerts, communicable/NCD tracking, AI risk prediction, district heatmaps, GIS outbreak zones, vaccination coverage maps.',
      category: 'state public',
      tags: ['Outbreak', 'Epidemic', 'NCD'],
      emoji: '🦠',
      badge: 'CRITICAL ALERT',
      metrics: {'KPIs': '12', 'Heatmaps': '5', 'GIS': 'Active'},
      routeName: RouteNames.diseaseSurveillance,
      colorTheme: 'red',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'State Admin Overview',
      description:
          'District scorecards, facility register, AB expenditure, revenue analytics, MCH radar, workforce distribution across all 13 districts.',
      category: 'state',
      tags: ['Districts', 'Scorecard'],
      emoji: '📊',
      badge: 'ADMIN',
      metrics: {'Districts': '13', 'Charts': '20+'},
      routeName: RouteNames.stateAdminOverview,
      colorTheme: 'indigo',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Hospital Performance Dashboard',
      description:
          '17 KPIs: occupancy, ALOS, OT utilization, mortality, digitalization index. Revenue vs expenditure, patient flow funnel, equipment uptime, referral analysis.',
      category: 'clinical ops',
      tags: ['Medical Supt.', 'CMO', 'Ops'],
      emoji: '🏨',
      badge: 'OPERATIONS',
      metrics: {'KPIs': '17', 'Charts': '7', 'Sunbursts': '3'},
      routeName: RouteNames.dashboard,
      colorTheme: 'green',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'OPD Analytics Dashboard',
      description:
          '10 KPIs, hourly load curves, specialty demand, queue congestion, scan & share adoption, age/gender demographics, 3 heatmaps.',
      category: 'clinical ops',
      tags: ['OPD', 'Queue', 'Token'],
      emoji: '🩺',
      badge: 'OPD',
      metrics: {'KPIs': '10', 'Charts': '5', 'Heatmaps': '3'},
      routeName: RouteNames.opdToken,
      colorTheme: 'blue',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'IPD & Bed Management',
      description:
          'Real-time bed availability, ICU/ventilator utilization, ward-wise occupancy, statewide bed GIS map, admission vs discharge flow analysis.',
      category: 'clinical ops',
      tags: ['Beds', 'ICU', 'Ventilator'],
      emoji: '🛏️',
      badge: 'IPD',
      metrics: {'KPIs': '9', 'Charts': '4', 'GIS': 'Maps'},
      routeName: RouteNames.ipdAdmission,
      colorTheme: 'purple',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Emergency & Trauma Dashboard',
      description:
          'Golden hour compliance, ambulance live tracking, trauma severity index, accident hotspot GIS map, trauma center coverage analysis.',
      category: 'clinical ops',
      tags: ['108 Amb.', 'Trauma', 'GIS'],
      emoji: '🚨',
      badge: 'EMERGENCY',
      metrics: {'KPIs': '6', 'Charts': '4', 'GIS': '3'},
      routeName: RouteNames.ambulance,
      colorTheme: 'red',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Maternal & Child Health',
      description:
          'ANC registrations, high-risk pregnancy heatmap, institutional deliveries, neonatal mortality, immunization coverage, malnutrition monitoring.',
      category: 'clinical public',
      tags: ['ANC', 'MMR', 'IMR', 'RMNCH'],
      emoji: '🤰',
      badge: 'MCH',
      metrics: {'KPIs': '7', 'Charts': '4', 'Heatmaps': '2'},
      routeName: RouteNames.dashboard,
      colorTheme: 'pink',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Radiology & Imaging',
      description:
          'Modality utilization (X-Ray/CT/MRI/USG), AI-assisted findings %, TAT analysis, reporting delays, DICOM viewer integration.',
      category: 'clinical ops',
      tags: ['CT/MRI', 'DICOM', 'AI'],
      emoji: '🔬',
      badge: 'RIS',
      metrics: {'KPIs': '5', 'Charts': '3', 'AI': 'Findings'},
      routeName: RouteNames.radiology,
      colorTheme: 'cyan',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Laboratory & Diagnostics',
      description:
          'Daily tests, TAT analysis, critical findings %, AI abnormality detection, equipment utilization, district-wise diagnostic trends heatmap.',
      category: 'clinical ops',
      tags: ['TAT', 'Critical', 'AI'],
      emoji: '🧪',
      badge: 'LIS',
      metrics: {'KPIs': '7', 'Charts': '4', 'Heatmaps': '2'},
      routeName: RouteNames.laboratory,
      colorTheme: 'teal',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Blood Bank Management',
      description:
          '8-group live inventory, donor registry, cross-match queue, component register, expiry quarantine, state-wide blood availability analytics.',
      category: 'clinical ops',
      tags: ['Donor', 'Components'],
      emoji: '🩸',
      badge: 'BLOOD BANK',
      metrics: {'Groups': '8', 'Live': 'Inventory'},
      routeName: RouteNames.bloodbank,
      colorTheme: 'red',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Pharmacy & Drug Intelligence Dashboard',
      description:
          '9 KPIs: availability %, stock-out risk, expiry, ABC/VED analysis. AI drug demand forecasting, narcotics monitoring, medicine shortage heatmap, district consumption heatmap, supplier performance, sunburst by category.',
      category: 'ops',
      tags: ['Pharmacist', 'Supply Chain', 'AI Forecast', 'ABC/VED'],
      emoji: '💊',
      badge: 'DRUG INTEL',
      metrics: {'KPIs': '9', 'Charts': '4', 'Heatmaps': '2', 'Sunbursts': '2'},
      routeName: RouteNames.pharmacy,
      isFeatured: true,
      colorTheme: 'orange',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Inventory & Asset Management',
      description:
          '1,800+ items, GRN workflow, auto-PO, department-wise issue, 284 tracked assets, maintenance logs, equipment utilization analytics.',
      category: 'ops',
      tags: ['GRN', 'PO', 'Assets'],
      emoji: '📦',
      badge: 'SUPPLY',
      metrics: {'Items': '1,800+', 'Assets': '284'},
      routeName: 'inventory',
      colorTheme: 'brown',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'HR & Workforce Dashboard',
      description:
          '248 staff, attendance compliance, duty roster, leave management, payroll processing, nurse-to-patient ratio, attrition analysis, sunburst by department → role → attendance.',
      category: 'ops',
      tags: ['Payroll', 'Roster', 'Workforce'],
      emoji: '👥',
      badge: 'HR & PAYROLL',
      metrics: {'Staff': '248', 'KPIs': '7'},
      routeName: RouteNames.hr,
      colorTheme: 'indigo',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Finance & Revenue Intelligence Dashboard',
      description:
          'Revenue collection, pending payments, insurance recovery, cashless billing %, budget utilization, operational cost per bed, department-wise revenue, payment mode analytics. Sankey diagram for fund flow, treemap for expenditure breakdown.',
      category: 'finance',
      tags: ['Finance Officer', 'Revenue', 'Budget'],
      emoji: '💰',
      badge: 'FINANCE',
      metrics: {'KPIs': '7', 'Charts': '4', 'Sankey': 'Fund Flow'},
      routeName: RouteNames.billing,
      isFeatured: true,
      colorTheme: 'green',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Ayushman Bharat / SHA Claims',
      description:
          'Claims lifecycle funnel, approval/rejection trend, package utilization, fraud detection analytics, sunburst by scheme → hospital → package → status.',
      category: 'finance',
      tags: ['SHA', 'PMJAY', 'Fraud'],
      emoji: '🏥',
      badge: 'AB / SHA',
      metrics: {'KPIs': '7', 'Charts': '4', 'Sunbursts': '2'},
      routeName: RouteNames.tpa,
      colorTheme: 'gold',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Billing & Collections',
      description:
          'Dynamic line-item billing, scheme discounts (AB/CGHS/ESI), TPA claims tracking, multiple payment modes, revenue reports, cashless analytics.',
      category: 'finance',
      tags: ['Cashless', 'TPA', 'CGHS'],
      emoji: '💳',
      badge: 'BILLING',
      metrics: {'Live': 'Billing', 'AB+': 'Schemes'},
      routeName: RouteNames.billing,
      colorTheme: 'teal',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'AI & Predictive Healthcare Intelligence',
      description:
          '12 AI KPIs: outbreak risk, ICU demand, medicine shortage, readmission risk, mortality prediction, fraud detection. Forecast vs actual curves, predictive bed occupancy, AI utilization trends, health risk stratification, population insights.',
      category: 'ai',
      tags: ['AI Engine', 'Outbreaks', 'Fraud Detection', 'Mortality'],
      emoji: '🤖',
      badge: 'AI ENGINE',
      metrics: {
        'AI KPIs': '12',
        'ML Models': '8',
        'GIS': 'Risk Maps',
        'NLP': 'MedBot 3.2',
      },
      routeName: RouteNames.dashboard,
      isFeatured: true,
      colorTheme: 'purple',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Quick Appointment Portal',
      description:
          '6-step public booking: UHID/Phone/Aadhaar/MRN lookup, OTP verify, dept & doctor selection, slot picker, token generation. No login required.',
      category: 'clinical public',
      tags: ['No Login', 'OTP', 'Token'],
      emoji: '📅',
      badge: 'PUBLIC',
      metrics: {'Steps': '6', 'OTP': 'Enabled'},
      routeName: RouteNames.opdToken,
      colorTheme: 'green',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Transfer & Posting Workflow',
      description:
          'Patient ward/ICU/inter-hospital transfer, staff transfer, posting orders, deputation, DPC/promotion — 7-stage approval workflow.',
      category: 'clinical ops',
      tags: ['Patient', 'Staff', 'Workflow'],
      emoji: '🔀',
      badge: 'TRANSFER',
      metrics: {'Stages': '7', 'Workflow': 'Active'},
      routeName: RouteNames.dashboard,
      colorTheme: 'purple',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Certificates & Documents',
      description:
          '8 certificate types: birth, death, discharge, fitness, medico-legal, disability, refusal. Live preview, numbered, verification, sharing.',
      category: 'clinical',
      tags: ['Birth', 'Death', 'MLC'],
      emoji: '📜',
      badge: 'DOCUMENTS',
      metrics: {'Types': '8', 'Live': 'Preview'},
      routeName: RouteNames.dashboard,
      colorTheme: 'brown',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Doctor Clinical Workspace',
      description:
          'OPD queue, patient records, ePrescription, lab/radiology orders, clinical notes, referral management, consultation analytics.',
      category: 'clinical',
      tags: ['ePrescription', 'Orders'],
      emoji: '🩺',
      badge: 'DOCTOR',
      metrics: {'OPD': 'Queue', 'EMR': 'Integrated'},
      routeName: RouteNames.doctorDashboard,
      colorTheme: 'blue',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Nursing Station Dashboard',
      description:
          'Ward patient list, vitals monitoring, MAR (Medication Administration Record), nursing notes, shift handover, task management.',
      category: 'clinical',
      tags: ['MAR', 'Vitals', 'Ward'],
      emoji: '👩‍⚕️',
      badge: 'NURSING',
      metrics: {'Ward': 'Vitals', 'MAR': 'Active'},
      routeName: RouteNames.dashboard,
      colorTheme: 'pink',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Facility Onboarding Wizard',
      description:
          '8-step wizard for Medical Colleges, District Hospitals, CHCs, PHCs, Sub-Centres, Private, Diagnostic, AYUSH facilities. AB empanelment, HMIS module setup.',
      category: 'state',
      tags: ['8-Step', 'AB Empanel'],
      emoji: '🏗️',
      badge: 'ONBOARDING',
      metrics: {'Steps': '8', 'Wizard': 'Active'},
      routeName: RouteNames.dashboard,
      colorTheme: 'orange',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Hospital Admin Dashboard',
      description:
          'Executive KPIs, live bed map, department performance, ambulance status, revenue snapshot, emergency load, staff on duty.',
      category: 'ops',
      tags: ['Hospital', 'Executive'],
      emoji: '👨‍💼',
      badge: 'ADMIN',
      metrics: {'Live Map': 'Beds', 'Staff': 'Active'},
      routeName: RouteNames.dashboard,
      colorTheme: 'indigo',
      onTap: () {},
    ),
    DashboardModuleItem(
      title: 'Ambulance Fleet & Dispatch',
      description:
          'Live Leaflet.js map, dispatch board, 8-vehicle fleet, trip history, response time analytics, fuel & maintenance tracking.',
      category: 'ops',
      tags: ['Live Map', 'Dispatch'],
      emoji: '🚑',
      badge: '108 FLEET',
      metrics: {'Fleet': '8', 'Live': 'Tracking'},
      routeName: RouteNames.ambulance,
      colorTheme: 'red',
      onTap: () {},
    ),
  ];
}

class PatientPortalModuleItem {
  const PatientPortalModuleItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.routeName,
    this.isNew = false,
    this.isSOS = false,
  });
  final String icon;
  final String title;
  final String subtitle;
  final String routeName;
  final bool isNew;
  final bool isSOS;

  static const List<PatientPortalModuleItem> items = [
    PatientPortalModuleItem(
      icon: '🔐',
      title: 'Patient Login',
      subtitle: 'ABHA · OTP · Biometric',
      routeName: RouteNames.patientLogin,
    ),
    PatientPortalModuleItem(
      icon: '🏠',
      title: 'Patient Home',
      subtitle: '20 KPIs · Health snapshot',
      routeName: RouteNames.patientHome,
    ),
    PatientPortalModuleItem(
      icon: '📋',
      title: 'Health Records (EMR)',
      subtitle: '11-tab EMR · FHIR R4',
      routeName: RouteNames.patientEMR,
    ),
    PatientPortalModuleItem(
      icon: '🗓️',
      title: 'OPD Booking',
      subtitle: '5-step wizard · Live queue',
      routeName: RouteNames.patientOPD,
    ),
    PatientPortalModuleItem(
      icon: '📊',
      title: 'Health Analytics',
      subtitle: '14 KPIs · 8 charts · Calendar',
      routeName: RouteNames.patientHealthAnalytics,
    ),
    PatientPortalModuleItem(
      icon: '🔬',
      title: 'Lab Reports',
      subtitle: '6 KPIs · AI interpretation',
      routeName: RouteNames.patientLab,
    ),
    PatientPortalModuleItem(
      icon: '🩻',
      title: 'Radiology',
      subtitle: 'DICOM viewer · AI findings',
      routeName: RouteNames.patientRadiology,
    ),
    PatientPortalModuleItem(
      icon: '💊',
      title: 'Prescriptions',
      subtitle: 'Med schedule · Interactions',
      routeName: RouteNames.patientPrescription,
    ),
    PatientPortalModuleItem(
      icon: '💉',
      title: 'Vaccination',
      subtitle: 'Immunisation records',
      routeName: RouteNames.patientVaccination,
    ),
    PatientPortalModuleItem(
      icon: '❤️',
      title: 'Chronic Care',
      subtitle: '9 conditions · AI risk',
      routeName: RouteNames.patientChronic,
    ),
    PatientPortalModuleItem(
      icon: '🤱',
      title: 'MCH',
      subtitle: 'Child growth · ANC · Women',
      routeName: RouteNames.patientMch,
    ),
    PatientPortalModuleItem(
      icon: '📹',
      title: 'Telemedicine',
      subtitle: 'Live video · Chat · Doctors',
      routeName: RouteNames.patientTele,
    ),
    PatientPortalModuleItem(
      icon: '🚨',
      title: 'Emergency SOS',
      subtitle: 'SOS · Ambulance · GIS maps',
      routeName: RouteNames.patientEmergency,
      isSOS: true,
    ),
    PatientPortalModuleItem(
      icon: '💳',
      title: 'Finance & Insurance',
      subtitle: 'AB-PMJAY · CGHS · Bills',
      routeName: RouteNames.patientFinance,
    ),
    PatientPortalModuleItem(
      icon: '🧘',
      title: 'Wellness',
      subtitle: 'Score 78 · Goals · Checkups',
      routeName: RouteNames.patientWellness,
    ),
    PatientPortalModuleItem(
      icon: '👨‍👩‍👧‍👦',
      title: 'Family Health',
      subtitle: '5 members · Sunburst risk',
      routeName: RouteNames.patientFamily,
    ),
    PatientPortalModuleItem(
      icon: '🤖',
      title: 'AI Smart Assistant',
      subtitle: '12 AI modules · MedBot v3.2',
      routeName: RouteNames.patientAI,
      isNew: true,
    ),
    PatientPortalModuleItem(
      icon: '🔔',
      title: 'Notifications',
      subtitle: '10 alert types · 7 unread',
      routeName: RouteNames.patientNotifications,
    ),
    PatientPortalModuleItem(
      icon: '⭐',
      title: 'Feedback',
      subtitle: 'Ratings · NPS · Comments',
      routeName: RouteNames.patientFeedback,
    ),
    PatientPortalModuleItem(
      icon: '🗺️',
      title: 'Smart Maps GIS',
      subtitle: '11 map types · Leaflet',
      routeName: RouteNames.patientMaps,
    ),
  ];
}
