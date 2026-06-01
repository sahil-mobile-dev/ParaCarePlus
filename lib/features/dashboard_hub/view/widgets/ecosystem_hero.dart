import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class EcosystemHero extends StatefulWidget {
  const EcosystemHero({super.key});

  @override
  State<EcosystemHero> createState() => _EcosystemHeroState();
}

class _EcosystemHeroState extends State<EcosystemHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 760;
    final isTablet = screenWidth >= 760 && screenWidth < 1200;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF071221), Color(0xFF0B1E35), Color(0xFF0D2848)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xxxl,
        vertical: AppSpacing.xxxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryLight, Color(0xFF00897B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text('⚕️', style: TextStyle(fontSize: 28)),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ParaCare+ Smart HIMS — Dashboard Ecosystem',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: isMobile ? 20 : 26,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Uttarakhand State-Level Integrated Health Intelligence Platform  ·  ABDM Compliant  ·  AI-Powered  ·  Real-Time',
                      style: TextStyle(
                        fontSize: isMobile ? 10 : 12,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              _buildBadge(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4CAF50).withValues(
                                  alpha: _pulseAnimation.value * 0.6,
                                ),
                                blurRadius: 6,
                                spreadRadius: _pulseAnimation.value * 3,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'Live Data',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              _buildBadge(text: '🔒 ABDM Compliant'),
              _buildBadge(text: '🤖 AI-Enabled'),
              _buildBadge(text: '📍 GIS-Integrated'),
              _buildBadge(text: '🏥 1,847 Facilities'),
            ],
          ),
          const SizedBox(height: AppSpacing.xxxl),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 6),
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: isMobile ? 1.5 : 1.7,
            children: const [
              _HeroStatCard('48.2L', 'Registered Patients', '↑ 12% this month'),
              _HeroStatCard('31.7L', 'ABHA Linked', '65.8% coverage'),
              _HeroStatCard('14,823', 'Daily OPD Today', '↑ 5% vs yesterday'),
              _HeroStatCard('87.4%', 'Bed Occupancy', '↑ Critical in 3 dist.'),
              _HeroStatCard(
                '₹18.4Cr',
                'AB Claims Today',
                '94.2% approval rate',
              ),
              _HeroStatCard('2,341', 'AI Alerts Active', '🔴 42 critical'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({String? text, Widget? child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child:
          child ??
          Text(
            text ?? '',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
    );
  }
}

class _HeroStatCard extends StatelessWidget {
  const _HeroStatCard(this.value, this.label, this.subtitle);
  final String value;
  final String label;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontFamily: AppTextStyles.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white54,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              fontFamily: AppTextStyles.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white38,
              fontFamily: AppTextStyles.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
