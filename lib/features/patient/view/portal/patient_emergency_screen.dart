import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

// State models and providers for emergency
enum SosState { idle, countdown, active }

final sosStateProvider = StateProvider<SosState>((ref) => SosState.idle);
final sosCountdownProvider = StateProvider<int>((ref) => 5);

class PatientEmergencyScreen extends ConsumerStatefulWidget {
  const PatientEmergencyScreen({super.key});

  @override
  ConsumerState<PatientEmergencyScreen> createState() =>
      _PatientEmergencyScreenState();
}

class _PatientEmergencyScreenState extends ConsumerState<PatientEmergencyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    ref.read(sosStateProvider.notifier).state = SosState.countdown;
    ref.read(sosCountdownProvider.notifier).state = 5;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final current = ref.read(sosCountdownProvider);
      if (current > 1) {
        ref.read(sosCountdownProvider.notifier).state = current - 1;
      } else {
        timer.cancel();
        ref.read(sosStateProvider.notifier).state = SosState.active;
      }
    });
  }

  void _cancelSos() {
    _timer?.cancel();
    ref.read(sosStateProvider.notifier).state = SosState.idle;
    ref.read(sosCountdownProvider.notifier).state = 5;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sosStateProvider);
    final count = ref.watch(sosCountdownProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(
        activeRouteName: RouteNames.patientEmergency,
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          'EMERGENCY SOS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopAlertBanner(state),
              const SizedBox(height: 32),

              if (state == SosState.idle)
                _buildSosIdle(context)
              else if (state == SosState.countdown)
                _buildSosCountdown(count)
              else
                _buildSosActive(context),

              const SizedBox(height: 32),
              _buildHotlinesGrid(),
              const SizedBox(height: 24),
              _buildLocationTelemetry(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopAlertBanner(SosState state) {
    var title = 'EMERGENCY DISPATCH INACTIVE';
    var subtitle =
        'Press and hold the central red SOS button for 3 seconds to initiate a critical dispatch request to regional HIMS networks.';
    var color = AppColors.secondaryText;
    var border = AppColors.border;

    if (state == SosState.countdown) {
      title = 'HOLD ON! CRITICAL COUNTDOWN STARTED';
      subtitle =
          'Alert is preparing to transmit encrypted coordinates to Uttarakhand emergency medical networks.';
      color = AppColors.secondaryAccent;
      border = AppColors.secondaryAccent.withValues(alpha: 0.5);
    } else if (state == SosState.active) {
      title = '🚨 AMBULANCE DISPATCHED 🚨';
      subtitle =
          'Your telemetry and medical history has been shared with emergency networks. An ambulance from AIIMS Rishikesh is enroute.';
      color = AppColors.error;
      border = AppColors.error.withValues(alpha: 0.5);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: color, size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primaryText,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSosIdle(BuildContext context) {
    return Column(
      children: [
        const Text(
          'ARE YOU IN A LIFE-THREATENING EMERGENCY?',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: _startCountdown,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 200 + (_pulseController.value * 60),
                    height: 200 + (_pulseController.value * 60),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(
                        alpha: 0.15 * (1 - _pulseController.value),
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    width: 170 + (_pulseController.value * 30),
                    height: 170 + (_pulseController.value * 30),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(
                        alpha: 0.25 * (1 - _pulseController.value),
                      ),
                      shape: BoxShape.circle,
                    ),
                  );
                },
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.error.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                  gradient: const RadialGradient(
                    colors: [Color(0xFFFF5252), Color(0xFFD32F2F)],
                  ),
                ),
                alignment: Alignment.center,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_tethering_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'TAP SOS',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSosCountdown(int secondsRemaining) {
    return Column(
      children: [
        const Text(
          'TRANSMITTING ALERT TO NEAREST BASE STATION IN...',
          textAlign: TextAlign.center,
          style: AppTextStyles.labelSmall,
        ),
        const SizedBox(height: 24),
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.card,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.secondaryAccent, width: 4),
          ),
          alignment: Alignment.center,
          child: Text(
            '$secondsRemaining',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 24),
        OutlinedButton(
          onPressed: _cancelSos,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: const Text(
            'CANCEL BROADCAST',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSosActive(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.airport_shuttle_rounded,
                color: AppColors.error,
                size: 30,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AIIMS RISHIKESH - EMERGENCY UNIT',
                      style: AppTextStyles.labelLarge,
                    ),
                    Text(
                      'Ambulance # UK-07-GA-1024',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Mock Map Area
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.surface,
                  AppColors.background.withValues(alpha: 0.7),
                ],
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                  top: 20,
                  left: 40,
                  child: Icon(
                    Icons.local_hospital_rounded,
                    color: AppColors.primaryLight,
                    size: 24,
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  right: 40,
                  child: Icon(
                    Icons.person_pin_circle_rounded,
                    color: AppColors.success,
                    size: 28,
                  ),
                ),
                // Route path mock line
                Center(
                  child: CustomPaint(
                    size: const Size(double.infinity, 120),
                    painter: RouteLinePainter(),
                  ),
                ),
                Positioned(
                  top: 45,
                  left: 110,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'ETA: 8 mins',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDriverStats(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Calling Driver Vikram Rawat (Mock)...'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.phone_in_talk_rounded, size: 14),
                  label: const Text(
                    'CALL DRIVER',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.success,
                    side: const BorderSide(color: AppColors.success),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _cancelSos,
                  icon: const Icon(Icons.cancel_outlined, size: 14),
                  label: const Text(
                    'CANCEL SOS',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriverStats() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vikram Rawat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Assigned Paramedic Driver',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '4.9 ★',
              style: TextStyle(
                color: AppColors.secondaryAccent,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '124 Emergency Rescues',
              style: TextStyle(color: AppColors.secondaryText, fontSize: 9.5),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHotlinesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('QUICK CONNECT HOTLINES', style: AppTextStyles.labelSmall),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildHotlineItem(
                'POLICE',
                '100',
                Icons.local_police_rounded,
                const Color(0xFF1E88E5),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildHotlineItem(
                'FIRE',
                '101',
                Icons.local_fire_department_rounded,
                const Color(0xFFE53935),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildHotlineItem(
                'DISASTER',
                '1070',
                Icons.nature_people_rounded,
                const Color(0xFFF57C00),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHotlineItem(
    String label,
    String number,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            number,
            style: TextStyle(
              color: color,
              fontSize: 9.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTelemetry() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        children: [
          Icon(Icons.gps_fixed_rounded, color: AppColors.success, size: 18),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR CURRENT GPS COORDINATES (RISHIKESH)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Lat: 30.1030° N | Lng: 78.2948° E • Accuracy: 3m',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RouteLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondaryAccent.withValues(alpha: 0.6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(40, 20)
      ..cubicTo(
        size.width * 0.4,
        size.height * 0.2,
        size.width * 0.6,
        size.height * 0.8,
        size.width - 40,
        size.height - 20,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
