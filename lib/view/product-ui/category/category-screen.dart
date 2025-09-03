// // ignore_for_file: unused_element, file_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings, sort_child_properties_last, unused_import

// ignore_for_file: unused_element, file_names, use_build_context_synchronously, prefer_interpolation_to_compose_strings, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:pos/models/customer/customer-model.dart';
import 'package:pos/models/products/category-model.dart';
import 'package:pos/page-and-routes/routes-name.dart';
import 'package:pos/providers/products/category/category-provider.dart';
import 'package:pos/view/product-ui/category/add-category-screen.dart';
import 'package:provider/provider.dart';

import '../../../utils/animatedDialog.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategory();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    return GestureDetector(
      onTap: () {
        searchFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Manage Category",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                );

                if (result == true) {
                  // Refresh categories after coming back
                  Provider.of<CategoryProvider>(
                    context,
                    listen: false,
                  ).fetchCategory();
                }
                provider.categoryController.clear();
              },
              icon: Icon(Icons.add, size: 27, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Consumer<CategoryProvider>(
                builder: (context, value, _) {
                  return TextFormField(
                    focusNode: searchFocus,
                    controller: provider.categoryController,
                    onChanged: value.filterCategories,
                    decoration: InputDecoration(
                      prefixIcon: provider.categoryController.text.isEmpty
                          ? Icon(Icons.search, size: 30)
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                provider.clearSearch();
                                searchFocus.unfocus();
                              },
                            ),
                      hintText: 'Search Category',
                      border: UnderlineInputBorder(),
                    ),
                  );
                },
              ),
              SizedBox(height: 15),
              Consumer<CategoryProvider>(
                builder: (context, provider, _) {
                  return Expanded(child: _buildCategoryList(provider));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList(CategoryProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (provider.filterCategoryList.isEmpty) {
      return const Center(child: Text("No categories found"));
    }

    return ListView.builder(
      itemCount: provider.filterCategoryList.length,
      itemBuilder: (context, index) {
        final category = provider.filterCategoryList[index];
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 20),
                    Expanded(
                      flex: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.category_name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          category.status == '1'
                              ? Row(
                                  children: [
                                    Text(
                                      'Status : ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Active ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors
                                            .green, // Changed to green for active
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Text(
                                      'Status : ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Inactive ',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      color: Colors.white,
                      icon: Icon(Icons.more_vert, size: 30),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () async {
                              // Close the popup menu first
                              Navigator.pop(context);

                              // Get the original provider
                              final originalProvider =
                                  Provider.of<CategoryProvider>(
                                    context,
                                    listen: false,
                                  );

                              // Set the provider for editing
                              originalProvider.setEditModel(category);

                              // Navigate to edit screen
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddCategoryScreen(
                                    categoryToEdit: category,
                                    isEdit: true,
                                  ),
                                ),
                              );

                              // Refresh the list after coming back from editing
                              if (result == true) {
                                await originalProvider.fetchCategory();
                                originalProvider.categoryController.clear();
                              }
                            },
                            label: Text('Edit'),
                            icon: Icon(Icons.edit),
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: TextButton.icon(
                            onPressed: () {
                              // Close the popup menu
                              Navigator.pop(context);
                              _showDeleteDialog(context, category, provider);
                            },
                            label: Text('Delete'),
                            icon: Icon(Icons.delete),
                          ),
                          value: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    CategoryModel category,
    CategoryProvider provider,
  ) {
    showMyAnimatedDialog(
      context: context,
      title: 'Delete Category',
      content: 'Do you really want to delete this category?',
      actionText: 'YES',
      onActionPressed: (isConfirmed) async {
        if (isConfirmed) {
          await provider.deleteCategory(
            category.category_id as String,
            context,
          );
        }
      },
    );
  }

  @override
  void dispose() {
    searchFocus.dispose();
    super.dispose();
  }
}
