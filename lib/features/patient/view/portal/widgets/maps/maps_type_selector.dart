import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class MapsTypeSelector extends StatelessWidget {
  const MapsTypeSelector({
    required this.selectedType,
    required this.onTypeSelect,
    super.key,
  });

  final String selectedType;
  final void Function(String) onTypeSelect;

  static const _types = [
    {'key': 'hospitals', 'emoji': '🏥', 'label': 'Nearest Hospitals'},
    {'key': 'pharmacy', 'emoji': '💊', 'label': 'Pharmacies'},
    {'key': 'labs', 'emoji': '🔬', 'label': 'Diagnostic Labs'},
    {'key': 'blood', 'emoji': '🩸', 'label': 'Blood Banks'},
    {'key': 'ambulance', 'emoji': '🚑', 'label': 'Ambulance Live'},
    {'key': 'vaccination', 'emoji': '💉', 'label': 'Vaccination Centres'},
    {'key': 'doctors', 'emoji': '👨‍⚕️', 'label': 'Specialist Doctors'},
    {'key': 'route', 'emoji': '🗺️', 'label': 'Hospital Route'},
    {'key': 'disease', 'emoji': '🦠', 'label': 'Disease Heatmap'},
    {'key': 'abha', 'emoji': '🪪', 'label': 'ABHA Enrolment'},
    {'key': 'indoor', 'emoji': '🏢', 'label': 'Hospital Indoor'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Select Map View — 11 GIS Modules',
              style: TextStyle(
                color: AppColors.primaryText,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _types.map((t) {
            final isActive = selectedType == t['key'];
            return GestureDetector(
              onTap: () => onTypeSelect(t['key']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 100,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? AppColors.primaryLight.withValues(alpha: 0.1)
                      : AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isActive ? AppColors.primaryLight : AppColors.border,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(t['emoji']!, style: const TextStyle(fontSize: 20)),
                    const SizedBox(height: 6),
                    Text(
                      t['label']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isActive
                            ? AppColors.primaryLight
                            : AppColors.secondaryText,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
