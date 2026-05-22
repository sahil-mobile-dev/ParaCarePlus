import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class LabReportsList extends StatefulWidget {
  const LabReportsList({super.key});

  @override
  State<LabReportsList> createState() => _LabReportsListState();
}

class _LabReportsListState extends State<LabReportsList> {
  String _selectedCategory = 'all';

  final List<String> _categories = [
    'all',
    'blood',
    'biochem',
    'hormone',
    'urine',
  ];

  final Map<String, String> _categoryLabels = {
    'all': 'All (28)',
    'blood': 'Blood Tests',
    'biochem': 'Biochemistry',
    'hormone': 'Hormones',
    'urine': 'Urine',
  };

  @override
  Widget build(BuildContext context) {
    final reports = _getReports().where((r) {
      if (_selectedCategory == 'all') return true;
      return r.category == _selectedCategory;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Horizontal Scrollable Category Filter Buttons
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: _categories.map((cat) {
              final isActive = _selectedCategory == cat;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(_categoryLabels[cat]!),
                  selected: isActive,
                  selectedColor: AppColors.primaryLight.withValues(alpha: 0.2),
                  backgroundColor: AppColors.card,
                  labelStyle: TextStyle(
                    color: isActive
                        ? AppColors.primaryLight
                        : AppColors.secondaryText,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: isActive
                          ? AppColors.primaryLight
                          : AppColors.border,
                    ),
                  ),
                  onSelected: (selected) {
                    if (selected) {
                      setState(() {
                        _selectedCategory = cat;
                      });
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Grid / Column of filtered cards
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            var crossAxisCount = 1;
            if (width > 900) {
              crossAxisCount = 3;
            } else if (width > 600) {
              crossAxisCount = 2;
            }

            if (crossAxisCount == 1) {
              return Column(
                children: reports
                    .map(
                      (r) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _LabReportCard(report: r),
                      ),
                    )
                    .toList(),
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
                childAspectRatio: 0.95,
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                return _LabReportCard(report: reports[index]);
              },
            );
          },
        ),
      ],
    );
  }

  List<_ReportItem> _getReports() {
    return [
      _ReportItem(
        title: 'Lipid Panel',
        category: 'biochem',
        categoryLabel: 'Biochemistry',
        date: '10 May 2026',
        referredBy: 'Dr. Sharma',
        facility: 'AIIMS Rishikesh',
        refNo: 'LAB-2026-0892',
        params: [
          _ParamVal('Total Cholesterol', '218 mg/dL', 'High', AppColors.error),
          _ParamVal('LDL', '138 mg/dL', 'High', AppColors.error),
          _ParamVal('HDL', '42 mg/dL', 'Normal', AppColors.success),
          _ParamVal('Triglycerides', '160 mg/dL', 'Normal', AppColors.success),
        ],
      ),
      _ReportItem(
        title: 'Complete Blood Count (CBC)',
        category: 'blood',
        categoryLabel: 'Blood Test',
        date: '10 May 2026',
        referredBy: 'Dr. Sharma',
        facility: 'AIIMS Rishikesh',
        refNo: 'LAB-2026-0891',
        params: [
          _ParamVal('Haemoglobin', '13.8 g/dL', 'Normal', AppColors.success),
          _ParamVal('WBC', '7,200/µL', 'Normal', AppColors.success),
          _ParamVal('Platelets', '2.4 L/µL', 'Normal', AppColors.success),
          _ParamVal('MCV', '82 fL', 'Normal', AppColors.success),
        ],
      ),
      _ReportItem(
        title: 'HbA1c + Fasting Glucose',
        category: 'biochem',
        categoryLabel: 'Biochemistry',
        date: '01 May 2026',
        referredBy: 'Dr. Verma',
        facility: 'Himalayan Hospital',
        refNo: 'LAB-2026-0874',
        params: [
          _ParamVal('HbA1c', '6.2%', 'High', AppColors.error),
          _ParamVal('Fasting Glucose', '142 mg/dL', 'High', AppColors.error),
          _ParamVal(
            'Post-Prandial Glucose',
            '186 mg/dL',
            'High',
            AppColors.error,
          ),
          _ParamVal(
            'Insulin (Fasting)',
            '11.2 µU/mL',
            'Normal',
            AppColors.success,
          ),
        ],
      ),
      _ReportItem(
        title: 'Liver Function Test (LFT)',
        category: 'biochem',
        categoryLabel: 'Biochemistry',
        date: '15 Apr 2026',
        referredBy: 'Dr. Sharma',
        facility: 'AIIMS Rishikesh',
        refNo: 'LAB-2026-0841',
        params: [
          _ParamVal('SGOT (AST)', '28 U/L', 'Normal', AppColors.success),
          _ParamVal('SGPT (ALT)', '31 U/L', 'Normal', AppColors.success),
          _ParamVal(
            'Bilirubin Total',
            '0.8 mg/dL',
            'Normal',
            AppColors.success,
          ),
          _ParamVal('Albumin', '4.1 g/dL', 'Normal', AppColors.success),
        ],
      ),
      _ReportItem(
        title: 'Thyroid Function Test',
        category: 'hormone',
        categoryLabel: 'Hormones',
        date: '02 Apr 2026',
        referredBy: 'Dr. Singh',
        facility: 'Doon Hospital',
        refNo: 'LAB-2026-0812',
        params: [
          _ParamVal('TSH', '3.2 mIU/L', 'Normal', AppColors.success),
          _ParamVal('Free T4', '1.1 ng/dL', 'Normal', AppColors.success),
          _ParamVal('Free T3', '2.8 pg/mL', 'Normal', AppColors.success),
        ],
      ),
      _ReportItem(
        title: 'Urine Routine & Microscopy',
        category: 'urine',
        categoryLabel: 'Urine Analysis',
        date: '10 May 2026',
        referredBy: 'Dr. Sharma',
        facility: 'AIIMS Rishikesh',
        refNo: 'LAB-2026-0893',
        params: [
          _ParamVal('Protein', 'Trace', 'Low', AppColors.secondaryAccent),
          _ParamVal('Glucose', '+1', 'High', AppColors.error),
          _ParamVal('RBC', '0–1/hpf', 'Normal', AppColors.success),
          _ParamVal('WBC', '2–3/hpf', 'Normal', AppColors.success),
        ],
      ),
    ];
  }
}

class _ReportItem {
  _ReportItem({
    required this.title,
    required this.category,
    required this.categoryLabel,
    required this.date,
    required this.referredBy,
    required this.facility,
    required this.refNo,
    required this.params,
  });

  final String title;
  final String category;
  final String categoryLabel;
  final String date;
  final String referredBy;
  final String facility;
  final String refNo;
  final List<_ParamVal> params;
}

class _ParamVal {
  _ParamVal(this.name, this.value, this.status, this.color);
  final String name;
  final String value;
  final String status;
  final Color color;
}

class _LabReportCard extends StatelessWidget {
  const _LabReportCard({required this.report});
  final _ReportItem report;

  @override
  Widget build(BuildContext context) {
    var tagColor = AppColors.primaryLight;
    if (report.category == 'blood') tagColor = const Color(0xFFEF4444);
    if (report.category == 'urine') tagColor = const Color(0xFFF59E0B);
    if (report.category == 'hormone') tagColor = const Color(0xFFC77DFF);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tagColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  report.categoryLabel,
                  style: TextStyle(
                    color: tagColor,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                report.date,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            report.title,
            style: AppTextStyles.labelLarge.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${report.referredBy} · ${report.facility} · ${report.refNo}',
            style: AppTextStyles.bodySmall.copyWith(fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          ...report.params.map((p) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      p.name,
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    p.value,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: p.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      p.status,
                      style: TextStyle(
                        color: p.color,
                        fontSize: 7.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  context,
                  Icons.visibility_rounded,
                  'View',
                  () => _showDetailSheet(context),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildActionBtn(
                  context,
                  Icons.download_rounded,
                  'PDF',
                  () => _showToast(
                    context,
                    'Generating and downloading ${report.refNo}.pdf…',
                    AppColors.success,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildActionBtn(
                  context,
                  Icons.share_rounded,
                  'Share',
                  () => _showToast(
                    context,
                    'Securely shared via national ABDM network.',
                    AppColors.primaryLight,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.secondaryText, size: 12),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontSize: 10,
                color: AppColors.primaryText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String msg, Color typeColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.card,
        content: Row(
          children: [
            Icon(Icons.info_outline, color: typeColor, size: 16),
            const SizedBox(width: 8),
            Text(
              msg,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontSize: 12,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showDetailSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.xl),
              topRight: Radius.circular(AppRadius.xl),
            ),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    report.title,
                    style: AppTextStyles.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.close_rounded,
                      color: AppColors.primaryText,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Syncing ID: ABDM-${report.refNo}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: AppSpacing.md),
              ...report.params.map((p) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.name,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Ref interval: Normal ranges mapping',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        p.value,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: p.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: p.color.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          p.status,
                          style: TextStyle(
                            color: p.color,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: AppSpacing.lg),
              const Divider(color: AppColors.border, height: 1),
              const SizedBox(height: AppSpacing.lg),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Physician Referral',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Dr. Rajesh Sharma, MD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Verification ABDM Status',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.verified_user_rounded,
                            color: AppColors.success,
                            size: 12,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Digitally Signed',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.download_rounded),
                label: const Text('Download Full Digital Report'),
                onPressed: () {
                  Navigator.pop(context);
                  _showToast(
                    context,
                    'Report downloaded successfully to your device.',
                    AppColors.success,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
