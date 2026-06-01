import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/routes/route_paths.dart';

class GovRibbon extends StatelessWidget {
  const GovRibbon({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 760;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFF6900), // Saffron
            Color(0xFFFF9D00), // Gold-orange
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: 6,
      ),
      child: isMobile
          ? Column(
              children: [
                _buildGovText(),
                const SizedBox(height: 4),
                _buildLinks(context),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildGovText(), _buildLinks(context)],
            ),
    );
  }

  Widget _buildGovText() {
    return const Text(
      '🏛️ उत्तराखण्ड सरकार — Government of Uttarakhand | Health & Family Welfare | NHM | ABDM',
      style: TextStyle(
        fontSize: 11,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: AppTextStyles.fontFamily,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLinks(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.md,
      alignment: WrapAlignment.center,
      children: [
        _buildLinkBtn(
          context,
          '← Secure Login',
          onTap: () {
            context.go(RoutePaths.login);
          },
        ),
        const Text('|', style: TextStyle(color: Colors.white60, fontSize: 11)),
        _buildLinkBtn(
          context,
          'Command Centre',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Navigating to Live command centre...'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        const Text('|', style: TextStyle(color: Colors.white60, fontSize: 11)),
        const Text(
          'Helpline: 104',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ],
    );
  }

  Widget _buildLinkBtn(
    BuildContext context,
    String label, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          fontFamily: AppTextStyles.fontFamily,
        ),
      ),
    );
  }
}
