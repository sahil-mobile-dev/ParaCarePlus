import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';
import 'package:paracareplus/core/theme/app_text_styles.dart';
import 'package:paracareplus/features/patient/view/portal/widgets/patient_portal_drawer.dart';
import 'package:paracareplus/routes/route_names.dart';

enum AiConsoleTab { symptom, drugSafety, cbtTherapy }

class Message {
  Message({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.actionButtons,
  });

  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? actionButtons;
}

// State providers for chat
final activeAiTabProvider = StateProvider<AiConsoleTab>(
  (ref) => AiConsoleTab.symptom,
);

final chatMessagesProvider =
    StateNotifierProvider<ChatMessagesNotifier, List<Message>>((ref) {
      final activeTab = ref.watch(activeAiTabProvider);
      return ChatMessagesNotifier(activeTab);
    });

class ChatMessagesNotifier extends StateNotifier<List<Message>> {
  ChatMessagesNotifier(this.tab) : super([]) {
    _loadInitialMessages();
  }

  final AiConsoleTab tab;

  void _loadInitialMessages() {
    switch (tab) {
      case AiConsoleTab.symptom:
        state = [
          Message(
            text:
                'Hello Ramesh! I am your ABDM-Certified Clinical AI Assistant. Select a symptom below or describe what you are feeling in detail.',
            isUser: false,
            timestamp: DateTime.now(),
            actionButtons: [
              'Persistent dry cough',
              'Mild fever with body aches',
              'Sharp chest pain on deep breaths',
            ],
          ),
        ];
      case AiConsoleTab.drugSafety:
        state = [
          Message(
            text:
                'Welcome to the Drug Safety & Interaction Portal. Check prescription safety, drug-drug compatibility, or dosage alerts. Type your medications (e.g., "Metformin + Ibuprofen").',
            isUser: false,
            timestamp: DateTime.now(),
            actionButtons: [
              'Check Amoxicillin + Paracetamol',
              'Is Metformin safe with alcohol?',
            ],
          ),
        ];
      case AiConsoleTab.cbtTherapy:
        state = [
          Message(
            text:
                'Hello Ramesh. I am here to help you manage health-related stress, hospital anxieties, or mindfulness coping strategies using CBT principles. How are you feeling today?',
            isUser: false,
            timestamp: DateTime.now(),
            actionButtons: [
              'Feeling anxious about my upcoming surgery',
              'Tips to manage high blood pressure stress',
            ],
          ),
        ];
    }
  }

  void addMessage({required String text, required bool isUser}) {
    state = [
      ...state,
      Message(text: text, isUser: isUser, timestamp: DateTime.now()),
    ];
  }

  void simulateAiResponse(String userPrompt) {
    var replyText = '';
    List<String>? options;

    if (tab == AiConsoleTab.symptom) {
      if (userPrompt.contains('cough') || userPrompt.contains('Cough')) {
        replyText =
            'Based on clinical guidelines, a persistent dry cough without respiratory distress may indicate a mild viral airway infection, gastroesophageal reflux (GERD), or an ACE-inhibitor side effect.\n\n⚠️ Red Flags:\n• Blood in sputum\n• Shortness of breath\n• High-grade fever for >3 days\n\nWould you like to book an OPD consult with our Pulmonologist at Rishikesh HIMS?';
        options = ['Book Pulmonologist Consult', 'Check other symptoms'];
      } else if (userPrompt.contains('fever') || userPrompt.contains('Fever')) {
        replyText =
            'A mild fever accompanied by general body aches is a typical systemic response to viral infections. Ensure optimal hydration, monitor body temperature, and rest.\n\n⚠️ Caution:\nDo not self-medicate with high dosages of NSAIDs. If temperature exceeds 102°F or lasts over 48 hours, seek professional care.';
        options = ['Book General Physician', 'Check temperature rules'];
      } else if (userPrompt.contains('chest pain') ||
          userPrompt.contains('Chest pain')) {
        replyText =
            '🚨 CRITICAL ADVISORY:\nSharp chest pain on deep breathing can range from pleuritic inflammation to serious cardiovascular events (e.g., Angina, Pulmonary Embolism).\n\nPlease utilize the Emergency SOS panel immediately if you experience shortness of breath, radiating pain, or lightheadedness.';
        options = ['Go to Emergency SOS', 'Contact Helpline'];
      } else {
        replyText =
            'Thank you for describing your symptoms. I have logged this query into your health profile. To help me refine my analysis, could you specify if you are experiencing any fever, congestion, or physical discomfort?';
      }
    } else if (tab == AiConsoleTab.drugSafety) {
      if (userPrompt.contains('Amoxicillin') ||
          userPrompt.contains('amoxicillin')) {
        replyText =
            '🔍 DRUG COMPATIBILITY REPORT:\n\n• Amoxicillin (Antibiotic) & Paracetamol (Analgesic/Antipyretic)\n• Compatibility Status: SECURE ✅\n• No clinically significant drug-drug interactions detected.\n\nAdhere to the prescribed dosage intervals and complete the full antibiotic course to prevent antimicrobial resistance.';
      } else if (userPrompt.contains('Metformin') ||
          userPrompt.contains('metformin')) {
        replyText =
            '⚠️ WARNING - METFORMIN & ALCOHOL:\n\nTaking Metformin alongside alcohol consumption significantly increases the risk of lactic acidosis—a rare but highly severe metabolic complication.\n\nAvoid excessive alcohol consumption while on Metformin therapy.';
      } else {
        replyText =
            'I have scanned our dynamic clinical pharmacology index. No major acute interaction warning is registered for your query. Always cross-reference with your prescribing physician.';
      }
    } else {
      // CBT
      if (userPrompt.contains('anxious') || userPrompt.contains('surgery')) {
        replyText =
            "It's completely natural to experience anxiety before a medical procedure. Let's practice a simple cognitive reframing exercise:\n\n1. Identify the specific worry.\n2. Remind yourself that the ParaCarePlus surgical team is fully certified and operates under stringent clinical guidelines.\n3. Let's do a 4-7-8 breathing technique together.";
        options = ['Start 4-7-8 Breathing', 'Talk to a counselor'];
      } else {
        replyText =
            'Thank you for sharing that. Managing stress directly improves physiological metrics such as heart rate variability and blood pressure. Focus on what is within your control right now. I am here to support you step-by-step.';
      }
    }

    Timer(const Duration(milliseconds: 800), () {
      state = [
        ...state,
        Message(
          text: replyText,
          isUser: false,
          timestamp: DateTime.now(),
          actionButtons: options,
        ),
      ];
    });
  }
}

class PatientAiScreen extends ConsumerStatefulWidget {
  const PatientAiScreen({super.key});

  @override
  ConsumerState<PatientAiScreen> createState() => _PatientAiScreenState();
}

class _PatientAiScreenState extends ConsumerState<PatientAiScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    ref
        .read(chatMessagesProvider.notifier)
        .addMessage(text: text, isUser: true);
    _controller.clear();
    _scrollToBottom();

    setState(() {
      _isTyping = true;
    });

    // Simulate AI delay
    Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
        ref.read(chatMessagesProvider.notifier).simulateAiResponse(text);
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    Timer(const Duration(milliseconds: 100), () {
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
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = ref.watch(activeAiTabProvider);
    final messages = ref.watch(chatMessagesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const PatientPortalDrawer(activeRouteName: RouteNames.patientAI),
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        iconTheme: const IconThemeData(color: AppColors.primaryText),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clinical AI Assistant', style: AppTextStyles.titleSmall),
            Text(
              'ABDM-Certified Medical Model v2.4',
              style: AppTextStyles.labelSmall,
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              border: Border.all(
                color: AppColors.success.withValues(alpha: 0.4),
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'HIPAA SECURE',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented Navigation Header
          _buildSegmentedHeader(activeTab),

          // Chat Pane
          Expanded(
            child: ColoredBox(
              color: AppColors.background,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: messages.length + (_isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return _buildTypingIndicator();
                  }
                  final msg = messages[index];
                  return _buildMessageBubble(msg);
                },
              ),
            ),
          ),

          // User input console
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildSegmentedHeader(AiConsoleTab activeTab) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton(
              'Symptom Checker',
              Icons.healing_rounded,
              activeTab == AiConsoleTab.symptom,
              () {
                ref.read(activeAiTabProvider.notifier).state =
                    AiConsoleTab.symptom;
              },
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _buildTabButton(
              'Drug Safety AI',
              Icons.shield_rounded,
              activeTab == AiConsoleTab.drugSafety,
              () {
                ref.read(activeAiTabProvider.notifier).state =
                    AiConsoleTab.drugSafety;
              },
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _buildTabButton(
              'CBT Stress Bot',
              Icons.sentiment_satisfied_alt_rounded,
              activeTab == AiConsoleTab.cbtTherapy,
              () {
                ref.read(activeAiTabProvider.notifier).state =
                    AiConsoleTab.cbtTherapy;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    String label,
    IconData icon,
    bool isActive,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : AppColors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isActive ? AppColors.primaryLight : AppColors.border,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : AppColors.secondaryText,
              size: 18,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.secondaryText,
                fontSize: 9.5,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Message msg) {
    return Align(
      alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.82,
        ),
        margin: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: msg.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: msg.isUser ? AppColors.primary : AppColors.card,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(msg.isUser ? 16 : 4),
                  bottomRight: Radius.circular(msg.isUser ? 4 : 16),
                ),
                border: Border.all(
                  color: msg.isUser ? AppColors.primaryLight : AppColors.border,
                ),
              ),
              child: Text(
                msg.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white,
                  height: 1.35,
                ),
              ),
            ),
            if (msg.actionButtons != null && msg.actionButtons!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: msg.actionButtons!.map((btnText) {
                  return OutlinedButton(
                    onPressed: () => _sendMessage(btnText),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primaryLight),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      btnText,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primaryText,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 2),
            Text(
              '${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
              style: AppTextStyles.labelSmall.copyWith(fontSize: 8.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.secondaryAccent,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'AI is formulating diagnosis...',
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.secondaryAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: _controller,
                  style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Describe symptoms or type question...',
                    hintStyle: AppTextStyles.bodySmall,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onSubmitted: _sendMessage,
                ),
              ),
            ),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primary,
              child: IconButton(
                icon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 16,
                ),
                onPressed: () => _sendMessage(_controller.text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
