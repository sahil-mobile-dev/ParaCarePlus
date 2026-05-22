import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EmergencyContacts extends StatelessWidget {
  const EmergencyContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.phone_in_talk_rounded, color: AppColors.error, size: 18),
            SizedBox(width: 8),
            Text('EMERGENCY QUICK CONTACTS', style: AppTextStyles.labelSmall),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Column(
          children: [
            _buildContactRow(
              context: context,
              icon: Icons.airport_shuttle_rounded,
              name: '108 Ambulance Service',
              subtitle: 'Uttarakhand Emergency · 24×7',
              dialLabel: '108',
              dialColor: AppColors.error,
              onCall: () =>
                  _showDialSnackbar(context, '108 Ambulance Service (108)'),
            ),
            const SizedBox(height: 8),
            _buildContactRow(
              context: context,
              icon: Icons.local_hospital_rounded,
              name: 'AIIMS Rishikesh ER',
              subtitle: '0135-2462945 · Emergency Dept',
              dialLabel: 'Call',
              dialColor: AppColors.primaryLight,
              onCall: () => _showDialSnackbar(
                context,
                'AIIMS Rishikesh ER (0135-2462945)',
              ),
            ),
            const SizedBox(height: 8),
            _buildContactRow(
              context: context,
              icon: Icons.family_restroom_rounded,
              name: 'Geeta Kumar (Spouse)',
              subtitle: '+91 98765 43210 · Primary Contact',
              dialLabel: 'Call',
              dialColor: AppColors.success,
              onCall: () =>
                  _showDialSnackbar(context, 'Geeta Kumar (+91 98765 43210)'),
            ),
            const SizedBox(height: 8),
            _buildContactRow(
              context: context,
              icon: Icons.star_rate_rounded,
              name: 'National Health Helpline',
              subtitle: '1800-180-1104 · Free & 24×7',
              dialLabel: 'Call',
              dialColor: AppColors.secondaryAccent,
              onCall: () => _showDialSnackbar(
                context,
                'National Health Helpline (1800-180-1104)',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showDialSnackbar(BuildContext context, String recipient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Simulating emergency call to $recipient...'),
        backgroundColor: AppColors.error,
      ),
    );
  }

  Widget _buildContactRow({
    required BuildContext context,
    required IconData icon,
    required String name,
    required String subtitle,
    required String dialLabel,
    required Color dialColor,
    required VoidCallback onCall,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: dialColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: dialColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            onPressed: onCall,
            icon: const Icon(Icons.phone_in_talk_rounded, size: 12),
            label: Text(
              dialLabel,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: dialColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
