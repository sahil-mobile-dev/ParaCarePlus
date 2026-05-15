---
trigger: always_on
---

# ParaCarePlus Project-Specific Planning

# Project Overview

## Application Name

ParaCarePlus

---

## Project Type

Enterprise Healthcare Management System (HIMS)

Focused on:

* Hospital operations
* Clinical workflows
* Emergency services
* Administrative workflows
* Real-time monitoring
* Multi-role healthcare management

---

# Supported User Roles

* Master Admin
* State Super Admin
* Administrator
* Doctor
* Nurse
* HR
* Billing Staff
* Pharmacist
* Lab Technician
* Radiologist
* Bloodbank
* Ambulance Driver

---

# Architecture Direction

The application must follow:

```txt
Role-Based Enterprise Modular Architecture
```

---

# Feature Modules

```txt
features/
 ├── auth/
 ├── dashboard/
 ├── patient/
 ├── opd/
 ├── ipd/
 ├── pharmacy/
 ├── laboratory/
 ├── radiology/
 ├── billing/
 ├── ambulance/
 ├── bloodbank/
 ├── inventory/
 ├── hr/
 ├── certificates/
 ├── notifications/
 ├── reports/
 └── settings/
```

---

# Dashboard Direction

## Dashboard Type

Hospital Command Center Dashboard

---

## Dashboard Sections

* Quick Actions
* Live Activity Feed
* Critical Alerts
* Statistics Overview
* Bed Occupancy
* Revenue Analytics
* Critical Patients
* Staff On Duty
* Pending Approvals
* Module Status
* Inventory Alerts
* Ambulance Status

---

# Quick Actions

Quick actions should be reusable cards.

Includes:

* New Patient
* OPD Token
* IPD Admit
* Pharmacy
* Laboratory
* Radiology
* Billing
* Ambulance
* Blood Bank
* Inventory
* HR & Payroll
* Certificates

---

# Theme Direction

## Theme Style

Dark Enterprise Healthcare Theme

---

## UI Personality

The application should feel:

* Professional
* Secure
* Operationally efficient
* Minimal
* Government healthcare inspired
* Enterprise-grade

Avoid:

* Playful UI
* Excessive animations
* Social app styling

---

# Theme Colors

| Purpose          | Color   |
| ---------------- | ------- |
| Background       | #0C1F34 |
| Surface          | #122C46 |
| Card             | #1A3552 |
| Border           | #2A4158 |
| Primary          | #135AB0 |
| Secondary Accent | #F59E0B |
| Success          | #22C55E |
| Error            | #EF4444 |
| Primary Text     | #F2F4F6 |
| Secondary Text   | #A1A4A9 |

---

# Backend Information

Expected backend:

* Laravel
* PHP
* MySQL
* phpMyAdmin

---

# Connectivity Strategy

## Offline Support

Full offline support is NOT required.

However:

* Show cached dashboard data
* Handle low internet gracefully
* Prevent crashes on weak connectivity
* Show last synced timestamps
* Retry failed requests automatically

---

# Recommended Cache Strategy

Use:

* Hive
* SharedPreferences
* API response caching
* Local dashboard cache

---

# Security Requirements

Mandatory:

* Role-based access control
* Route protection
* Permission-based UI
* Secure token handling
* Session expiration handling
* API authorization validation

---

# Routing Strategy

## Route Protection

Every role must have:

* Protected routes
* Permission-based access
* Separate dashboards where needed
* Controlled navigation visibility

---

# Reusable Systems

Create reusable systems for:

* Dashboard cards
* Tables
* Search
* Filters
* Pagination
* Alerts
* Status chips
* Statistics cards
* Activity feed cards
* Approval cards
* Error states
* Retry widgets

---

# Responsive Strategy

The app should support:

* Mobile phones
* Tablets
* Larger Android screens

---

# Performance Direction

Mandatory:

* Lazy loading
* Pagination
* Optimized provider scopes
* Minimal rebuilds
* Efficient scrolling
* Lightweight widgets

---

# Future Scalability

Architecture should remain scalable for:

* Multi-hospital support
* State-wide deployments
* Web dashboard support
* Socket integration
* Push notifications
* Multi-language support
* Audit logs
* Analytics systems
