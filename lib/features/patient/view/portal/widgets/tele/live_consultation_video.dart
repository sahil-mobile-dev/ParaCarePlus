import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class LiveConsultationVideo extends StatefulWidget {
  const LiveConsultationVideo({super.key});

  @override
  State<LiveConsultationVideo> createState() => _LiveConsultationVideoState();
}

class _LiveConsultationVideoState extends State<LiveConsultationVideo> {
  Timer? _timer;
  int _seconds = 754; // starts at 00:12:34
  bool _isMicOn = true;
  bool _isCamOn = true;
  bool _isCallEnded = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isCallEnded) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  String _formatTimer() {
    final h = _seconds ~/ 3600;
    final m = (_seconds % 3600) ~/ 60;
    final s = _seconds % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _toggleMic() {
    setState(() {
      _isMicOn = !_isMicOn;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isMicOn ? 'Microphone unmuted' : 'Microphone muted'),
        backgroundColor: _isMicOn ? AppColors.success : AppColors.secondaryAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleCam() {
    setState(() {
      _isCamOn = !_isCamOn;
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isCamOn ? 'Camera turned on' : 'Camera turned off'),
        backgroundColor: _isCamOn ? AppColors.success : AppColors.secondaryAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _endCall() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: const Text('End Consultation', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to end your consultation with Dr. Rajesh Kumar?',
            style: TextStyle(color: AppColors.secondaryText),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isCallEnded = true;
                });
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Consultation ended. Summary sent to EMR.'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: const Text('End Call', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated video stream background
          Positioned.fill(
            child: _isCallEnded
                ? const ColoredBox(
                    color: Color(0xFF071221),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_call_rounded, size: 48, color: AppColors.secondaryText),
                          SizedBox(height: 12),
                          Text(
                            'Consultation Finished',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Summary & prescriptions uploaded to EMR',
                            style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, -0.1),
                        radius: 1.2,
                        colors: [Color(0xFF0A2440), Color(0xFF040C15)],
                      ),
                    ),
                  ),
          ),

          if (!_isCallEnded) ...[
            // Timer Badge
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatTimer(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // LIVE Badge
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            // Doctor Feed Simulation (if camera is on from doctor)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00B4D8).withValues(alpha: 0.4),
                      width: 3,
                    ),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D9488), Color(0xFF00B4D8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.medical_services_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Dr. Rajesh Kumar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Cardiologist · AIIMS Rishikesh',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
              ],
            ),

            // Self-view Viewport
            Positioned(
              bottom: 64,
              right: 12,
              child: Container(
                width: 90,
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A1929),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFF00B4D8).withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: _isCamOn
                    ? const Icon(Icons.person_rounded, color: AppColors.secondaryText, size: 24)
                    : const Icon(Icons.videocam_off_rounded, color: AppColors.error, size: 20),
              ),
            ),

            // Video Controls Overlay
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildControlButton(
                      icon: _isMicOn ? Icons.mic_rounded : Icons.mic_off_rounded,
                      isActive: _isMicOn,
                      onPressed: _toggleMic,
                      tooltip: 'Mute/Unmute',
                    ),
                    const SizedBox(width: 8),
                    _buildControlButton(
                      icon: _isCamOn ? Icons.videocam_rounded : Icons.videocam_off_rounded,
                      isActive: _isCamOn,
                      onPressed: _toggleCam,
                      tooltip: 'Camera On/Off',
                    ),
                    const SizedBox(width: 8),
                    _buildControlButton(
                      icon: Icons.desktop_windows_rounded,
                      isActive: false,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Screen share not available in demo'),
                            backgroundColor: AppColors.secondaryAccent,
                          ),
                        );
                      },
                      tooltip: 'Share Screen',
                    ),
                    const SizedBox(width: 8),
                    _buildControlButton(
                      icon: Icons.chat_bubble_rounded,
                      isActive: false,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Chat opened in side panel'),
                            backgroundColor: AppColors.primaryLight,
                          ),
                        );
                      },
                      tooltip: 'Chat',
                    ),
                    const SizedBox(width: 8),
                    _buildControlButton(
                      icon: Icons.fiber_manual_record_rounded,
                      isActive: false,
                      iconColor: AppColors.error,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Recording started'),
                            backgroundColor: AppColors.primaryLight,
                          ),
                        );
                      },
                      tooltip: 'Record',
                    ),
                    const SizedBox(width: 12),
                    _buildControlButton(
                      icon: Icons.call_end_rounded,
                      isActive: false,
                      isEnd: true,
                      onPressed: _endCall,
                      tooltip: 'End Call',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
    required String tooltip,
    Color? iconColor,
    bool isEnd = false,
  }) {
    final bg = isEnd
        ? AppColors.error
        : (isActive ? AppColors.success : Colors.white.withValues(alpha: 0.15));

    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
          ),
          child: Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
