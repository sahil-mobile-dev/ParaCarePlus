import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/features/patient/view/portal/patient_opd_booking_screen.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/opd/wizard/opd_step_details.dart';

class OpdStepConfirm extends ConsumerWidget {
  const OpdStepConfirm({
    required this.onBack,
    required this.onConfirm,
    super.key,
  });
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doc = ref.watch(selectedDoctorProvider);
    final date = ref.watch(selectedDateProvider);
    final slot = ref.watch(selectedSlotProvider);
    final patientFor = ref.watch(patientForProvider);
    final chiefComplaint = ref.watch(chiefComplaintProvider);
    final visitType = ref.watch(visitTypeProvider);
    final paymentScheme = ref.watch(paymentSchemeProvider);

    final formatStrDate = '${date.day} May 2026';

    Widget buildConfirmRow(String label, String value, {Color? valueColor}) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor ?? Colors.white,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Confirm Card
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.05),
            border: Border.all(color: AppColors.success.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              buildConfirmRow(
                'Doctor',
                '${doc?.name ?? "Dr. Anjali Sharma"} — ${doc?.specialty ?? "Cardiology"}',
              ),
              buildConfirmRow(
                'Date & Time',
                '$formatStrDate · ${slot ?? "10:30 AM"}',
                valueColor: AppColors.primaryLight,
              ),
              buildConfirmRow('Visit Type', visitType),
              buildConfirmRow('Patient', '$patientFor · UHID: UHD-2021-08421'),
              buildConfirmRow('Reason', chiefComplaint),
              buildConfirmRow(
                'Payment',
                paymentScheme.contains('AB-PMJAY')
                    ? 'AB-PMJAY (₹0 patient cost)'
                    : paymentScheme,
                valueColor: AppColors.success,
              ),
              buildConfirmRow(
                'AI Wait Estimate',
                '~12 minutes',
                valueColor: AppColors.secondaryAccent,
              ),
              buildConfirmRow(
                'Reminder',
                'SMS + WhatsApp + Portal notification',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.success,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text(
                'Confirm Appointment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Back Button
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: onBack,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
        ),
      ],
    );
  }
}
