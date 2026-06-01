import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';

class EmergencyMedicalCard extends StatelessWidget {
  const EmergencyMedicalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFF4D6D).withValues(alpha: 0.3),
          width: 2,
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A0010), Color(0xFF2A0015)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        color: AppColors.error,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'EMERGENCY MEDICAL CARD',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Shared automatically with receiving ER on SOS trigger',
                    style: TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              // QR Code representation
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.qr_code_2_rounded,
                  color: Colors.white70,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: constraints.maxWidth > 600 ? 2.1 : 2.3,
                children: [
                  _buildCardItem('Full Name', 'Ramesh Kumar'),
                  _buildCardItem('DOB / Age', '12 Mar 1978 / 48 yrs'),
                  _buildCardItem(
                    'Blood Group',
                    'B+',
                    valueColor: AppColors.error,
                  ),
                  _buildCardItem('ABHA Number', '43-8912-3456-7890'),
                  _buildCardItem('Conditions', 'HTN, Pre-DM, Hyperlipidemia'),
                  _buildCardItem(
                    'Allergies',
                    'Penicillin (Anaphylaxis)',
                    valueColor: AppColors.error,
                  ),
                  _buildCardItem(
                    'Current Meds',
                    'Amlodipine 5mg, Metformin 500mg, Atorvastatin',
                  ),
                  _buildCardItem(
                    'Emergency Contact',
                    'Geeta Kumar +91 98765 43210',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: valueColor ?? Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
