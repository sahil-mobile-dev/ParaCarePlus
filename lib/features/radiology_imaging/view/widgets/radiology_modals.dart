import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

import 'package:paracareplus/features/radiology_imaging/model/radiology_imaging_model.dart';
import 'package:paracareplus/features/radiology_imaging/view_model/radiology_imaging_view_model.dart';

class RadiologyNewOrderModal extends ConsumerStatefulWidget {
  const RadiologyNewOrderModal({super.key});

  @override
  ConsumerState<RadiologyNewOrderModal> createState() => _RadiologyNewOrderModalState();
}

class _RadiologyNewOrderModalState extends ConsumerState<RadiologyNewOrderModal> {
  final _patientController = TextEditingController();
  final _ageController = TextEditingController();
  final _doctorController = TextEditingController();
  final _examController = TextEditingController();
  String _modality = 'X-Ray';
  String _priority = 'Routine';
  final String _ward = 'OPD';

  @override
  void dispose() {
    _patientController.dispose();
    _ageController.dispose();
    _doctorController.dispose();
    _examController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Row(
        children: [
          Icon(Icons.add_circle_outline, color: AppColors.primaryLight),
          SizedBox(width: 8),
          Text('New Radiology Order', style: TextStyle(color: Colors.white)),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _patientController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _ageController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Age / Sex (e.g., 35/M)',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _doctorController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Referred By',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              TextField(
                controller: _examController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Examination',
                  labelStyle: TextStyle(color: AppColors.secondaryText),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.border)),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Modality:', style: TextStyle(color: AppColors.secondaryText)),
                  DropdownButton<String>(
                    dropdownColor: AppColors.surface,
                    value: _modality,
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(value: 'X-Ray', child: Text('X-Ray')),
                      DropdownMenuItem(value: 'CT Scan', child: Text('CT Scan')),
                      DropdownMenuItem(value: 'MRI', child: Text('MRI')),
                      DropdownMenuItem(value: 'Ultrasound', child: Text('Ultrasound')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _modality = val);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Priority:', style: TextStyle(color: AppColors.secondaryText)),
                  DropdownButton<String>(
                    dropdownColor: AppColors.surface,
                    value: _priority,
                    style: const TextStyle(color: Colors.white),
                    items: const [
                      DropdownMenuItem(value: 'Routine', child: Text('Routine')),
                      DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
                      DropdownMenuItem(value: 'STAT', child: Text('STAT')),
                    ],
                    onChanged: (val) {
                      if (val != null) setState(() => _priority = val);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: AppColors.secondaryText)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
          onPressed: () {
            if (_patientController.text.isNotEmpty) {
              final newOrder = RadiologyOrderItem(
                accession: 'RAD-00${ref.read(radiologyImagingProvider).worklist.length + 1}',
                patient: _patientController.text,
                ageSex: _ageController.text,
                modality: _modality,
                examination: _examController.text.isNotEmpty ? _examController.text : 'CXR PA View',
                orderedBy: _doctorController.text.isNotEmpty ? _doctorController.text : 'Dr. Sharma',
                wardOpd: _ward,
                priority: _priority,
                status: 'Ordered',
                time: '11:30',
              );
              ref.read(radiologyImagingProvider.notifier).addOrder(newOrder);
            }
            Navigator.of(context).pop();
          },
          child: const Text('Place Order', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
