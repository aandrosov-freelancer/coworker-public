import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/model/chat_model.dart';
import '../../data/model/message_model.dart';
import '../../data/provider/messenger_provider.dart';

class MessengerRepository {
  final MessengerProvider provider;

  MessengerRepository({required this.provider});

  String? get currentUserId => Supabase.instance.client.auth.currentUser?.id;

  Future<List<ChatModel>> fetchChats() => provider.fetchChats();

  Future<ChatModel> getOrCreateChat(String otherUserId) =>
      provider.getOrCreateChat(otherUserId);

  Future<List<MessageModel>> fetchMessages(String chatId) =>
      provider.fetchMessages(chatId);

  Future<MessageModel> sendMessage(String chatId, String text) =>
      provider.sendMessage(chatId, text);

  Stream<List<MessageModel>> subscribeToMessages(String chatId) {
    return provider
        .subscribeToMessages(chatId)
        .map(
          (events) =>
              events.map((json) => MessageModel.fromJson(json)).toList(),
        );
  }

  bool isMe(String senderId) {
    return currentUserId == senderId;
  }
}
