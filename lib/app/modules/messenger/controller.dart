import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../data/model/chat_model.dart';
import '../../data/model/message_model.dart';
import 'repository.dart';

class MessengerController extends GetxController {
  final MessengerRepository repository;

  MessengerController({required this.repository});

  final RxList<ChatModel> activeChats = <ChatModel>[].obs;
  final Rx<ChatModel?> selectedProfile = Rx<ChatModel?>(null);
  final RxList<MessageModel> currentMessages = <MessageModel>[].obs;

  final textController = TextEditingController();
  StreamSubscription<List<MessageModel>>? _messagesSubscription;

  @override
  void onInit() {
    super.onInit();
    _loadChats().then((_) {
      final args = Get.arguments;
      if (args != null && args is Map && args['startChatWith'] != null) {
        final userId = args['startChatWith'] as String;
        _startChatWithUser(userId);
      }
    });
  }

  Future<void> _startChatWithUser(String userId) async {
    try {
      final chat = await repository.getOrCreateChat(userId);
      // Ensure chat is in activeChats
      if (!activeChats.any((c) => c.id == chat.id)) {
        activeChats.insert(0, chat);
      }
      selectProfile(chat);
    } catch (e) {
      Get.snackbar('Error', 'Failed to start chat: $e');
    }
  }

  Future<void> _loadChats() async {
    try {
      final chats = await repository.fetchChats();
      activeChats.value = chats;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load chats: $e');
    }
  }

  void selectProfile(ChatModel chat) {
    selectedProfile.value = chat;
    _listenToMessages(chat.id);
  }

  void _listenToMessages(String chatId) {
    _messagesSubscription?.cancel();
    _messagesSubscription = repository
        .subscribeToMessages(chatId)
        .listen(
          (messages) {
            currentMessages.value = messages;
          },
          onError: (e) {
            Get.snackbar('Error', 'Failed to load messages: $e');
          },
        );
  }

  Future<void> sendMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    final chat = selectedProfile.value;
    if (chat == null) return;

    textController.clear();

    try {
      await repository.sendMessage(chat.id, text);
      // Realtime subscription will automatically add it to currentMessages
    } catch (e) {
      Get.snackbar('Error', 'Failed to send message: $e');
    }
  }

  bool isMe(String senderId) {
    return repository.isMe(senderId);
  }

  @override
  void onClose() {
    _messagesSubscription?.cancel();
    textController.dispose();
    super.onClose();
  }
}
