final class AppSupabase {
  AppSupabase._();

  static const String supabaseUrlEnvKey = 'SUPABASE_URL';
  static const String supabaseAnonEnvKey = 'SUPABASE_ANON_KEY';

  static const String profilesTable = 'profiles';
  static const String tasksTable = 'tasks';
  static const String categoriesTable = 'task_categories';
  static const String taskResponsesTable = 'tasks_responses';
  static const String chatsTable = 'chats';
  static const String messagesTable = 'messages';

  static const String idColumn = 'id';
  static const String customerIdColumn = 'customer_id';
  static const String categoryIdColumn = 'category_id';
  static const String titleColumn = 'title';
  static const String descriptionColumn = 'description';
  static const String budgetColumn = 'budget';
  static const String statusColumn = 'status';
  static const String createdAtColumn = 'created_at';
  static const String updatedAtColumn = 'updated_at';

  static const String user1IdColumn = 'user1_id';
  static const String user2IdColumn = 'user2_id';
  static const String senderIdColumn = 'sender_id';
  static const String chatIdColumn = 'chat_id';
  static const String textColumn = 'text';
  static const String isReadColumn = 'is_read';

  static const String messageColumn = 'message';
  static const String matchingExplanationColumn = 'matching_explanation';
  static const String coincidenceColumn = 'coincidence';

  static const String firstNameColumn = 'first_name';
  static const String lastNameColumn = 'last_name';
  static const String roleColumn = 'role';

  static const String emailNotConfirmedCode = 'email_not_confirmed';
}
