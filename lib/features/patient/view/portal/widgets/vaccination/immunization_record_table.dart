import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class ImmunizationRecordTable extends StatelessWidget {
  const ImmunizationRecordTable({super.key});

  static const List<Map<String, dynamic>> _records = [
    {
      'vaccine': 'COVID-19 (Covaxin)',
      'protection': 'COVID-19',
      'doses': '3/3 (incl. booster)',
      'lastDose': 'Jan 2022',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': true,
    },
    {
      'vaccine': 'Hepatitis B',
      'protection': 'Hepatitis B',
      'doses': '3/3',
      'lastDose': 'Aug 2018',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': true,
    },
    {
      'vaccine': 'Tdap Booster',
      'protection': 'Tetanus, Diphtheria, Pertussis',
      'doses': '0/1 (overdue)',
      'lastDose': 'Mar 2016',
      'nextDue': 'Mar 2026',
      'status': 'Overdue',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Influenza',
      'protection': 'Seasonal Flu',
      'doses': 'Annual',
      'lastDose': 'Jul 2025',
      'nextDue': 'Jun 2026',
      'status': 'Due Soon',
      'hasCertificate': false,
    },
    {
      'vaccine': 'MMR',
      'protection': 'Measles, Mumps, Rubella',
      'doses': '2/2',
      'lastDose': '1985 (childhood)',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Typhoid (Vi)',
      'protection': 'Typhoid Fever',
      'doses': '1/1',
      'lastDose': 'Apr 2023',
      'nextDue': 'Apr 2026',
      'status': 'Due',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Hepatitis A',
      'protection': 'Hepatitis A',
      'doses': '2/2',
      'lastDose': 'Jun 2020',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Pneumococcal (PPSV23)',
      'protection': 'Pneumonia',
      'doses': '1/1',
      'lastDose': 'Jan 2024',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': false,
    },
    {
      'vaccine': 'HPV (Not applicable)',
      'protection': 'HPV-related cancers',
      'doses': '—',
      'lastDose': '—',
      'nextDue': '—',
      'status': 'N/A',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Rabies (Pre-exposure)',
      'protection': 'Rabies',
      'doses': '3/3',
      'lastDose': 'Feb 2022',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Meningococcal (MenACWY)',
      'protection': 'Meningitis',
      'doses': '1/1',
      'lastDose': 'Sep 2019',
      'nextDue': '—',
      'status': 'Complete',
      'hasCertificate': false,
    },
    {
      'vaccine': 'Varicella (Chickenpox)',
      'protection': 'Chickenpox',
      'doses': 'Natural immunity',
      'lastDose': 'Childhood illness',
      'nextDue': '—',
      'status': 'Immune',
      'hasCertificate': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.fact_check_outlined,
                color: AppColors.primaryLight,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Complete Immunization Record',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Scrollbar(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: AppColors.border.withValues(alpha: 0.3),
                ),
                child: DataTable(
                  horizontalMargin: 8,
                  columnSpacing: 16,
                  headingRowColor: WidgetStateProperty.all(
                    Colors.white.withValues(alpha: 0.04),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Vaccine',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Disease Protection',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Doses',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Last Dose',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Next Due',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Status',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Certificate',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: _records.map((r) {
                    final status = r['status'] as String;
                    final vaccineName = r['vaccine'] as String;
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            vaccineName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['protection'] as String,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['doses'] as String,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['lastDose'] as String,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            r['nextDue'] as String,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(_buildStatusBadge(status)),
                        DataCell(
                          r['hasCertificate'] as bool
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.download_rounded,
                                    color: AppColors.primaryLight,
                                    size: 16,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Downloading $vaccineName certificate...',
                                        ),
                                        backgroundColor: AppColors.surface,
                                      ),
                                    );
                                  },
                                )
                              : const Text(
                                  '—',
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontSize: 11,
                                  ),
                                ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String text;

    switch (status) {
      case 'Complete':
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        text = '✓ Complete';
      case 'Immune':
        bgColor = AppColors.success.withValues(alpha: 0.15);
        textColor = AppColors.success;
        text = '✓ Immune';
      case 'Due Soon':
        bgColor = AppColors.secondaryAccent.withValues(alpha: 0.15);
        textColor = AppColors.secondaryAccent;
        text = '⏱ Due Soon';
      case 'Due':
        bgColor = AppColors.secondaryAccent.withValues(alpha: 0.15);
        textColor = AppColors.secondaryAccent;
        text = '⏱ Due';
      case 'Overdue':
        bgColor = AppColors.error.withValues(alpha: 0.15);
        textColor = AppColors.error;
        text = '⚠ Overdue';
      default:
        bgColor = Colors.white.withValues(alpha: 0.05);
        textColor = AppColors.secondaryText;
        text = 'N/A (Male, Age 48)';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 9.5,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
