// ignore_for_file: file_names, sort_child_properties_last, unused_element, unused_local_variable, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:pos/providers/products/unit/unit-provider.dart';
import 'package:pos/view/product-ui/unit/add-unit.dart';
import 'package:provider/provider.dart';

class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  FocusNode unitFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UnitProvider>(context, listen: false).fetchUnits();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final uProvider = Provider.of<UnitProvider>(context);
    return GestureDetector(
      onTap: () {
        unitFocus.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Manage Units",
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
                // final result = await Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AddCategoryScreen()),
                // );

                // if (result == true) {
                //   // Refresh categories after coming back
                //   Provider.of<CategoryProvider>(
                //     context,
                //     listen: false,
                //   ).fetchCategory();
                // }
                // provider.categoryController.clear();
              },
              icon: Icon(Icons.add, size: 27, color: Colors.white),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Consumer<UnitProvider>(
                builder: (context, provider, child) => TextFormField(
                  focusNode: unitFocus,
                  controller: provider.searchController,
                  onChanged: provider.filterUnits,
                  decoration: InputDecoration(
                    prefixIcon: provider.searchController.text.isEmpty
                        ? Icon(Icons.search, size: 30)
                        : IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 24,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              provider.clearSearch();
                              unitFocus.unfocus();
                            },
                          ),
                    hintText: 'Search Unit',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Consumer<UnitProvider>(
                builder: (context, provider, _) {
                  return Expanded(child: _buildUnitList(provider));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitList(UnitProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (provider.filterUnitList.isEmpty) {
      return const Center(child: Text("No Units found"));
    }

    return ListView.builder(
      itemCount: provider.filterUnitList.length,
      itemBuilder: (context, index) {
        final unit = provider.filterUnitList[index];
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
                            unit.unitName.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          unit.status == '1'
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
                              final orgProvider = Provider.of<UnitProvider>(
                                context,
                                listen: false,
                              );

                              // Set the provider for editing
                              // originalProvider.setEditModel(category);
                              orgProvider.setEditModel(unit);

                              // Navigate to edit screen
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddUnitScreen(
                                    unitToEdit: unit,
                                    isEdit: true,
                                  ),
                                ),
                              );

                              // Refresh the list after coming back from editing
                              if (result == true) {
                                await orgProvider.fetchUnits();
                                orgProvider.unitController.clear();
                              }
                              // if (result == true) {
                              //   await originalProvider.fetchCategory();
                              //   originalProvider.categoryController.clear();
                              // }
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
                              // _showDeleteDialog(context, category, provider);
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
}
