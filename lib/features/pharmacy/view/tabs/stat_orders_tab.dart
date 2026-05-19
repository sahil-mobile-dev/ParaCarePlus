import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class StatOrdersTab extends StatefulWidget {
  const StatOrdersTab({super.key});

  @override
  State<StatOrdersTab> createState() => _StatOrdersTabState();
}

class _StatOrdersTabState extends State<StatOrdersTab> {
  Timer? _timer;
  final List<Map<String, dynamic>> _statOrders = [
    {
      'id': 'STAT-01',
      'location': 'ICU Bed 3',
      'patient': 'Rohan Bisht',
      'doctor': 'Dr. Negi',
      'orderedAt': DateTime.now().subtract(const Duration(minutes: 8)),
      'drugs': 'Inj. Noradrenaline 4mg + Dopamine 200mg',
    },
    {
      'id': 'STAT-02',
      'location': 'HDU Bed 1',
      'patient': 'Meera Joshi',
      'doctor': 'Dr. Negi',
      'orderedAt': DateTime.now().subtract(const Duration(minutes: 1)),
      'drugs': 'Inj. Furosemide 20mg STAT',
    },
    {
      'id': 'STAT-03',
      'location': 'NICU Bed 2',
      'patient': 'Infant of Seema',
      'doctor': 'Dr. Joshi',
      'orderedAt': DateTime.now().subtract(const Duration(minutes: 18)),
      'drugs': 'Inj. Ampicillin 125mg + Inj. Amikacin 15mg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // STAT Warning Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: AppColors.error,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STAT Orders Active Queue',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'These require IMMEDIATE dispensing. Target Turnaround Time (TAT) is under 15 minutes.',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // STAT list
        if (_statOrders.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 48,
                    color: AppColors.success,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No pending STAT orders right now.',
                    style: TextStyle(color: AppColors.secondaryText),
                  ),
                ],
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _statOrders.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 220,
            ),
            itemBuilder: (context, index) {
              final order = _statOrders[index];
              final elapsedMinutes = DateTime.now()
                  .difference(order['orderedAt'] as DateTime)
                  .inMinutes;
              final isOverdue = elapsedMinutes >= 15;

              return Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isOverdue
                        ? AppColors.error
                        : AppColors.secondaryAccent.withValues(alpha: 0.5),
                    width: isOverdue ? 1.5 : 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isOverdue
                          ? AppColors.error.withValues(alpha: 0.05)
                          : Colors.transparent,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isOverdue
                                ? AppColors.error.withValues(alpha: 0.1)
                                : AppColors.secondaryAccent.withValues(
                                    alpha: 0.1,
                                  ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            order['location'] as String,
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isOverdue
                                  ? AppColors.error
                                  : AppColors.secondaryAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Elapsed Timer
                        Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 14,
                              color: isOverdue
                                  ? AppColors.error
                                  : AppColors.secondaryAccent,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$elapsedMinutes min elapsed',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isOverdue
                                    ? AppColors.error
                                    : AppColors.secondaryAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      order['patient'] as String,
                      style: AppTextStyles.labelLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ordered By: ${order['doctor']}',
                      style: AppTextStyles.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.border,
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          order['drugs'] as String,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primaryText,
                            fontStyle: FontStyle.italic,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _statOrders.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.success,
                              content: Text(
                                'STAT Order dispensed immediately to ${order['location']}!',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.flash_on_rounded, size: 14),
                        label: const Text('Dispense NOW'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.error,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          textStyle: AppTextStyles.labelSmall.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }
}
