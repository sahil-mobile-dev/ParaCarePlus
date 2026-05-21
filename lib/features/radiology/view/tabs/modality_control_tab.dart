import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ModalityControlTab extends StatefulWidget {
  const ModalityControlTab({super.key});

  @override
  State<ModalityControlTab> createState() => _ModalityControlTabState();
}

class _ModalityControlTabState extends State<ModalityControlTab> {
  final List<Map<String, dynamic>> _modalities = [
    {
      'id': 'CT-01',
      'name': 'CT Multi-slice 128',
      'brand': 'Siemens Healthineers',
      'location': 'Basement Wing A',
      'status': 'Active Scanning',
      'statusColor': AppColors.primary,
      'ping': '4 ms',
      'workload': 80,
      'queue': 3,
    },
    {
      'id': 'MRI-01',
      'name': 'MRI Tesla 3.0T',
      'brand': 'GE Healthcare',
      'location': 'Basement Wing B',
      'status': 'Idle Ready',
      'statusColor': AppColors.success,
      'ping': '8 ms',
      'workload': 10,
      'queue': 0,
    },
    {
      'id': 'XR-01',
      'name': 'Digital X-Ray HighRes',
      'brand': 'Philips Medical',
      'location': 'First Floor Room 102',
      'status': 'Calibrating',
      'statusColor': AppColors.secondaryAccent,
      'ping': '2 ms',
      'workload': 0,
      'queue': 1,
    },
    {
      'id': 'USG-01',
      'name': 'Color Doppler 4D',
      'brand': 'Samsung Medison',
      'location': 'First Floor Room 105',
      'status': 'Active Scanning',
      'statusColor': AppColors.primary,
      'ping': '15 ms',
      'workload': 95,
      'queue': 4,
    },
    {
      'id': 'MRI-02',
      'name': 'MRI Tesla 1.5T',
      'brand': 'Toshiba Medical',
      'location': 'Basement Wing B',
      'status': 'Offline',
      'statusColor': AppColors.error,
      'ping': 'Timed Out',
      'workload': 0,
      'queue': 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.settings_remote_outlined,
                  color: AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'PACS Hardware & DICOM Modalities',
                  style: AppTextStyles.bodyLarge,
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pinging all PACS modalities... Synchronization successful.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.sync_rounded, size: 16),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        LayoutBuilder(
          builder: (context, constraints) {
            final colCount = constraints.maxWidth > 900
                ? 3
                : (constraints.maxWidth > 600 ? 2 : 1);
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: colCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: _modalities.length,
              itemBuilder: (context, index) {
                final mod = _modalities[index];
                final id = mod['id'] as String;
                final name = mod['name'] as String;
                final status = mod['status'] as String;
                final statusColor = mod['statusColor'] as Color;
                final workload = mod['workload'] as int;
                final ping = mod['ping'] as String;
                final location = mod['location'] as String;
                final queue = mod['queue'] as int;
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                id,
                                style: AppTextStyles.labelSmall.copyWith(
                                  color: AppColors.secondaryText,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                name,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Modality load',
                                style: AppTextStyles.bodySmall,
                              ),
                              Text(
                                '$workload%',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: workload / 100.0,
                            backgroundColor: AppColors.background,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              statusColor,
                            ),
                            minHeight: 4,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _stat('Ping', ping),
                          _stat('Location', location.split(' ').first),
                          _stat('Dicom Queue', '$queue Jobs'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _stat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 8),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextStyles.labelSmall.copyWith(
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }
}
