import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controller.dart';
import 'message_bubble.dart';

class ChatHistoryPane extends GetView<MessengerController> {
  const ChatHistoryPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final chat = controller.selectedProfile.value;

      if (chat == null) {
        return const Center(
          child: Text(
            'Выберите чат',
            style: TextStyle(color: Color(0xFF757575), fontSize: 16),
          ),
        );
      }

      final profile = chat.otherParticipant;
      final name = profile != null
          ? '${profile.firstName} ${profile.lastName}'
          : 'Неизвестно';
      final initial = name.isNotEmpty ? name[0] : '?';

      return Container(
        color: const Color(0xFFF9F9FF),
        child: Column(
          children: [
            // Chat Header
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFBFC9C4), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blueAccent.withValues(
                          alpha: 0.2,
                        ),
                        backgroundImage: profile?.imageUrl != null
                            ? NetworkImage(profile!.imageUrl!)
                            : null,
                        child: profile?.imageUrl == null
                            ? Text(
                                initial,
                                style: const TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A1D1E),
                            ),
                          ),
                          if (profile?.role.name == 'performer')
                            const Text(
                              'В сети',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.blueAccent,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Color(0xFF757575)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount:
                    controller.currentMessages.length +
                    1, // +1 for date divider
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Сегодня',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ),
                    );
                  }

                  final message = controller.currentMessages[index - 1];
                  final isMe = controller.isMe(message.senderId);
                  return MessageBubble(message: message, isMe: isMe)
                      .animate(key: ValueKey(message.id))
                      .fadeIn(duration: 300.ms)
                      .moveY(
                        begin: 10,
                        end: 0,
                        duration: 300.ms,
                        curve: Curves.easeOutQuad,
                      );
                },
              ),
            ),

            // Input Area
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFBFC9C4), width: 1),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.attach_file,
                      color: Color(0xFF757575),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: const Color(0xFFBFC9C4)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: controller.textController,
                        decoration: const InputDecoration(
                          hintText: 'Написать сообщение...',
                          hintStyle: TextStyle(color: Color(0xFF757575)),
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => controller.sendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: () => controller.sendMessage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
