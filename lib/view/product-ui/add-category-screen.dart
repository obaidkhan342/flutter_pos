// // ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, file_names, use_build_context_synchronously, unused_import, await_only_futures

// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, file_names, use_build_context_synchronously, unused_import, await_only_futures

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/providers/products/category-provider.dart';
import 'package:pos/widgets/login/auth-button.dart';
import 'package:pos/widgets/login/build-text-formField.dart';
import 'package:provider/provider.dart' show Provider;

import '../../models/products/category-model.dart';

class AddCategoryScreen extends StatefulWidget {
  // Add these new parameters
  final CategoryModel? categoryToEdit;
  final bool isEdit;

  const AddCategoryScreen({
    super.key,
    this.categoryToEdit,
    this.isEdit = false,
  });

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize edit state when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CategoryProvider>(context, listen: false);
      if (widget.isEdit && widget.categoryToEdit != null) {
        provider.setEditModel(widget.categoryToEdit!);
      } else {
        // Ensure we're in add mode
        if (provider.isEdit) {
          provider.clearEditState();
        }
        provider.categoryController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context, listen: true);
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.isEdit ? "Edit Category" : "Add Category",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            buildTextFormField(
              context: context,
              controller: provider.categoryController,
              name: 'Category Name',
            ),
            SizedBox(height: mq.height * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AuthButton(
                    onTap: () async {
                      if (provider.categoryController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter category name")),
                        );
                        return;
                      }

                      bool success;
                      if (provider.isEdit) {
                        success = await provider.updateCategory(context);
                      } else {
                        await provider.addCategory(
                          provider.categoryController.text,
                          context,
                        );
                        success = true; // addCategory handles its own errors
                      }

                      if (success) {
                        Navigator.pop(context, true);
                      }
                    },
                    title: provider.isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            widget.isEdit ? 'Update' : 'Save',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                SizedBox(width: 10),

                Expanded(
                  child: AuthButton(
                    onTap: () async {
                      if (provider.categoryController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter category name")),
                        );
                        return;
                      }

                      bool success;
                      if (provider.isEdit) {
                        success = await provider.updateCategory(context);
                        if (success) {
                          // After successful update, clear and switch to add mode
                          provider.clearEditState();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Category updated successfully"),
                            ),
                          );
                        }
                      } else {
                        await provider.addCategory(
                          provider.categoryController.text,
                          context,
                        );
                        success = true;
                        // Clear for next entry
                        provider.categoryController.clear();
                      }
                    },
                    title: Text(
                      widget.isEdit ? 'Update & New' : 'Save & Add Another',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up when screen is disposed
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    if (!provider.isEdit) {
      provider.categoryController.clear();
    }
    super.dispose();
  }
}
