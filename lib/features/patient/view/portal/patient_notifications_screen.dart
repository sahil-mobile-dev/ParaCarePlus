import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/notifications/notification_card.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/notifications/notifications_kpis.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/notifications/notifications_side_panel.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

class PatientNotificationsScreen extends ConsumerStatefulWidget {
  const PatientNotificationsScreen({super.key});

  @override
  ConsumerState<PatientNotificationsScreen> createState() =>
      _PatientNotificationsScreenState();
}

class _PatientNotificationsScreenState
    extends ConsumerState<PatientNotificationsScreen> {
  String _activeFilter = 'all';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  late List<NotificationData> _notifications;

  @override
  void initState() {
    super.initState();
    _notifications = _buildNotifications();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<NotificationData> _buildNotifications() {
    return [
      const NotificationData(
        title: 'Blood Pressure Alert — Hypertensive Range',
        badge: 'CRITICAL',
        text:
            'Your BP reading of 158/96 mmHg recorded at 07:14 AM today exceeds the hypertensive crisis threshold. This is the 3rd consecutive elevated reading this week. Immediate action required — contact Dr. Rajesh Sharma or visit emergency OPD.',
        time: 'Today, 07:14 AM',
        icon: Icons.favorite_rounded,
        severity: NotifSeverity.critical,
        category: 'critical',
        isUnread: true,
        actions: ['Call Doctor', 'View Trend'],
      ),
      const NotificationData(
        title: 'Critical Lab Result — HbA1c 7.2%',
        badge: 'CRITICAL',
        text:
            'Your HbA1c result (7.2%) from AIIMS Rishikesh dated 12-May-2026 has crossed the diabetic threshold (≥6.5%). Previous value was 6.1% — a significant rise of +1.1%. Endocrinology review urgently required.',
        time: 'Yesterday, 04:45 PM',
        icon: Icons.biotech_rounded,
        severity: NotifSeverity.critical,
        category: 'critical lab',
        isUnread: true,
        actions: ['Book Consult', 'View Report'],
      ),
      const NotificationData(
        title: 'Missed Medication — Metformin 500mg',
        badge: 'WARNING',
        text:
            'You missed your evening dose of Metformin 500mg (scheduled 08:00 PM). This is the 2nd missed dose this week. Medication adherence drops to 71% — below the 85% target.',
        time: 'Yesterday, 08:15 PM',
        icon: Icons.medication_liquid_rounded,
        severity: NotifSeverity.warning,
        category: 'medication',
        isUnread: true,
        actions: ['Mark Taken', 'Skip'],
      ),
      const NotificationData(
        title: 'Appointment Reminder — Orthopaedics Tomorrow',
        badge: 'REMINDER',
        text:
            'Your appointment with Dr. Meena Verma (Orthopaedics) is scheduled for tomorrow, 16-May-2026 at 10:30 AM, Room 214, OPD Block B. Please bring previous X-Ray reports and MRI films. Arrive 15 mins early.',
        time: 'Today, 08:00 AM',
        icon: Icons.calendar_month_rounded,
        severity: NotifSeverity.warning,
        category: 'appointment',
        isUnread: true,
        actions: ['Confirm', 'Reschedule', 'Add to Calendar'],
      ),
      const NotificationData(
        title: 'Refill Alert — Amlodipine 5mg Running Low',
        badge: 'REFILL',
        text:
            'Only 3 tablets of Amlodipine 5mg remaining. At your current dose (1 tablet OD), you have 3 days of supply left. Order a refill immediately to avoid treatment interruption.',
        time: 'Today, 09:30 AM',
        icon: Icons.local_pharmacy_outlined,
        severity: NotifSeverity.warning,
        category: 'medication',
        isUnread: true,
        actions: ['Order Refill', 'Snooze 2 days'],
      ),
      const NotificationData(
        title: 'AI Health Alert — T2D Risk Spike Detected',
        badge: 'AI ALERT',
        text:
            'ParaCare AI has detected a significant increase in your Type 2 Diabetes 5-year risk score — from 52% to 68% over the past 30 days. Key drivers: FBG trending up (+8 mg/dL), activity declining (-34%), and 3 consecutive poor sleep nights.',
        time: 'Today, 09:00 AM',
        icon: Icons.smart_toy_outlined,
        severity: NotifSeverity.ai,
        category: 'ai',
        isUnread: true,
        actions: ['View AI Plan', 'Acknowledge'],
      ),
      const NotificationData(
        title: 'AI Mental Health Check-In',
        badge: 'AI WELLNESS',
        text:
            'Your PHQ-2 score this week is 4/6 — possible mild-moderate depression. AI detected: reduced activity, irregular sleep pattern, and 40% fewer wellness log entries compared to last month.',
        time: 'Today, 10:00 AM',
        icon: Icons.psychology_rounded,
        severity: NotifSeverity.ai,
        category: 'ai',
        isUnread: true,
        actions: ['Talk to MedBot', 'Book Counselling'],
      ),
      const NotificationData(
        title: 'Lab Report Ready — CBC + LFT',
        badge: 'READY',
        text:
            'Your Complete Blood Count and Liver Function Test reports from 10-May-2026 are now available. All CBC parameters are within normal range. ALT slightly elevated at 48 U/L. Report shared with Dr. Rajesh Sharma via ABDM Health Locker.',
        time: '3 days ago',
        icon: Icons.assignment_outlined,
        severity: NotifSeverity.success,
        category: 'lab',
        actions: ['View Report', 'Download'],
      ),
      const NotificationData(
        title: 'Appointment Confirmed — Cardiology Follow-up',
        badge: 'CONFIRMED',
        text:
            'Your follow-up appointment with Dr. Priya Nair (Cardiology) has been confirmed for 22-May-2026 at 11:00 AM. Token #C-47 has been assigned. You can check-in online 1 hour before appointment time.',
        time: '5 days ago',
        icon: Icons.check_circle_outline_rounded,
        severity: NotifSeverity.success,
        category: 'appointment',
        actions: ['View Token', 'Add Calendar'],
      ),
      const NotificationData(
        title: 'Radiology Report Available — Knee X-Ray (Bilateral)',
        badge: 'NEW REPORT',
        text:
            'Bilateral knee X-Ray taken 08-May-2026 report is now available. Findings: Mild joint space narrowing (Grade 1 OA) in right knee. Left knee — normal. Dr. Meena Verma has been notified. AI analysis confidence: 94.2%.',
        time: '1 week ago',
        icon: Icons.image_outlined,
        severity: NotifSeverity.info,
        category: 'lab',
        actions: ['View Images', 'Share'],
      ),
      const NotificationData(
        title: 'Weekly AI Health Summary — 5–11 May 2026',
        badge: 'WEEKLY REPORT',
        text:
            'AI summary: BP average improved +4 mmHg ✓ · Steps up 12% ✓ · HbA1c concern flagged ✗ · Sleep quality 4.8/10 ✗ · Medication adherence: 78% — target 85% ✗. Overall wellness trend: Stable with 2 areas of concern.',
        time: '4 days ago',
        icon: Icons.analytics_outlined,
        severity: NotifSeverity.ai,
        category: 'ai',
        actions: ['Full Report'],
      ),
    ];
  }

  List<NotificationData> get _filteredNotifications {
    return _notifications.where((n) {
      final matchesFilter =
          _activeFilter == 'all' ||
          (_activeFilter == 'unread'
              ? n.isUnread
              : n.category.contains(_activeFilter));
      final matchesSearch =
          _searchQuery.isEmpty ||
          n.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          n.text.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();
  }

  int get _unreadCount => _notifications.where((n) => n.isUnread).length;

  void _markAllRead() {
    setState(() {
      _notifications = _notifications
          .map((n) => n.copyWith(isUnread: false))
          .toList();
    });
  }

  void _dismissNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  void _handleAction(String action) {
    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(action),
        backgroundColor: AppColors.surface,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotifications;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientNotifications,
      ),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.notifications_active_outlined,
              color: AppColors.primaryLight,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Text(
              'Notifications & Alerts',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_unreadCount Unread',
                style: const TextStyle(
                  color: AppColors.error,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        actions: [
          _AppBarBtn(
            label: 'Mark All Read',
            icon: Icons.done_all_rounded,
            onTap: _markAllRead,
          ),
          const SizedBox(width: 8),
          _AppBarBtn(
            label: 'Preferences',
            icon: Icons.settings_outlined,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _AppBarBtn(
            label: 'Clear All',
            icon: Icons.delete_outline_rounded,
            isDestructive: true,
            onTap: () {
              setState(() => _notifications.clear());
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // KPI Row
              const NotificationsKpis(),
              const SizedBox(height: AppSpacing.md),

              // Main content 2-col
              SizedBox(
                width: 290,
                child: NotificationsSidePanel(
                  onCategoryFilter: (cat) =>
                      setState(() => _activeFilter = cat),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppSpacing.md),
                  _FilterBar(
                    activeFilter: _activeFilter,
                    unreadCount: _unreadCount,
                    searchController: _searchController,
                    onFilterChange: (f) => setState(() => _activeFilter = f),
                    onSearch: (q) => setState(() => _searchQuery = q),
                  ),

                  const SizedBox(height: 14),
                  ...filtered.asMap().entries.map((e) {
                    final idx = _notifications.indexOf(filtered[e.key]);
                    return NotificationCard(
                      key: ValueKey(idx),
                      data: filtered[e.key],
                      onAction: _handleAction,
                      onDismiss: () {
                        if (idx >= 0) _dismissNotification(idx);
                      },
                    );
                  }),
                  if (filtered.isEmpty) _EmptyState(filter: _activeFilter),
                  const SizedBox(height: 14),
                  // Pagination stub
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [1, 2, 3, 5].map((n) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: n == 1
                              ? AppColors.primaryLight.withValues(alpha: 0.15)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: n == 1
                                ? AppColors.primaryLight
                                : AppColors.border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '$n',
                            style: TextStyle(
                              color: n == 1
                                  ? AppColors.primaryLight
                                  : AppColors.secondaryText,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(width: 16),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────── Local Widgets ───────────────────────

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.activeFilter,
    required this.unreadCount,
    required this.searchController,
    required this.onFilterChange,
    required this.onSearch,
  });

  final String activeFilter;
  final int unreadCount;
  final TextEditingController searchController;
  final void Function(String) onFilterChange;
  final void Function(String) onSearch;

  static const _filters = [
    ('all', 'All'),
    ('unread', 'Unread'),
    ('critical', 'Critical'),
    ('medication', 'Medication'),
    ('appointment', 'Appointment'),
    ('lab', 'Lab'),
    ('ai', 'AI Alerts'),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ..._filters.map((f) {
          final isActive = activeFilter == f.$1;
          return GestureDetector(
            onTap: () => onFilterChange(f.$1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primaryLight.withValues(alpha: 0.15)
                    : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? AppColors.primaryLight : AppColors.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    f.$2,
                    style: TextStyle(
                      color: isActive
                          ? AppColors.primaryLight
                          : AppColors.secondaryText,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (f.$1 == 'unread' || f.$1 == 'all') ...[
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        f.$1 == 'all' ? '21' : '$unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }),
        // Search box
        Container(
          width: 200,
          height: 34,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: searchController,
            onChanged: onSearch,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            decoration: const InputDecoration(
              hintText: 'Search notifications…',
              hintStyle: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 12,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 16,
                color: AppColors.secondaryText,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _AppBarBtn extends StatelessWidget {
  const _AppBarBtn({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.secondaryText;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isDestructive
              ? AppColors.error.withValues(alpha: 0.08)
              : AppColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isDestructive
                ? AppColors.error.withValues(alpha: 0.3)
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 5),
            Text(label, style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.filter});
  final String filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: 48,
            color: AppColors.secondaryText.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          Text(
            filter == 'all' ? 'No notifications' : 'No $filter notifications',
            style: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
