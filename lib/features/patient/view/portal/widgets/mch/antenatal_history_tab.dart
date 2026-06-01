import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class AntenatalHistoryTab extends StatelessWidget {
  const AntenatalHistoryTab({super.key});

  static const List<Map<String, String>> _visits = [
    {
      'visit': 'ANC 1st Visit',
      'date': 'Jan 2007',
      'findings': 'Confirmed pregnancy, iron/folic started',
      'bp': '110/70',
      'weight': '52 kg',
      'status': 'Done',
    },
    {
      'visit': 'ANC 2nd Visit',
      'date': 'Mar 2007',
      'findings': 'Anomaly scan normal, Hb 11.2',
      'bp': '112/72',
      'weight': '55 kg',
      'status': 'Done',
    },
    {
      'visit': 'ANC 3rd Visit',
      'date': 'Jun 2007',
      'findings': 'Growth scan normal, no GDM',
      'bp': '114/74',
      'weight': '59 kg',
      'status': 'Done',
    },
    {
      'visit': 'ANC 4th Visit',
      'date': 'Aug 2007',
      'findings': 'Term, vertex, TT booster given',
      'bp': '116/76',
      'weight': '63 kg',
      'status': 'Done',
    },
    {
      'visit': 'PNC Visit',
      'date': 'Oct 2007',
      'findings': 'Postnatal well, breastfeeding started',
      'bp': '112/72',
      'weight': '57 kg',
      'status': 'Done',
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            children: [
              Icon(
                Icons.pregnant_woman_rounded,
                color: Color(0xFFF72585),
                size: 16,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Antenatal Care History — Geeta Kumar (Spouse)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Counters Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 2.3,
                children: [
                  _buildCounterTile('Pregnancies', 'G2 P2 A0', Colors.white),
                  _buildCounterTile('Last Delivery', 'Sep 2007', Colors.white),
                  _buildCounterTile('Mode', 'Normal SVD', Colors.white),
                  _buildCounterTile(
                    'Current Status',
                    'Not Pregnant',
                    AppColors.success,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // History Table
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
                  columnSpacing: 20,
                  headingRowColor: WidgetStateProperty.all(
                    Colors.white.withValues(alpha: 0.04),
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Visit Type',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Date',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Findings',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Blood Pressure',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Weight',
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
                  ],
                  rows: _visits.map((v) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Text(
                            v['visit']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            v['date']!,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            v['findings']!,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            v['bp']!,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            v['weight']!,
                            style: const TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                color: AppColors.success,
                                fontSize: 9.5,
                                fontWeight: FontWeight.bold,
                              ),
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

  Widget _buildCounterTile(String label, String value, Color valueColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.secondaryText, fontSize: 9),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
