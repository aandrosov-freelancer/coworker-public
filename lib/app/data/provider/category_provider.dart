import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/values/supabase.dart';
import '../model/category_model.dart';

abstract interface class CategoryProvider {
  Future<List<CategoryModel>> fetchCategories();
  Future<CategoryModel> getCategoryById(int id);
}

class SupabaseCategoryProvider implements CategoryProvider {
  final supabase = Supabase.instance.client;

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final data = await supabase
        .from(AppSupabase.categoriesTable)
        .select()
        .order(AppSupabase.titleColumn, ascending: true);

    return (data as List).map((json) => CategoryModel.fromJson(json)).toList();
  }

  @override
  Future<CategoryModel> getCategoryById(int id) async {
    final data = await supabase
        .from(AppSupabase.categoriesTable)
        .select()
        .eq(AppSupabase.idColumn, id)
        .single();

    return CategoryModel.fromJson(data);
  }
}
