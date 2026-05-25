import 'dart:async';
import 'package:flutter/material.dart';
import 'package:paracareplus/core/theme/app_colors.dart';
import 'package:paracareplus/core/theme/app_spacing.dart';

class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.isPatient,
    required this.sender,
  });

  final String text;
  final bool isPatient;
  final String sender;
}

class ConsultationChatPanel extends StatefulWidget {
  const ConsultationChatPanel({super.key});

  @override
  State<ConsultationChatPanel> createState() => _ConsultationChatPanelState();
}

class _ConsultationChatPanelState extends State<ConsultationChatPanel> {
  final List<ChatMessage> _messages = [
    const ChatMessage(
      text: 'Good afternoon Ramesh ji. How are you feeling today?',
      isPatient: false,
      sender: 'Dr. Rajesh Kumar',
    ),
    const ChatMessage(
      text: "Doctor, I've been having mild chest tightness after climbing stairs.",
      isPatient: true,
      sender: 'You',
    ),
    const ChatMessage(
      text: 'I see. Can you check your BP right now? We have your recent ECG on file.',
      isPatient: false,
      sender: 'Dr. Rajesh Kumar',
    ),
    const ChatMessage(
      text: 'BP reads 130/84 at home this morning.',
      isPatient: true,
      sender: 'You',
    ),
    const ChatMessage(
      text: "That's slightly elevated. Let me review your last lab results and chest X-ray.",
      isPatient: false,
      sender: 'Dr. Rajesh Kumar',
    ),
  ];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text, isPatient: true, sender: 'You'));
    });
    _controller.clear();
    _scrollToBottom();

    // Trigger simulated reply after 1.5 seconds
    Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _messages.add(const ChatMessage(
            text: "Thank you for the information. I'll review and advise accordingly.",
            isPatient: false,
            sender: 'Dr. Rajesh Kumar',
          ));
        });
        _scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Chat Box Container
        Container(
          height: 270,
          decoration: BoxDecoration(
            color: const Color(0xFF112240),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Chat Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF00B4D8).withValues(alpha: 0.1),
                  border: const Border(bottom: BorderSide(color: AppColors.border)),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppRadius.md),
                    topRight: Radius.circular(AppRadius.md),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.comments_disabled_outlined, color: Color(0xFF00B4D8), size: 14),
                    SizedBox(width: 8),
                    Text(
                      'Consultation Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Chat Messages list
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return Align(
                      alignment: msg.isPatient ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        decoration: BoxDecoration(
                          color: msg.isPatient
                              ? AppColors.success.withValues(alpha: 0.12)
                              : const Color(0xFF00B4D8).withValues(alpha: 0.15),
                          borderRadius: msg.isPatient
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                )
                              : const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.sender,
                              style: const TextStyle(
                                color: AppColors.secondaryText,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              msg.text,
                              style: const TextStyle(
                                color: AppColors.primaryText,
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Input Row
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.border),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white, fontSize: 11),
                        decoration: InputDecoration(
                          hintText: 'Type message...',
                          hintStyle: const TextStyle(color: AppColors.secondaryText, fontSize: 11),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Color(0xFF00B4D8)),
                          ),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00B4D8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.send_rounded, color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Shared Files Card
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF112240),
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Row(
                children: [
                  Icon(Icons.file_copy_rounded, color: Color(0xFF00B4D8), size: 14),
                  SizedBox(width: 6),
                  Text(
                    'Shared Files',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              _buildFileRow(
                context,
                filename: 'ECG_13May2026.pdf',
                icon: Icons.picture_as_pdf_rounded,
                iconColor: AppColors.error,
                toastMsg: 'Opening ECG report…',
              ),
              _buildFileRow(
                context,
                filename: 'LipidPanel_10May2026.pdf',
                icon: Icons.picture_as_pdf_rounded,
                iconColor: AppColors.error,
                toastMsg: 'Opening lab report…',
              ),
              _buildFileRow(
                context,
                filename: 'ChestXray_28Apr2026.jpg',
                icon: Icons.image_rounded,
                iconColor: const Color(0xFF00B4D8),
                toastMsg: 'Opening chest X-ray…',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFileRow(
    BuildContext context, {
    required String filename,
    required IconData icon,
    required Color iconColor,
    required String toastMsg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white10),
        ),
      ),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(toastMsg),
              backgroundColor: AppColors.primaryLight,
            ),
          );
        },
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 13),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                filename,
                style: const TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: 11,
                ),
              ),
            ),
            const Icon(Icons.open_in_new_rounded, color: AppColors.secondaryText, size: 12),
          ],
        ),
      ),
    );
  }
}
