import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AbdmStandardsPanel extends StatelessWidget {
  const AbdmStandardsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = 3;
    if (width < 700) {
      crossAxisCount = 1;
    } else if (width < 1100) {
      crossAxisCount = 2;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .80,
                child: const Text(
                  'Clinical Standards — FHIR R4 · SNOMED CT · ICD-10/11 · HL7',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 260,
            ),
            children: [_buildFhirCard(), _buildSnomedCard(), _buildIcdCard()],
          ),
        ],
      ),
    );
  }

  Widget _buildFhirCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF132640),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('💻', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 6),
                  Text(
                    'FHIR R4 Resources',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              _buildTag('HL7 FHIR', const Color(0xFF7C3AED)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0x1FFFFFFF), height: 1),
          _buildStatRow('Patient Resource', 'Active', isPill: true),
          _buildStatRow('Observation', 'Active', isPill: true),
          _buildStatRow('DiagnosticReport', 'Active', isPill: true),
          _buildStatRow('MedicationRequest', 'Active', isPill: true),
          _buildStatRow(
            'Immunization',
            'Partial',
            isPill: true,
            pillColor: AppColors.secondaryAccent,
          ),
          _buildStatRow('Encounter Resource', 'Active', isPill: true),
          _buildStatRow(
            'Bundle Exchanges Today',
            '2,34,817',
            valColor: const Color(0xFF00B4D8),
          ),
        ],
      ),
    );
  }

  Widget _buildSnomedCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF132640),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('📘', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 6),
                  Text(
                    'SNOMED CT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              _buildTag('SNOMED CT', const Color(0xFF00B4D8)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0x1FFFFFFF), height: 1),
          _buildStatRow('Total Concepts Mapped', '48,312'),
          _buildStatRow('Clinical Findings', '18,420'),
          _buildStatRow('Procedures', '12,180'),
          _buildStatRow('Organisms', '4,320'),
          _buildStatRow('Body Structures', '7,840'),
          _buildStatRow(
            'OPD DX Coverage',
            '73.4%',
            valColor: const Color(0xFF00B4D8),
          ),
          _buildStatRow('Last Update', 'May 2025'),
        ],
      ),
    );
  }

  Widget _buildIcdCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF132640),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('🔢', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 6),
                  Text(
                    'ICD-10 / ICD-11',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              _buildTag('ICD Codes', const Color(0xFF00C897)),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: Color(0x1FFFFFFF), height: 1),
          _buildStatRow('ICD-10 Codes Active', '14,302'),
          _buildStatRow(
            'ICD-11 Migration %',
            '31.4%',
            valColor: AppColors.secondaryAccent,
          ),
          _buildStatRow('Diagnoses Tagged (MTD)', '4,12,840'),
          _buildStatRow(
            'Uncodified Diagnoses',
            '18.2%',
            valColor: AppColors.secondaryAccent,
          ),
          _buildStatRow('AI Auto-code', 'Active', isPill: true),
          _buildStatRow('NCD Coverage', '89.3%', valColor: AppColors.success),
          _buildStatRow(
            'Communicable Disease',
            '94.7%',
            valColor: AppColors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value, {
    bool isPill = false,
    Color? pillColor,
    Color? valColor,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.secondaryText,
                fontSize: 10,
              ),
            ),
            isPill
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: (pillColor ?? AppColors.success).withValues(
                        alpha: 0.15,
                      ),
                      border: Border.all(
                        color: (pillColor ?? AppColors.success).withValues(
                          alpha: 0.3,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        color: pillColor ?? AppColors.success,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Text(
                    value,
                    style: TextStyle(
                      color: valColor ?? Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
