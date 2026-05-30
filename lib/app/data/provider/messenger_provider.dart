import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/errors/unauthorized_exception.dart';
import '../../core/values/supabase.dart';
import '../model/chat_model.dart';
import '../model/message_model.dart';
import '../model/profile_model.dart';

abstract interface class MessengerProvider {
  Future<List<ChatModel>> fetchChats();
  Future<ChatModel> getOrCreateChat(String otherUserId);
  Future<List<MessageModel>> fetchMessages(String chatId);
  Future<MessageModel> sendMessage(String chatId, String text);
  SupabaseStreamBuilder subscribeToMessages(String chatId);
}

class SupabaseMessengerProvider implements MessengerProvider {
  final supabase = Supabase.instance.client;

  @override
  Future<List<ChatModel>> fetchChats() async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    final data = await supabase
        .from(AppSupabase.chatsTable)
        .select('*, user1:profiles!user1_id(*), user2:profiles!user2_id(*)')
        .or('user1_id.eq.${user.id},user2_id.eq.${user.id}')
        .order(AppSupabase.updatedAtColumn, ascending: false);

    return data.map<ChatModel>((json) {
      final chat = ChatModel.fromJson(json);
      final otherUserJson = chat.user1Id == user.id
          ? json['user2']
          : json['user1'];
      return chat.copyWith(
        otherParticipant: otherUserJson != null
            ? ProfileModel.fromJson(otherUserJson)
            : null,
      );
    }).toList();
  }

  @override
  Future<ChatModel> getOrCreateChat(String otherUserId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    final existingData = await supabase
        .from(AppSupabase.chatsTable)
        .select('*, user1:profiles!user1_id(*), user2:profiles!user2_id(*)')
        .or('and(user1_id.eq.${user.id},user2_id.eq.$otherUserId),and(user1_id.eq.$otherUserId,user2_id.eq.${user.id})')
        .maybeSingle();

    if (existingData != null) {
      final chat = ChatModel.fromJson(existingData);
      final otherUserJson = chat.user1Id == user.id ? existingData['user2'] : existingData['user1'];
      return chat.copyWith(
        otherParticipant: otherUserJson != null ? ProfileModel.fromJson(otherUserJson) : null,
      );
    }

    final newData = await supabase
        .from(AppSupabase.chatsTable)
        .insert({
          AppSupabase.user1IdColumn: user.id,
          AppSupabase.user2IdColumn: otherUserId,
        })
        .select('*, user1:profiles!user1_id(*), user2:profiles!user2_id(*)')
        .single();

    final chat = ChatModel.fromJson(newData);
    final otherUserJson = chat.user1Id == user.id ? newData['user2'] : newData['user1'];
    return chat.copyWith(
      otherParticipant: otherUserJson != null ? ProfileModel.fromJson(otherUserJson) : null,
    );
  }

  @override
  Future<List<MessageModel>> fetchMessages(String chatId) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    final data = await supabase
        .from(AppSupabase.messagesTable)
        .select()
        .eq(AppSupabase.chatIdColumn, chatId)
        .order(AppSupabase.createdAtColumn, ascending: true);

    return data
        .map<MessageModel>((json) => MessageModel.fromJson(json))
        .toList();
  }

  @override
  Future<MessageModel> sendMessage(String chatId, String text) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw UnauthorizedException();

    final data = await supabase
        .from(AppSupabase.messagesTable)
        .insert({
          AppSupabase.chatIdColumn: chatId,
          AppSupabase.senderIdColumn: user.id,
          AppSupabase.textColumn: text,
        })
        .select()
        .single();

    // Update chat updated_at
    await supabase
        .from(AppSupabase.chatsTable)
        .update({
          AppSupabase.updatedAtColumn: DateTime.now().toUtc().toIso8601String(),
        })
        .eq(AppSupabase.idColumn, chatId);

    return MessageModel.fromJson(data);
  }

  @override
  SupabaseStreamBuilder subscribeToMessages(String chatId) {
    return supabase
        .from(AppSupabase.messagesTable)
        .stream(primaryKey: [AppSupabase.idColumn])
        .eq(AppSupabase.chatIdColumn, chatId)
        .order(AppSupabase.createdAtColumn, ascending: true);
  }
}
