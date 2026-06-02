import 'package:flutter/material.dart';

class AbhaMetrics {
  const AbhaMetrics({
    required this.totalGenerated,
    required this.linkedEmr,
    required this.linkedEmrPercent,
    required this.digitalHealthIdCoverage,
    required this.scanAndShareOpdAdoption,
    required this.tokenBasedOpdRegistrations,
  });

  final double totalGenerated; // In Lakhs, e.g. 38.7
  final double linkedEmr; // In Lakhs, e.g. 24.2
  final double linkedEmrPercent; // 62.5
  final double digitalHealthIdCoverage; // 73.4
  final double scanAndShareOpdAdoption; // 58.9
  final double tokenBasedOpdRegistrations; // In Lakhs, e.g. 1.84

  AbhaMetrics copyWith({
    double? totalGenerated,
    double? linkedEmr,
    double? linkedEmrPercent,
    double? digitalHealthIdCoverage,
    double? scanAndShareOpdAdoption,
    double? tokenBasedOpdRegistrations,
  }) {
    return AbhaMetrics(
      totalGenerated: totalGenerated ?? this.totalGenerated,
      linkedEmr: linkedEmr ?? this.linkedEmr,
      linkedEmrPercent: linkedEmrPercent ?? this.linkedEmrPercent,
      digitalHealthIdCoverage:
          digitalHealthIdCoverage ?? this.digitalHealthIdCoverage,
      scanAndShareOpdAdoption:
          scanAndShareOpdAdoption ?? this.scanAndShareOpdAdoption,
      tokenBasedOpdRegistrations:
          tokenBasedOpdRegistrations ?? this.tokenBasedOpdRegistrations,
    );
  }
}

class EcosystemMetrics {
  const EcosystemMetrics({
    required this.consentRequests,
    required this.consentApprovalRate,
    required this.consentDenialRate,
    required this.consentPendingRate,
    required this.hipRegisteredFacilities,
    required this.hiuTransactions,
    required this.healthRecordExchanges,
    required this.ePrescriptionExchangePercent,
  });

  final int consentRequests; // e.g. 847291
  final double consentApprovalRate; // 87.3
  final double consentDenialRate; // 8.4
  final double consentPendingRate; // 4.3
  final int hipRegisteredFacilities; // 1247
  final double hiuTransactions; // In Lakhs, e.g. 3.21
  final int healthRecordExchanges; // e.g. 234817
  final double ePrescriptionExchangePercent; // 64.7

  EcosystemMetrics copyWith({
    int? consentRequests,
    double? consentApprovalRate,
    double? consentDenialRate,
    double? consentPendingRate,
    int? hipRegisteredFacilities,
    double? hiuTransactions,
    int? healthRecordExchanges,
    double? ePrescriptionExchangePercent,
  }) {
    return EcosystemMetrics(
      consentRequests: consentRequests ?? this.consentRequests,
      consentApprovalRate: consentApprovalRate ?? this.consentApprovalRate,
      consentDenialRate: consentDenialRate ?? this.consentDenialRate,
      consentPendingRate: consentPendingRate ?? this.consentPendingRate,
      hipRegisteredFacilities:
          hipRegisteredFacilities ?? this.hipRegisteredFacilities,
      hiuTransactions: hiuTransactions ?? this.hiuTransactions,
      healthRecordExchanges:
          healthRecordExchanges ?? this.healthRecordExchanges,
      ePrescriptionExchangePercent:
          ePrescriptionExchangePercent ?? this.ePrescriptionExchangePercent,
    );
  }
}

class ApiPerformanceMetrics {
  const ApiPerformanceMetrics({
    required this.successRate,
    required this.latencyMs,
    required this.healthLockerSyncPercent,
    required this.ayushmanAbdmMappingPercent,
  });

  final double successRate; // 99.3
  final int latencyMs; // 214
  final double healthLockerSyncPercent; // 96.8
  final double ayushmanAbdmMappingPercent; // 81.2

  ApiPerformanceMetrics copyWith({
    double? successRate,
    int? latencyMs,
    double? healthLockerSyncPercent,
    double? ayushmanAbdmMappingPercent,
  }) {
    return ApiPerformanceMetrics(
      successRate: successRate ?? this.successRate,
      latencyMs: latencyMs ?? this.latencyMs,
      healthLockerSyncPercent:
          healthLockerSyncPercent ?? this.healthLockerSyncPercent,
      ayushmanAbdmMappingPercent:
          ayushmanAbdmMappingPercent ?? this.ayushmanAbdmMappingPercent,
    );
  }
}

class FhirApiEndpoint {
  const FhirApiEndpoint({
    required this.name,
    required this.endpoint,
    required this.latencyMs,
    required this.uptimePercent,
    required this.status, // 'ok', 'warn', 'err'
  });

  final String name;
  final String endpoint;
  final int latencyMs;
  final double uptimePercent;
  final String status;
}

class JourneyStep {
  const JourneyStep({
    required this.label,
    required this.count,
    required this.pct,
    required this.icon,
    required this.color,
  });

  final String label;
  final String count;
  final String pct;
  final String icon;
  final Color color;
}

class ComplianceMatrixRow {
  const ComplianceMatrixRow({
    required this.module,
    required this.facilitiesCount,
    required this.compliancePercent,
    required this.score,
    required this.trend, // 'up', 'down', 'stable'
    required this.status, // 'Full', 'Partial', 'Degraded', 'Critical'
    required this.lastAudit,
  });

  final String module;
  final int facilitiesCount;
  final double compliancePercent;
  final String score; // A, B, C, D
  final String trend;
  final String status;
  final String lastAudit;
}

class DistrictAbdmScorecard {
  const DistrictAbdmScorecard({
    required this.name,
    required this.abhaCoveragePercent,
    required this.emrLinkedPercent,
    required this.consentRatePercent,
    required this.hipFacilitiesCount,
    required this.hiuTxnsCount,
    required this.apiUptimePercent,
    required this.ePrescriptionPercent,
    required this.scanAndSharePercent,
    required this.abAbdmPercent,
    required this.grade, // A, B, C, D
    required this.score, // e.g. 84
  });

  final String name;
  final double abhaCoveragePercent;
  final double emrLinkedPercent;
  final double consentRatePercent;
  final int hipFacilitiesCount;
  final int hiuTxnsCount;
  final double apiUptimePercent;
  final double ePrescriptionPercent;
  final double scanAndSharePercent;
  final double abAbdmPercent;
  final String grade;
  final int score;

  DistrictAbdmScorecard copyWith({
    String? name,
    double? abhaCoveragePercent,
    double? emrLinkedPercent,
    double? consentRatePercent,
    int? hipFacilitiesCount,
    int? hiuTxnsCount,
    double? apiUptimePercent,
    double? ePrescriptionPercent,
    double? scanAndSharePercent,
    double? abAbdmPercent,
    String? grade,
    int? score,
  }) {
    return DistrictAbdmScorecard(
      name: name ?? this.name,
      abhaCoveragePercent: abhaCoveragePercent ?? this.abhaCoveragePercent,
      emrLinkedPercent: emrLinkedPercent ?? this.emrLinkedPercent,
      consentRatePercent: consentRatePercent ?? this.consentRatePercent,
      hipFacilitiesCount: hipFacilitiesCount ?? this.hipFacilitiesCount,
      hiuTxnsCount: hiuTxnsCount ?? this.hiuTxnsCount,
      apiUptimePercent: apiUptimePercent ?? this.apiUptimePercent,
      ePrescriptionPercent: ePrescriptionPercent ?? this.ePrescriptionPercent,
      scanAndSharePercent: scanAndSharePercent ?? this.scanAndSharePercent,
      abAbdmPercent: abAbdmPercent ?? this.abAbdmPercent,
      grade: grade ?? this.grade,
      score: score ?? this.score,
    );
  }
}

class ComplianceAlert {
  const ComplianceAlert({
    required this.message,
    required this.cls, // 'crit', 'warn', 'info', 'ok'
    required this.time,
  });

  final String message;
  final String cls;
  final String time;
}
