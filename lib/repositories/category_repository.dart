import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/repositories/init_hive.dart';

class CategoryRepository {
  Box<CategoryBox>? _categoryBox;

  Box<CategoryBox> get categoryBox {
    _categoryBox ??= Hive.box<CategoryBox>(InitHiveBox.categoryBox);
    return _categoryBox!;
  }

  List<CategoryBox> get categoryList {
    return categoryBox.values.toList();
  }

  void updateCategory({
    required dynamic key,
    required CategoryBox category,
  }) async {
    await categoryBox.put(key, category);
    log('[updateCategory] update (key:$key) $category');
  }

  void deleteCategory(int key) async {
    await categoryBox.delete(key);
    log('[deleteCategory] delete (key:$key)');
  }
}
