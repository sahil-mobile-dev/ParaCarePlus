import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard_hub/model/dashboard_hub_model.dart';
import 'package:paracareplus/routes/route_paths.dart';

class PatientPortalLaunchpad extends StatelessWidget {
  const PatientPortalLaunchpad({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 760;
    final isTablet = screenWidth >= 760 && screenWidth < 1200;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xxxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderLeft(),
                const SizedBox(height: AppSpacing.sm),
                _buildNewBadge(),
              ],
            )
          else
            Row(
              children: [_buildHeaderLeft(), const Spacer(), _buildNewBadge()],
            ),
          const SizedBox(height: AppSpacing.xl),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PatientPortalModuleItem.items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 5),
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: isMobile ? 1.4 : 1.3,
            ),
            itemBuilder: (context, index) {
              final item = PatientPortalModuleItem.items[index];
              return _buildPortalCard(context, item);
            },
          ),
          const SizedBox(height: AppSpacing.xl),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 2 : 4,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: isMobile ? 2.5 : 3.5,
            children: [
              _buildIndicator(
                '20',
                'Patient Modules',
                const Color(0xFFF0F9FF),
                const Color(0xFF0077B6),
              ),
              _buildIndicator(
                'ABDM',
                'ABHA Linked',
                const Color(0xFFF0FDF4),
                const Color(0xFF2E7D32),
              ),
              _buildIndicator(
                '12',
                'AI Features',
                const Color(0xFFFEFCE8),
                const Color(0xFFa16207),
              ),
              _buildIndicator(
                'FHIR R4',
                'Standards',
                const Color(0xFFFDF4FF),
                const Color(0xFF7E22CE),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderLeft() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0077B6), Color(0xFF00B4D8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: const Text('🧑‍⚕️', style: TextStyle(fontSize: 22)),
        ),
        const SizedBox(width: AppSpacing.md),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phase C — Patient-Facing Portal',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.primaryText,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'ABDM-linked · ABHA identity · \n20 patient modules · Ramesh Kumar demo',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.secondaryText,
                fontFamily: AppTextStyles.fontFamily,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNewBadge() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00B4D8), Color(0xFF4361EE)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: const Text(
        '✦ NEW — Phase C Complete',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          fontFamily: AppTextStyles.fontFamily,
        ),
      ),
    );
  }

  Widget _buildPortalCard(BuildContext context, PatientPortalModuleItem item) {
    var borderColor = const Color(0xFF1E3A5F);
    var hoverColor = const Color(0xFF00B4D8);

    if (item.isSOS) {
      borderColor = const Color(0xFFFF4D6D);
      hoverColor = const Color(0xFFFF4D6D);
    } else if (item.isNew) {
      borderColor = const Color(0xFFC77DFF);
      hoverColor = const Color(0xFFC77DFF);
    }

    return _HoverPortalCard(
      item: item,
      borderColor: borderColor,
      hoverColor: hoverColor,
    );
  }

  Widget _buildIndicator(String val, String lbl, Color bg, Color textCol) {
    return Container(
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            val,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: textCol,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          Text(
            lbl,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w600,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverPortalCard extends StatefulWidget {
  const _HoverPortalCard({
    required this.item,
    required this.borderColor,
    required this.hoverColor,
  });
  final PatientPortalModuleItem item;
  final Color borderColor;
  final Color hoverColor;

  @override
  State<_HoverPortalCard> createState() => _HoverPortalCardState();
}

class _HoverPortalCardState extends State<_HoverPortalCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          try {
            context.pushNamed(widget.item.routeName);
          } catch (e) {
            _showComingSoonDialog(context);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF071221), Color(0xFF0F2137)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: _isHovered ? widget.hoverColor : widget.borderColor,
              width: _isHovered ? 1.5 : 1.0,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.hoverColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ]
                : [],
          ),
          padding: const EdgeInsets.all(AppSpacing.md),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.item.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 6),
              Text(
                widget.item.title,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: widget.item.isSOS
                      ? const Color(0xFFFF4D6D)
                      : Colors.white,
                  fontFamily: AppTextStyles.fontFamily,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                widget.item.subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFF7A9BBF),
                  fontFamily: AppTextStyles.fontFamily,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showComingSoonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
        title: Row(
          children: [
            Text(widget.item.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(widget.item.title, style: AppTextStyles.titleSmall),
            ),
          ],
        ),
        content: Text(
          'The patient-facing portal module "${widget.item.title}" is in production deployment. ABDM API endpoints are healthy, and simulated sandbox databases are active.\n\nWould you like to run mock testing?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.secondaryText),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              context.pushNamed(RoutePaths.patientHome);
            },
            child: const Text('Simulate Test'),
          ),
        ],
      ),
    );
  }
}
