import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';

class AiChatWorkspace extends StatefulWidget {
  const AiChatWorkspace({super.key});

  @override
  State<AiChatWorkspace> createState() => _AiChatWorkspaceState();
}

class _AiChatWorkspaceState extends State<AiChatWorkspace> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _activeMode = 'General';
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'text': "Namaste, Ramesh ji! 🙏 I'm your AI health assistant for ParaCare+ HIMS. I can help you with:\n\n• **Symptom analysis** — describe what you're feeling\n• **Lab report interpretation** — understanding your results\n• **Medication queries** — dosage, interactions, side effects\n• **Lifestyle advice** — diet, exercise, sleep based on your health data\n\nHow can I assist you today?",
      'time': '09:00 AM',
    },
    {
      'isUser': true,
      'text': 'My BP reading was 148/94 this morning. Should I be concerned?',
      'time': '09:14 AM',
    },
    {
      'isUser': false,
      'text': "Based on your reading of **148/94 mmHg**, this is classified as **Stage 1 Hypertension** (JNC 8 / WHO criteria). Here's what I found in your records:\n\n📊 **Last 7-day average:** 142/91 mmHg — trending slightly upward\n💊 **Current Rx:** Amlodipine 5mg — taken this morning ✓\n⚠️ **Trigger factors today:** Reported poor sleep (5.5 hrs) + no morning walk\n\n**Recommendations:**\n1. Re-measure after 30 min rest in sitting position\n2. Reduce sodium intake today — avoid pickles/papads\n3. 20 min brisk walk recommended this evening\n\nIf reading stays above 150/95 after re-check, please contact Dr. Rajesh Sharma.",
      'time': '09:14 AM',
    },
    {
      'isUser': true,
      'text': 'Can I take Ibuprofen for my knee pain along with my current medications?',
      'time': '09:22 AM',
    },
    {
      'isUser': false,
      'text': '⚠️ **Drug Interaction Alert Detected!**\n\nIbuprofen (NSAID) + your current medications show:\n\n🔴 **Amlodipine interaction:** NSAIDs can reduce antihypertensive efficacy — increases BP risk\n🟡 **Metformin interaction:** NSAIDs may affect renal function and metformin clearance\n\n**Safe alternatives for knee pain:**\n✅ Paracetamol 500mg (up to 3×/day) — safer with your current Rx\n✅ Topical Diclofenac gel — local application, minimal systemic absorption\n✅ Cold compress + knee elevation\n\n*Please consult Dr. Meena Verma (Orthopaedics) before starting any pain medication.*',
      'time': '09:23 AM',
    },
  ];

  final List<String> _suggestions = [
    '📊 Interpret my latest HbA1c',
    '🍽️ Diet plan for pre-diabetes',
    '💊 Side effects of Amlodipine',
    '🏃 Exercise for my BP?',
    '😴 Improve my sleep quality',
  ];

  final List<String> _selectedSymptoms = ['Headache', 'High BP', 'Poor Sleep'];
  final List<String> _allSymptoms = [
    'Headache',
    'High BP',
    'Chest Pain',
    'Dizziness',
    'Fatigue',
    'Blurred Vision',
    'Nausea',
    'Knee Pain',
    'Poor Sleep',
    'Palpitations',
  ];

  final List<Map<String, dynamic>> _symptomResults = [
    {'cond': 'Hypertensive Episode', 'prob': 0.78, 'color': AppColors.error},
    {'cond': 'Tension Headache', 'prob': 0.62, 'color': AppColors.secondaryAccent},
    {'cond': 'Sleep Disorder (OSA)', 'prob': 0.45, 'color': Colors.orange},
    {'cond': 'Dehydration', 'prob': 0.28, 'color': AppColors.primaryLight},
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _chatController.clear();

    setState(() {
      _messages.add({
        'isUser': true,
        'text': text,
        'time': DateFormat('hh:mm a').format(DateTime.now()),
      });
      _isTyping = true;
    });
    _scrollToBottom();

    Timer(const Duration(seconds: 1), () {
      if (!mounted) return;

      String replyText;
      if (text.contains('HbA1c')) {
        replyText = '📊 **HbA1c Analysis:** Your last value is **6.1%** (Pre-diabetic zone). Maintain your Metformin 500mg BD dose and restrict intake of refined carbs. Dr. Rajesh Sharma recommends checking HbA1c again in 2 months.';
      } else if (text.contains('Diet')) {
        replyText = '🍽️ **Pre-Diabetes Diet Plan:** Focus on complex carbs with low Glycemic Index: brown rice, millets, leafy vegetables, sprouts. Avoid refined flour (maida) and sugary drinks.';
      } else if (text.contains('Amlodipine')) {
        replyText = '💊 **Amlodipine Side Effects:** Common side effects include ankle swelling (edema), headache, or dizziness. If swelling is severe, Dr. Rajesh Sharma can adjust the dosage.';
      } else {
        replyText = 'I have received your query: "$text". Based on your clinical profile (Hypertension + Pre-diabetic), let me check the medical knowledge base. I recommend consulting Dr. Rajesh Sharma if you feel any persistent discomfort.';
      }

      setState(() {
        _isTyping = false;
        _messages.add({
          'isUser': false,
          'text': replyText,
          'time': DateFormat('hh:mm a').format(DateTime.now()),
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _chatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLarge = constraints.maxWidth > 900;

        final chatPanel = Container(
          height: 520,
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.indigoAccent],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.smart_toy_rounded, color: Colors.white, size: 18),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ParaCare AI — MedBot v3.2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Online · ABDM Verified',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: ['General', 'Symptom', 'Mental'].map((mode) {
                        final isSel = _activeMode == mode;
                        return Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _activeMode = mode;
                              });
                            },
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: isSel
                                    ? Colors.purpleAccent.withValues(alpha: 0.15)
                                    : AppColors.surface,
                                border: Border.all(
                                  color: isSel
                                      ? Colors.purpleAccent
                                      : AppColors.border,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                mode,
                                style: TextStyle(
                                  color: isSel ? Colors.purpleAccent : AppColors.secondaryText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Chat Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: _messages.length + (_isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length) {
                      return _buildTypingBubble();
                    }
                    final msg = _messages[index];
                    final isUser = msg['isUser'] as bool;

                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.75,
                        ),
                        child: Column(
                          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            if (!isUser) ...[
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.smart_toy_rounded, color: Colors.purpleAccent, size: 10),
                                  SizedBox(width: 4),
                                  Text(
                                    'ParaCare AI',
                                    style: TextStyle(
                                      color: Colors.purpleAccent,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                            ],
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: isUser
                                    ? const LinearGradient(
                                        colors: [Colors.indigo, Colors.purple],
                                      )
                                    : null,
                                color: isUser ? null : AppColors.surface,
                                border: isUser ? null : Border.all(color: AppColors.border),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft: Radius.circular(isUser ? 12 : 2),
                                  bottomRight: Radius.circular(isUser ? 2 : 12),
                                ),
                              ),
                              child: Text(
                                msg['text'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  height: 1.45,
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              msg['time'] as String,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 8.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Suggestions Bar
              Container(
                height: 38,
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final sug = _suggestions[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ActionChip(
                        label: Text(sug),
                        labelStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                          fontWeight: FontWeight.bold,
                        ),
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.border),
                        padding: EdgeInsets.zero,
                        onPressed: () => _sendMessage(sug),
                      ),
                    );
                  },
                ),
              ),

              // Input Row
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: AppColors.border)),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.attach_file_rounded, color: AppColors.secondaryText, size: 20),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Attach document flow simulation…')),
                        );
                      },
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: _chatController,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                          decoration: const InputDecoration(
                            hintText: 'Ask me anything about your health…',
                            hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 12),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onSubmitted: _sendMessage,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.indigo],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send_rounded, color: Colors.white, size: 16),
                        onPressed: () => _sendMessage(_chatController.text),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

        final rightColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Symptom Checker Panel
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quick Symptom Checker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Select all that apply',
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 9.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: _allSymptoms.map((sym) {
                      final isSelected = _selectedSymptoms.contains(sym);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedSymptoms.remove(sym);
                            } else {
                              _selectedSymptoms.add(sym);
                            }
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.error.withValues(alpha: 0.15)
                                : AppColors.surface,
                            border: Border.all(
                              color: isSelected ? AppColors.error : AppColors.border,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            sym,
                            style: TextStyle(
                              color: isSelected ? AppColors.error : AppColors.secondaryText,
                              fontSize: 10,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Analyzing selected symptom parameters…'),
                          backgroundColor: AppColors.error,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error.withValues(alpha: 0.1),
                      foregroundColor: AppColors.error,
                      elevation: 0,
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_rounded, size: 12),
                        SizedBox(width: 6),
                        Text(
                          'Analyse Symptoms',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: _symptomResults.map((res) {
                      final prob = res['prob'] as double? ?? 0.0;
                      final color = res['color'] as Color? ?? Colors.grey;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                res['cond'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 80,
                              height: 5,
                              decoration: BoxDecoration(
                                color: AppColors.border,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 80 * prob,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 28,
                              child: Text(
                                '${(prob * 100).toInt()}%',
                                style: TextStyle(
                                  color: color,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // AI Overall Risk Score Panel
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'AI Overall Risk Score',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      '62',
                      style: TextStyle(
                        color: AppColors.secondaryAccent,
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Center(
                    child: Text(
                      'MODERATE RISK — Action Recommended',
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontSize: 9.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Curved Segmented Progress Bar Painter
                  const SizedBox(
                    height: 14,
                    child: CustomPaint(
                      painter: _GaugeSegPainter(score: 62),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Low (0–39)', style: TextStyle(color: AppColors.secondaryText, fontSize: 8.5)),
                      Text('Moderate (40–69)', style: TextStyle(color: AppColors.secondaryText, fontSize: 8.5)),
                      Text('High (70+)', style: TextStyle(color: AppColors.secondaryText, fontSize: 8.5)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                '68%',
                                style: TextStyle(
                                  color: AppColors.error,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'T2D 5Y Risk',
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Column(
                            children: [
                              Text(
                                '42%',
                                style: TextStyle(
                                  color: AppColors.secondaryAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'CV Event 10Y',
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Active Medication Safety
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Active Medication Safety',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildMedSafetyRow('Amlodipine 5mg', 'Antihypertensive · OD', 'Safe', AppColors.success),
                  _buildMedSafetyRow('Metformin 500mg', 'Antidiabetic · BD', 'Safe', AppColors.success),
                  _buildMedSafetyRow('Atorvastatin 10mg', 'Lipid-lowering · HS', 'Monitor', AppColors.secondaryAccent),
                  _buildMedSafetyRow('Aspirin 75mg', 'Antiplatelet · OD', 'Interaction', Colors.red),
                  _buildMedSafetyRow('Vitamin D3 60K IU', 'Supplement · Weekly', 'Safe', AppColors.success),
                ],
              ),
            ),
          ],
        );

        if (isLarge) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: chatPanel),
              const SizedBox(width: AppSpacing.md),
              Expanded(flex: 2, child: rightColumn),
            ],
          );
        } else {
          return Column(
            children: [
              chatPanel,
              const SizedBox(height: AppSpacing.md),
              rightColumn,
            ],
          );
        }
      },
    );
  }

  Widget _buildTypingBubble() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'AI is formulating analysis...',
              style: AppTextStyles.labelSmall.copyWith(color: Colors.purpleAccent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedSafetyRow(String name, String desc, String badge, Color badgeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border.withValues(alpha: 0.3), width: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.bold)),
                Text(desc, style: const TextStyle(color: AppColors.secondaryText, fontSize: 9.5)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.12),
              border: Border.all(color: badgeColor, width: 0.5),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              badge,
              style: TextStyle(color: badgeColor, fontSize: 8.5, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugeSegPainter extends CustomPainter {
  const _GaugeSegPainter({required this.score});

  final int score;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = AppColors.success.withValues(alpha: 0.7);

    // Segment 1 (Low): 0% to 39%
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 4, w * 0.39, h - 8),
        const Radius.circular(3),
      ),
      paint,
    );

    // Segment 2 (Moderate): 40% to 69%
    paint.color = AppColors.secondaryAccent.withValues(alpha: 0.7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.40, 4, w * 0.29, h - 8),
        const Radius.circular(3),
      ),
      paint,
    );

    // Segment 3 (High): 70% to 100%
    paint.color = AppColors.error.withValues(alpha: 0.7);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.70, 4, w * 0.30, h - 8),
        const Radius.circular(3),
      ),
      paint,
    );

    // Draw pointer at score position
    final ptrX = w * (score / 100);
    final ptrPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(ptrX, h / 2), 6, ptrPaint);

    final borderPaint = Paint()
      ..color = AppColors.secondaryAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(Offset(ptrX, h / 2), 6, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _GaugeSegPainter oldDelegate) {
    return oldDelegate.score != score;
  }
}
