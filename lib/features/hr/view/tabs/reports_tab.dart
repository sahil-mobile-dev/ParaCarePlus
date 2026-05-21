import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab> {
  final List<Map<String, dynamic>> _reports = [
    {
      'title': 'Monthly Staff Turnout & Attendance',
      'desc':
          'Detailed monthly analysis of biometric punches, shift delays, and overtime payouts.',
      'type': 'PDF / CSV',
      'size': '4.2 MB',
    },
    {
      'title': 'CME & Licensing Audit Report',
      'desc':
          'Verification log of clinical registration compliance, license expiries, and training logs.',
      'type': 'PDF',
      'size': '2.8 MB',
    },
    {
      'title': 'Payroll & Salary Reconciliation',
      'desc':
          'Executive payout breakdown, tax deductibles, EPF contributions, and bonus logs.',
      'type': 'XLSX',
      'size': '1.5 MB',
    },
    {
      'title': 'Attrition & Nurse Recruitment Metrics',
      'desc':
          'Annual trends, exit interview insights, department-wise attrition, and pipeline gaps.',
      'type': 'PDF / XLSX',
      'size': '5.1 MB',
    },
  ];

  final List<Map<String, dynamic>> _audits = [
    {
      'audit': 'Q2 Licensing Verification Audit',
      'auditor': 'State Medical Council Board',
      'date': 'May 10, 2026',
      'findings':
          '100% Doctor credentials verified. 2 nurse licenses pending renew.',
      'status': 'Compliant',
      'statusColor': AppColors.success,
    },
    {
      'audit': 'Biometric Attendance Audit',
      'auditor': 'Internal Audit Committee',
      'date': 'April 28, 2026',
      'findings':
          'Identified minor sync latencies on Ground Floor OT biometric reader.',
      'status': 'Resolved',
      'statusColor': AppColors.primary,
    },
    {
      'audit': 'EPF & Salary Payout Clearance',
      'auditor': 'S.R. Saxena & Co. (External)',
      'date': 'April 15, 2026',
      'findings':
          'All government statutory clearances and payroll reconciliations correct.',
      'status': 'Compliant',
      'statusColor': AppColors.success,
    },
  ];

  void _exportReport(String reportName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.success,
        content: Text('Downloading file: "$reportName"... Export complete!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Staff Contract Audits',
                '342 / 342',
                'All up to date',
                AppColors.primary,
                Icons.description_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'Average Tenancy',
                '4.2 Yrs',
                'Industry Avg: 3.1 Yrs',
                AppColors.success,
                Icons.timeline_rounded,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Annual Attrition',
                '4.8%',
                'Target: < 8.0%',
                AppColors.secondaryAccent,
                Icons.trending_down_rounded,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _metricCard(
                'Regulatory Audits',
                '03 Passed',
                'FY 2025-26',
                AppColors.primaryLight,
                Icons.gavel_rounded,
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.lg),
        _buildReportsListCard(),
        const SizedBox(height: AppSpacing.md),
        _buildAuditLogCard(),
      ],
    );
  }

  Widget _metricCard(
    String label,
    String value,
    String sub,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  sub,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportsListCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Executive HR Reports',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Download analytical insights and compliance reports',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reports.length,
            itemBuilder: (context, index) {
              final rep = _reports[index];
              final title = rep['title'] as String;
              final desc = rep['desc'] as String;
              final type = rep['type'] as String;
              final size = rep['size'] as String;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.article_rounded,
                                color: AppColors.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  title,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(desc, style: AppTextStyles.bodySmall),
                          const SizedBox(height: 4),
                          Text(
                            'Format: $type | Size: $size',
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.secondaryAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.download_rounded,
                        color: AppColors.success,
                      ),
                      onPressed: () => _exportReport(title),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAuditLogCard() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enterprise Regulatory Audits',
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Past inspection records and audit reviews',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 10),
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _audits.length,
            itemBuilder: (context, index) {
              final aud = _audits[index];
              final audit = aud['audit'] as String;
              final auditor = aud['auditor'] as String;
              final date = aud['date'] as String;
              final findings = aud['findings'] as String;
              final status = aud['status'] as String;
              final statusColor = aud['statusColor'] as Color;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            audit,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: statusColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Auditor: $auditor | Date: $date',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Findings Summary:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      findings,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.secondaryText,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
