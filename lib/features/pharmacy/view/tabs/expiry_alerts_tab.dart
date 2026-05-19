import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ExpiryAlertsTab extends StatefulWidget {
  const ExpiryAlertsTab({super.key});

  @override
  State<ExpiryAlertsTab> createState() => _ExpiryAlertsTabState();
}

class _ExpiryAlertsTabState extends State<ExpiryAlertsTab> {
  bool _isLoading = true;
  final List<Map<String, dynamic>> _expiryItems = [
    {
      'drug': 'Tab. Atorvastatin 10mg',
      'batch': 'B-ATO904',
      'expiryDate': '15-06-2026',
      'daysLeft': 27,
      'qty': 180,
      'recommendedAction': 'Return to Supplier',
    },
    {
      'drug': 'Inj. Insulin 100 IU',
      'batch': 'B-INS009',
      'expiryDate': '08-06-2026',
      'daysLeft': 20,
      'qty': 15,
      'recommendedAction': 'Quarantine Item',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        height: 350,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading expiry alerts...',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Filter bar
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text('All Alerts (90 days)', style: AppTextStyles.bodyMedium),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.secondaryText,
                    size: 16,
                  ),
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                _processExpiredItems();
              },
              icon: const Icon(Icons.delete_sweep_rounded, size: 16),
              label: const Text('Process Expired'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: AppTextStyles.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Status banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.secondaryAccent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.secondaryAccent.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                color: AppColors.secondaryAccent,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${_expiryItems.length} item(s) found in expiry alerts. Please review and take appropriate action.',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Expiry Table
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  'Near-Expiry Stock Details',
                  style: AppTextStyles.labelLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(220), // Drug name
                    1: FixedColumnWidth(110), // Batch
                    2: FixedColumnWidth(130), // Expiry Date
                    3: FixedColumnWidth(110), // Days Left
                    4: FixedColumnWidth(110), // Qty
                    5: FixedColumnWidth(200), // Recommended Action
                    6: FixedColumnWidth(110), // Actions
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.surface),
                      children: [
                        _buildHeaderCell('DRUG'),
                        _buildHeaderCell('BATCH'),
                        _buildHeaderCell('EXPIRY DATE'),
                        _buildHeaderCell('DAYS LEFT'),
                        _buildHeaderCell('QUANTITY'),
                        _buildHeaderCell('RECOMMENDED ACTION'),
                        _buildHeaderCell('ACTIONS'),
                      ],
                    ),
                    ..._expiryItems.map((item) {
                      return TableRow(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.border),
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Text(
                              item['drug'] as String,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell(item['batch'] as String),
                          _buildTextCell(item['expiryDate'] as String),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: Text(
                              '${item['daysLeft']} days',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          _buildTextCell('${item['qty']}'),
                          _buildTextCell(item['recommendedAction'] as String),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            child: OutlinedButton(
                              onPressed: () {
                                _quarantineItem(item);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.error,
                                side: const BorderSide(
                                  color: AppColors.error,
                                  width: 0.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('Quarantine'),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String label) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.secondaryText,
        ),
      ),
    );
  }

  Widget _buildTextCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Text(text, style: AppTextStyles.bodyMedium),
    );
  }

  void _quarantineItem(Map<String, dynamic> item) {
    setState(() {
      _expiryItems.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.error,
        content: Text(
          'Batch ${item['batch']} has been moved to Quarantine Zone!',
        ),
      ),
    );
  }

  void _processExpiredItems() {
    if (_expiryItems.isEmpty) return;
    setState(() {
      _expiryItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.success,
        content: Text(
          'All expired near-expiry batches have been quarantined and flagged for returns!',
        ),
      ),
    );
  }
}
