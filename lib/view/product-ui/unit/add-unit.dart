// // ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, file_names, use_build_context_synchronously, unused_import, await_only_futures

// ignore_for_file: prefer_final_fields, unused_field, unused_local_variable, file_names, use_build_context_synchronously, unused_import, await_only_futures

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pos/models/products/unit-model.dart';
import 'package:pos/providers/products/category/category-provider.dart';
import 'package:pos/providers/products/unit/unit-provider.dart';
import 'package:pos/widgets/login/auth-button.dart';
import 'package:pos/widgets/login/build-text-formField.dart';
import 'package:provider/provider.dart' show Provider;

import '../../../models/products/category-model.dart';

class AddUnitScreen extends StatefulWidget {
  // Add these new parameters
  final UnitModel? unitToEdit;
  final bool isEdit;

  const AddUnitScreen({super.key, this.unitToEdit, this.isEdit = false});

  @override
  State<AddUnitScreen> createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize edit state when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<UnitProvider>(context, listen: false);
      if (widget.isEdit && widget.unitToEdit != null) {
        provider.setEditModel(widget.unitToEdit!);
      } else {
        // Ensure we're in add mode
        if (provider.isEdit) {
          provider.clearEditState();
        }
        provider.unitController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UnitProvider>(context, listen: true);
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.isEdit ? "Edit Unit" : "Add Unit",
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
              controller: provider.unitController,
              name: 'Unit Name',
            ),
            SizedBox(height: mq.height * 0.02),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AuthButton(
                    onTap: () async {
                      if (provider.unitController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please enter Unit name")),
                        );
                        return;
                      }

                      // await provider.addUnit(
                      //   provider.unitController.text,
                      //   context,
                      // );
                      // Navigator.pop(context);
                      bool success;
                      if (provider.isEdit) {
                        success = await provider.updateUnit(context);
                        if (success) {
                          provider.clearEditState();
                          provider.clearSearch();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Unit updated successfully"),
                            ),
                          );
                        }
                      } else {
                        await provider.addUnit(
                          provider.unitController.text,
                          context,
                        );
                        success = true;
                        provider.unitController.clear();
                      }
                      if (success) {
                        Navigator.pop(context, true);
                      }
                      // if (success) {
                      //   provider.clearSearch();
                      //   provider.unitController.clear();
                      //   Navigator.pop(context, true);
                      // }
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
                      // if (provider.categoryController.text.isEmpty) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text("Please enter category name")),
                      //   );
                      //   return;
                      // }

                      // bool success;
                      // if (provider.isEdit) {
                      //   success = await provider.updateCategory(context);
                      //   if (success) {
                      //     // After successful update, clear and switch to add mode
                      //     provider.clearEditState();
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(
                      //         content: Text("Category updated successfully"),
                      //       ),
                      //     );
                      //   }
                      // } else {
                      //   await provider.addCategory(
                      //     provider.categoryController.text,
                      //     context,
                      //   );
                      //   success = true;
                      //   // Clear for next entry
                      //   provider.categoryController.clear();
                      // }
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
