import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/chat_model.dart';
import '../controller.dart';

class ChatListPane extends GetView<MessengerController> {
  const ChatListPane({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFBFC9C4), width: 1)),
      ),
      child: Column(
        children: [
          // Header / Search
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFBFC9C4), width: 1),
              ),
            ),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBFC9C4)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Color(0xFF757575), size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Поиск сообщений...',
                        hintStyle: TextStyle(color: Color(0xFF757575)),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Chat List
          Expanded(
            child: Obx(
              () => ListView(
                children: [
                  ...controller.activeChats.map(
                    (chat) => _buildChatItem(chat, isActive: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(ChatModel chat, {bool isActive = false}) {
    return Obx(() {
      final isSelected = controller.selectedProfile.value?.id == chat.id;
      final profile = chat.otherParticipant;
      final name = profile != null
          ? '${profile.firstName} ${profile.lastName}'
          : 'Неизвестно';
      final initial = name.isNotEmpty ? name[0] : '?';
      // For a real app, last message could be joined or fetched. We'll leave it empty for now or use updated_at.
      final lastTime = chat.updatedAt != null
          ? '${chat.updatedAt!.hour.toString().padLeft(2, '0')}:${chat.updatedAt!.minute.toString().padLeft(2, '0')}'
          : '';

      return InkWell(
        onTap: () => controller.selectProfile(chat),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEDF1F4) : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              // Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blueAccent.withValues(alpha: 0.2),
                    backgroundImage: profile?.imageUrl != null
                        ? NetworkImage(profile!.imageUrl!)
                        : null,
                    child: profile?.imageUrl == null
                        ? Text(
                            initial,
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        : null,
                  ),
                  if (profile?.role.name == 'performer')
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFF1A1D1E),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          lastTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Чат', // placeholder for last message
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF757575),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
