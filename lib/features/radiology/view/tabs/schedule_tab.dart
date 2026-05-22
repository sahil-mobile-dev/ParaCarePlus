import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  String _selectedModality = 'MRI-01 (Tesla 3T)';
  String _selectedTimeSlot = '10:30 AM - 11:00 AM';

  final List<String> _modalities = [
    'MRI-01 (Tesla 3T)',
    'MRI-02 (Tesla 1.5T)',
    'CT-01 (128 Slice)',
    'CT-02 (Dual Source)',
    'XR-01 (Digital X-Ray)',
    'USG-01 (4D Doppler)',
  ];

  final List<Map<String, dynamic>> _slots = [
    {
      'time': '09:00 AM - 09:30 AM',
      'status': 'Occupied',
      'patient': 'Rahul Roy',
    },
    {
      'time': '09:30 AM - 10:00 AM',
      'status': 'Occupied',
      'patient': 'Anita Sen',
    },
    {
      'time': '10:00 AM - 10:30 AM',
      'status': 'Maintenance',
      'patient': 'Hardware Calibration',
    },
    {'time': '10:30 AM - 11:00 AM', 'status': 'Available', 'patient': ''},
    {'time': '11:00 AM - 11:30 AM', 'status': 'Available', 'patient': ''},
    {
      'time': '11:30 AM - 12:00 PM',
      'status': 'Occupied',
      'patient': 'Devi Prasad',
    },
    {'time': '12:00 PM - 12:30 PM', 'status': 'Available', 'patient': ''},
    {'time': '12:30 PM - 01:00 PM', 'status': 'Available', 'patient': ''},
    {
      'time': '01:00 PM - 01:30 PM',
      'status': 'Break',
      'patient': 'Lunch Recess',
    },
    {'time': '01:30 PM - 02:00 PM', 'status': 'Available', 'patient': ''},
  ];

  void _bookSlot() {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController();
        final mrnController = TextEditingController();
        return Dialog(
          backgroundColor: AppColors.card,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Schedule Scanner Slot',
                      style: AppTextStyles.titleSmall,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.secondaryText,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(color: AppColors.border, height: 1),
                const SizedBox(height: 16),
                Text(
                  'Device: $_selectedModality',
                  style: AppTextStyles.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  'Time: $_selectedTimeSlot',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.secondaryAccent,
                  ),
                ),
                const SizedBox(height: 16),
                _buildField(
                  'Patient Name',
                  'e.g. Gurpreet Singh',
                  nameController,
                ),
                const SizedBox(height: 12),
                _buildField('Patient MRN', 'e.g. MRN-9182', mrnController),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        foregroundColor: AppColors.secondaryText,
                      ),
                      child: const Text('CANCEL'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty) return;
                        setState(() {
                          final idx = _slots.indexWhere(
                            (s) => s['time'] == _selectedTimeSlot,
                          );
                          if (idx != -1) {
                            _slots[idx]['status'] = 'Occupied';
                            _slots[idx]['patient'] = nameController.text;
                          }
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.success,
                            content: Text(
                              'Scheduled $_selectedModality for ${nameController.text} successfully!',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('SCHEDULE SCAN'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildField(
    String label,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.secondaryText, fontSize: 11),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: controller,
            style: AppTextStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
              ),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDevicesList(),
        const SizedBox(height: AppSpacing.xxl),
        _buildSlotsGrid(),
      ],
    );
  }

  Widget _buildDevicesList() {
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
          const Row(
            children: [
              Icon(
                Icons.settings_remote_rounded,
                color: AppColors.primary,
                size: 20,
              ),
              SizedBox(width: 8),
              Text('Available Scanners', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 8),
          ..._modalities.map((device) {
            final isSelected = _selectedModality == device;
            return InkWell(
              onTap: () => setState(() => _selectedModality = device),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryLight
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      device.contains('MRI')
                          ? Icons.biotech_outlined
                          : (device.contains('CT')
                                ? Icons.adjust_rounded
                                : Icons.camera_alt_outlined),
                      color: isSelected
                          ? Colors.white
                          : AppColors.secondaryText,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        device,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSlotsGrid() {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Daily Slot Grid',
                    style: AppTextStyles.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _selectedModality,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryAccent,
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _bookSlot,
                icon: const Icon(Icons.add_rounded, size: 16),
                label: const Text('Book Custom Scan Slot'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _slots.length,
            itemBuilder: (context, index) {
              final slot = _slots[index];
              final time = slot['time'] as String;
              final status = slot['status'] as String;
              final patient = slot['patient'] as String;

              Color statusBgColor;
              Color statusTextColor;
              IconData statusIcon;

              switch (status) {
                case 'Available':
                  statusBgColor = AppColors.success.withValues(alpha: 0.1);
                  statusTextColor = AppColors.success;
                  statusIcon = Icons.check_circle_outline_rounded;
                case 'Occupied':
                  statusBgColor = AppColors.primary.withValues(alpha: 0.1);
                  statusTextColor = AppColors.primaryLight;
                  statusIcon = Icons.person_rounded;
                case 'Maintenance':
                  statusBgColor = AppColors.error.withValues(alpha: 0.1);
                  statusTextColor = AppColors.error;
                  statusIcon = Icons.build_rounded;
                default:
                  statusBgColor = Colors.grey.withValues(alpha: 0.1);
                  statusTextColor = Colors.grey;
                  statusIcon = Icons.coffee_rounded;
              }

              final isSelected = _selectedTimeSlot == time;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.secondaryAccent
                        : AppColors.border,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      time,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, size: 10, color: statusTextColor),
                          const SizedBox(width: 4),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusTextColor,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        patient.isEmpty ? '--' : patient,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: patient.isEmpty
                              ? AppColors.secondaryText
                              : AppColors.primaryText,
                          fontStyle: patient.isEmpty
                              ? FontStyle.italic
                              : FontStyle.normal,
                        ),
                      ),
                    ),
                    if (status == 'Available')
                      IconButton(
                        icon: const Icon(
                          Icons.bookmark_add_rounded,
                          color: AppColors.secondaryAccent,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() => _selectedTimeSlot = time);
                          _bookSlot();
                        },
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
