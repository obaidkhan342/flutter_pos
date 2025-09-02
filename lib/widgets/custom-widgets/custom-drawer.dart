// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pos/providers/login/login-provider.dart';
import 'package:pos/view/product-ui/add-category-screen.dart';
import 'package:pos/view/product-ui/category-screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Drawer(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ListView(
              children: [
                Consumer<LoginProvider>(
                  builder: (context, provider, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Card(
                          shape: CircleBorder(),
                          // shape: BorderRadius.circular(30),
                          child: CircleAvatar(
                            // backgroundColor: AppColors.primaryColor0,
                            radius: 50,
                            backgroundImage:
                                provider.currentUser?.image != null &&
                                    provider.currentUser?.image != ""
                                ? Image.network(
                                    "https://aneescolorcosmetics.site/pos/${provider.currentUser?.image}",
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Text("Image Not Found");
                                    },
                                  ).image
                                : Image.network(
                                    ' https://aneescolorcosmetics.site/pos/${provider.currentUser?.image}',
                                    width: 50,
                                    height: 50,
                                  ).image,
                          ),
                        ),
                        SizedBox(height: 9),
                        Text(
                          provider.currentUser?.userName ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            // color: Colors.white,
                          ),
                        ),
                        SelectableText(
                          provider.currentUser?.userEmail ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            // color: Colors.white,
                            // fontWeight : FontWeight.w500,
                          ),
                        ),
                        Divider(),
                        // SelectableText(
                        //   'https://aneescolorcosmetics.site/pos/${provider.currentUser?.image}',
                        // ),
                      ],
                    );
                  },
                ),
                SizedBox(height: mq.height * 0.02),
                ExpansionTile(
                  title: ListTile(
                    leading: Icon(Icons.balance, size: 27),

                    title: Text(
                      'Sale',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(
                              "New Sale",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Manage Sale",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                ExpansionTile(
                  title: ListTile(
                    leading: Icon(
                      Icons.production_quantity_limits_rounded,
                      size: 27,
                    ),
                    title: Text(
                      'Products',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddCategoryScreen(),
                                ),
                              );
                              Navigator.pop(context);
                            },
                            title: Text(
                              "Add Category",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryScreen(),
                                ),
                              );
                            },
                            title: Text(
                              "Category List",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Add Unit",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Unit List",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Add Product",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Add Product (CSV)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Manage Product",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: ListTile(
                    leading: Icon(Icons.inventory, size: 27),
                    title: Text(
                      'Inventory',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [],
                ),
                ExpansionTile(
                  title: ListTile(
                    leading: Icon(Icons.file_copy, size: 27),
                    title: Text(
                      'Reports',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Closing",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Closing Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Todays Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Todays Customer Receipt",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Sales Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "User wise Sales Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Due Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Shipping Cost Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Purchase Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Purchase Report (Category wise)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Sales Return ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Supplier Return ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Tax Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Profit Report (Sale Wise)",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: ListTile(
                    leading: Icon(Icons.note_alt_outlined, size: 27),
                    title: Text(
                      'Qoutation',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              "Add Qoutation",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              "Manage Qoutation",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: ListTile(
                    leading: Icon(Icons.settings, size: 27),
                    title: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ExpansionTile(
                            title: ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Software Settings'),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 45),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        "Manage Company",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Add User",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Manage User",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Language",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Currency",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Settings",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Print Settings",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "Main Settings",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ListTile(title: Text("Hello"))]),
        ),
      ),
    );
  }
}
