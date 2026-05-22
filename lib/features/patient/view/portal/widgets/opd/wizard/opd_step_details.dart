import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

// State providers for Form Details
final patientForProvider = StateProvider<String>(
  (ref) => 'Self (Rahul Kumar Sharma)',
);
final chiefComplaintProvider = StateProvider<String>(
  (ref) =>
      'Routine cardiology follow-up. BP monitoring. Review of Amlodipine + Losartan therapy.',
);
final visitTypeProvider = StateProvider<String>((ref) => 'In-Person OPD');
final paymentSchemeProvider = StateProvider<String>(
  (ref) => 'AB-PMJAY (Ayushman Bharat)',
);
final recordShareConsentProvider = StateProvider<String>(
  (ref) => 'Share last 3 visits + current prescriptions',
);

class OpdStepDetails extends ConsumerWidget {
  const OpdStepDetails({required this.onBack, required this.onNext, super.key});
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientFor = ref.watch(patientForProvider);
    final chiefComplaint = ref.watch(chiefComplaintProvider);
    final visitType = ref.watch(visitTypeProvider);
    final paymentScheme = ref.watch(paymentSchemeProvider);
    final recordShareConsent = ref.watch(recordShareConsentProvider);

    final isWide = MediaQuery.of(context).size.width > 600;

    Widget buildFormField({required String label, required Widget child}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.secondaryText,
              ),
            ),
            const SizedBox(height: 6),
            child,
          ],
        ),
      );
    }

    Widget buildLeftColumn() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Patient Name (read-only)
          buildFormField(
            label: 'Patient Name',
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Rahul Kumar Sharma',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 13),
              ),
            ),
          ),

          // Patient For
          buildFormField(
            label: 'Patient for',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: patientFor,
                  dropdownColor: AppColors.surface,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryText,
                  ),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(patientForProvider.notifier).state = val;
                    }
                  },
                  items:
                      [
                        'Self (Rahul Kumar Sharma)',
                        'Priya Sharma (Spouse)',
                        'Aarav (Son, 8yr)',
                      ].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),

          // Chief Complaint
          buildFormField(
            label: 'Chief Complaint / Reason for Visit',
            child: TextField(
              maxLines: 3,
              style: const TextStyle(color: Colors.white, fontSize: 13),
              controller: TextEditingController(text: chiefComplaint)
                ..selection = TextSelection.fromPosition(
                  TextPosition(offset: chiefComplaint.length),
                ),
              onChanged: (val) {
                ref.read(chiefComplaintProvider.notifier).state = val;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.all(12),
                hintText: 'Describe your symptoms or reason for visit...',
                hintStyle: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget buildRightColumn() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visit Type
          buildFormField(
            label: 'Visit Type',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: visitType,
                  dropdownColor: AppColors.surface,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryText,
                  ),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(visitTypeProvider.notifier).state = val;
                    }
                  },
                  items:
                      [
                        'In-Person OPD',
                        'Teleconsultation (Video)',
                        'Teleconsultation (Audio)',
                        'Home Visit',
                      ].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),

          // Insurance / Payment
          buildFormField(
            label: 'Insurance / Payment',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: paymentScheme,
                  dropdownColor: AppColors.surface,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryText,
                  ),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(paymentSchemeProvider.notifier).state = val;
                    }
                  },
                  items:
                      [
                        'AB-PMJAY (Ayushman Bharat)',
                        'State Scheme (UK-BJP)',
                        'Self Pay — Cash',
                        'Online Payment (UPI/Card)',
                      ].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),

          // Share Records
          buildFormField(
            label: 'Share Records with Doctor',
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: recordShareConsent,
                  dropdownColor: AppColors.surface,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondaryText,
                  ),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  onChanged: (val) {
                    if (val != null) {
                      ref.read(recordShareConsentProvider.notifier).state = val;
                    }
                  },
                  items:
                      [
                        'Share last 3 visits + current prescriptions',
                        'Share full medical history (ABDM consent)',
                        "Share only today's vitals",
                        'Do not share (anonymous)',
                      ].map((val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: buildLeftColumn()),
              const SizedBox(width: 20),
              Expanded(child: buildRightColumn()),
            ],
          )
        else ...[
          buildLeftColumn(),
          buildRightColumn(),
        ],
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton.icon(
              onPressed: onBack,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.secondaryText,
                size: 16,
              ),
              label: const Text(
                'Back',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              icon: const Text(
                'Review & Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              label: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
