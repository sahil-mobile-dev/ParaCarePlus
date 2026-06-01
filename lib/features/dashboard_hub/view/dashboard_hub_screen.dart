import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_header.dart';
import 'package:paracareplus/features/dashboard/view/widgets/app_sidebar.dart';
import 'package:paracareplus/features/dashboard_hub/model/dashboard_hub_model.dart';
import 'package:paracareplus/features/dashboard_hub/view/widgets/alert_ticker.dart';
import 'package:paracareplus/features/dashboard_hub/view/widgets/dashboard_module_card.dart';
import 'package:paracareplus/features/dashboard_hub/view/widgets/ecosystem_hero.dart';
import 'package:paracareplus/features/dashboard_hub/view/widgets/gov_ribbon.dart';
import 'package:paracareplus/features/dashboard_hub/view/widgets/patient_portal_launchpad.dart';
import 'package:paracareplus/features/dashboard_hub/view/widgets/quick_stats_strip.dart';

class DashboardHubScreen extends ConsumerStatefulWidget {
  const DashboardHubScreen({super.key});

  @override
  ConsumerState<DashboardHubScreen> createState() => _DashboardHubScreenState();
}

class _DashboardHubScreenState extends ConsumerState<DashboardHubScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  String _selectedRole = 'all';
  final TextEditingController _searchController = TextEditingController();

  final Map<String, List<String>> _roleMap = {
    'all': ['state', 'clinical', 'ops', 'ai', 'public', 'finance'],
    'state': ['state'],
    'dg': ['state', 'public'],
    'ms': ['clinical', 'ops'],
    'cmo': ['state', 'clinical', 'public'],
    'doctor': ['clinical'],
    'sha': ['finance'],
    'ai': ['ai'],
  };

  List<DashboardModuleItem> _getFilteredModules() {
    return DashboardModuleItem.items.where((module) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          module.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          module.description.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          module.tags.any(
            (tag) => tag.toLowerCase().contains(_searchQuery.toLowerCase()),
          );

      if (!matchesSearch) return false;

      final moduleCategories = module.category.split(' ');
      final matchesCategory =
          _selectedCategory == 'all' ||
          moduleCategories.contains(_selectedCategory);

      if (!matchesCategory) return false;

      if (_selectedRole == 'all') return true;
      final allowedCatsForRole = _roleMap[_selectedRole] ?? [];
      return moduleCategories.any(allowedCatsForRole.contains);
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 1200;
    final filteredModules = _getFilteredModules();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(),
      drawer: isWideScreen ? null : const Drawer(child: AppSidebar()),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isWideScreen) const AppSidebar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GovRibbon(),
                    const EcosystemHero(),
                    const AlertTicker(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: AppSpacing.xxl,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOutbreakAlertsBanner(context),
                          const SizedBox(height: AppSpacing.lg),
                          const QuickStatsStrip(),
                          const SizedBox(height: AppSpacing.xl),
                          _buildRoleSelectorBar(),
                          const SizedBox(height: AppSpacing.lg),
                          _buildSearchAndFiltersRow(context),
                          const SizedBox(height: AppSpacing.xl),
                          _buildModulesSection(filteredModules),
                          const SizedBox(height: AppSpacing.xl),
                          _buildAccessGuideSection(),
                          const SizedBox(height: AppSpacing.xl),
                          const PatientPortalLaunchpad(),
                          const SizedBox(height: AppSpacing.xl),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutbreakAlertsBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB71C1C), Color(0xFFC62828)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '⚠️ 3 Active Health Alerts — Immediate Action Required',
                          style: AppTextStyles.labelLarge.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Dengue outbreak in Dehradun  ·  ICU overflow risk in Haridwar  ·  Medicine shortage at 7 CHCs in Pithoragarh',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                            fontFamily: AppTextStyles.fontFamily,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isMobile) const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: isMobile
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white60, width: 1.5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Opening outbreak tracking analytics...',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('View Outbreak'),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withValues(alpha: 0.15),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(color: Colors.white38),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Connecting to State Command Center telemetry...',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    child: const Text('Command Centre'),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRoleSelectorBar() {
    final roles = [
      {'id': 'all', 'label': 'All Dashboards', 'icon': '🌐'},
      {'id': 'state', 'label': 'State Secretary', 'icon': '🏛️'},
      {'id': 'dg', 'label': 'DG Health', 'icon': '👨‍⚕️'},
      {'id': 'ms', 'label': 'Medical Supt.', 'icon': '🏥'},
      {'id': 'cmo', 'label': 'CMO', 'icon': '📋'},
      {'id': 'doctor', 'label': 'Doctor', 'icon': '🩺'},
      {'id': 'sha', 'label': 'SHA / Finance', 'icon': '💊'},
      {'id': 'ai', 'label': 'AI Analytics', 'icon': '🤖'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'VIEW AS:',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.secondaryText,
              letterSpacing: 0.5,
              fontFamily: AppTextStyles.fontFamily,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: roles.map((role) {
                final isSelected = _selectedRole == role['id'];
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    avatar: Text(role['icon'] ?? ''),
                    label: Text(
                      role['label'] ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.secondaryText,
                        fontFamily: AppTextStyles.fontFamily,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedRole = role['id'] ?? 'all';
                      });
                    },
                    backgroundColor: AppColors.background,
                    selectedColor: AppColors.primary,
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.border,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFiltersRow(BuildContext context) {
    final categories = [
      {'id': 'all', 'label': 'All'},
      {'id': 'state', 'label': 'State Level'},
      {'id': 'clinical', 'label': 'Clinical'},
      {'id': 'ops', 'label': 'Operations'},
      {'id': 'ai', 'label': 'AI/Analytics'},
      {'id': 'public', 'label': 'Public Health'},
      {'id': 'finance', 'label': 'Finance'},
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 760;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isMobile) ...[
          _buildSearchField(),
          const SizedBox(height: AppSpacing.md),
          _buildCategoryScroll(categories),
        ] else
          Row(
            children: [
              Expanded(child: _buildSearchField()),
              const SizedBox(width: AppSpacing.lg),
              _buildCategoryScroll(categories),
            ],
          ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border, width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: AppColors.primaryText, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search dashboards, KPIs, modules...',
          hintStyle: const TextStyle(
            color: AppColors.secondaryText,
            fontSize: 13,
          ),
          icon: const Icon(
            Icons.search_rounded,
            color: AppColors.secondaryText,
          ),
          border: InputBorder.none,
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: AppColors.secondaryText,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
              : null,
        ),
        onChanged: (val) {
          setState(() {
            _searchQuery = val;
          });
        },
      ),
    );
  }

  Widget _buildCategoryScroll(List<Map<String, String>> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat['id'];
          return Container(
            margin: const EdgeInsets.only(right: 6),
            child: ChoiceChip(
              label: Text(
                cat['label'] ?? '',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.secondaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = cat['id'] ?? 'all';
                });
              },
              backgroundColor: AppColors.surface,
              selectedColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.border,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildModulesSection(List<DashboardModuleItem> filteredModules) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 500;
    final isTablet = screenWidth >= 500 && screenWidth < 900;
    final isDesktop = screenWidth >= 900 && screenWidth < 1400;
    final columns = isMobile ? 1 : (isTablet ? 2 : (isDesktop ? 3 : 4));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: const Text('🏛️', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Ecosystem Dashboards & Modules',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primaryText,
                    fontFamily: AppTextStyles.fontFamily,
                  ),
                ),
              ],
            ),
            Text(
              'Showing ${filteredModules.length} of ${DashboardModuleItem.items.length}',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (filteredModules.isEmpty)
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_off_rounded,
                    color: AppColors.secondaryText,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No matching dashboards found',
                    style: AppTextStyles.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try modifying your search or resetting category filters.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredModules.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.05,
            ),
            itemBuilder: (context, index) {
              final module = filteredModules[index];
              return DashboardModuleCard(module: module);
            },
          ),
      ],
    );
  }

  Widget _buildAccessGuideSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 760;
    final isTablet = screenWidth >= 760 && screenWidth < 1200;

    final guides = [
      {
        'icon': '🏛️',
        'role': 'State Health Secretary',
        'desc':
            'State Command Centre · Disease Surveillance · AB Claims · Finance · AI Intelligence',
      },
      {
        'icon': '👨‍⚕️',
        'role': 'DG Health / NHM',
        'desc':
            'State Command Centre · MCH · Disease Surveillance · ABDM · Workforce · Onboarding',
      },
      {
        'icon': '🏥',
        'role': 'Medical Superintendent',
        'desc':
            'Hospital Performance · OPD Analytics · IPD Beds · Emergency · HR · Finance · Pharmacy',
      },
      {
        'icon': '📋',
        'role': 'CMO / District',
        'desc':
            'State Admin · Disease Surveillance · MCH · OPD · IPD · Ambulance · AB Claims',
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: const Text('👥', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(width: 10),
              const Text(
                'Role-Based Dashboard Access Guide',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryText,
                  fontFamily: AppTextStyles.fontFamily,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: isMobile ? 3.5 : 2.0,
            children: guides.map((guide) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.background.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          guide['icon'] ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            guide['role'] ?? '',
                            style: AppTextStyles.labelLarge.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      child: Text(
                        guide['desc'] ?? '',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.secondaryText,
                          height: 1.4,
                          fontFamily: AppTextStyles.fontFamily,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.black.withValues(alpha: 0.3),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: const Column(
        children: [
          Text(
            'ParaCare+ Smart HIMS v5.0 — Uttarakhand State Health Intelligence Platform',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              fontFamily: AppTextStyles.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            '© 2026 Government of Uttarakhand, Department of Health & Family Welfare  |  NHM  |  NIC Uttarakhand  |  ABDM Compliant  |  ISO 27001',
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.white30,
              fontFamily: AppTextStyles.fontFamily,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: AppSpacing.md,
            alignment: WrapAlignment.center,
            children: [
              _FooterTag('🔒 AES-256 Encrypted'),
              Text('|', style: TextStyle(color: Colors.white10)),
              _FooterTag('FHIR R4 Compliant'),
              Text('|', style: TextStyle(color: Colors.white10)),
              _FooterTag('40+ Dashboard Modules'),
              Text('|', style: TextStyle(color: Colors.white10)),
              _FooterTag('20 Patient Portal Pages'),
              Text('|', style: TextStyle(color: Colors.white10)),
              _FooterTag('1,847 Facilities'),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterTag extends StatelessWidget {
  const _FooterTag(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11,
        color: Colors.white38,
        fontFamily: AppTextStyles.fontFamily,
      ),
    );
  }
}
