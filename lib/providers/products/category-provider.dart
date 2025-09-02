// // ignore_for_file: prefer_final_fields, empty_catches, unused_local_variable, file_names, use_build_context_synchronously, unused_field, avoid_print, unnecessary_brace_in_string_interps

// ignore_for_file: prefer_final_fields, empty_catches, unused_local_variable, file_names, use_build_context_synchronously, unused_field, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pos/api-helpers/services-endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:pos/models/products/category-model.dart';

class CategoryProvider extends ChangeNotifier {
  TextEditingController categoryController = TextEditingController();

  CategoryModel? _categoryModel;
  bool _isEdit = false;

  bool get isEdit => _isEdit;
  CategoryModel? get categoryModel => _categoryModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> _filterCategoryList = [];

  List<CategoryModel> get categoryList => _categoryList;
  List<CategoryModel> get filterCategoryList => _filterCategoryList;

  // Helper methods to manage edit state
  void setEditModel(CategoryModel model) {
    _categoryModel = model;
    _isEdit = true;
    categoryController.text = model.category_name ?? '';
    notifyListeners();
  }

  void clearEditState() {
    _categoryModel = null;
    _isEdit = false;
    categoryController.clear();
    notifyListeners();
  }

  Future<void> addCategory(String categoryName, BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(
        '${SEP.BASE_URL}${SEP.insertCategoryApi}category_name=$categoryName',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Category added successfully")));
        await fetchCategory();
        categoryController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to add category: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategory() async {
    _isLoading = true;
    notifyListeners();

    try {
      String categoryURl = '${SEP.BASE_URL}${SEP.categoryList}';
      final response = await http.get(Uri.parse(categoryURl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List categories = data['response']['categories'];
        _categoryList = categories
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        _filterCategoryList = List.from(_categoryList);
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: ${e}');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      _filterCategoryList = List.from(_categoryList);
    } else {
      _filterCategoryList = _categoryList.where((category) {
        final categoryName = category.category_name?.toLowerCase() ?? '';
        return categoryName.contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<bool> updateCategory(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    bool success = false;

    try {
      final url = Uri.parse(
        "${SEP.BASE_URL}${SEP.updateCategory}id=${_categoryModel?.category_id}&category_name=${categoryController.text}",
      );

      final response = await http.post(url);

      if (response.statusCode == 200) {
        print("Update success: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category updated successfully")),
        );
        await fetchCategory();
        success = true;
      } else {
        print("Update failed: ${response.statusCode} - ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update category: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      print("Error updating category: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error updating category: ${e.toString()}")),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return success;
  }

  Future<void> deleteCategory(String id, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    // bool success = false;
    try {
      final deleteUrl = '${SEP.BASE_URL}${SEP.deleteCategory}id=$id';
      final response = await http.post(Uri.parse(deleteUrl));
      if (response.statusCode == 200) {
        await fetchCategory();
        print("Delete success: ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category Deleted successfully")),
        );

        // success = true;
      } else {
        print("Delete failed: ${response.statusCode} - ${response.body}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to delete category: ${response.statusCode}"),
          ),
        );
      }
    } catch (e) {
      print("Error deleting category: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error deleting category: ${e.toString()}")),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    // return success;
  }

  // Clear search and reset filtered list
  void clearSearch() {
    categoryController.clear();
    _filterCategoryList = List.from(_categoryList);
    notifyListeners();
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }
}
