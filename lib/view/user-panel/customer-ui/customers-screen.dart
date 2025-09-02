//  ignore_for_file: file_names, unused_import, override_on_non_overriding_member, unused_local_variable, avoid_unnecessary_containers, prefer_final_fields

// ignore_for_file: unused_element, deprecated_member_use, use_build_context_synchronously, await_only_futures, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:pos/models/customer/customer-model.dart';
import 'package:pos/providers/cusomters/fetch-customers-provider.dart';
import 'package:pos/utils/animatedDialog.dart';
import 'package:pos/view/user-panel/customer-ui/customer-profile.dart';
import 'package:provider/provider.dart';
import '../../../page-and-routes/routes-name.dart';
import '../home/home_screen.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomerProvider>(context, listen: false).fetchCustomers();
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // provider.clearSelection();
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.homeScreen,
          (route) => false,
        );
        return false;
      },
      child: Consumer<CustomerProvider>(
        builder: (context, provider, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Consumer<CustomerProvider>(
                  builder: (context, value, child) {
                    return DropdownButton<CustomerFilter>(
                      value: value.currentFilter,
                      underline: SizedBox(),
                      items: const [
                        DropdownMenuItem(
                          value: CustomerFilter.all,
                          child: Text('All Customers'),
                        ),
                        DropdownMenuItem(
                          value: CustomerFilter.credit,
                          child: Text("Credit Customers"),
                        ),
                        DropdownMenuItem(
                          value: CustomerFilter.paid,
                          child: Text("Paid Customers"),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          value.setFilter(val);
                        }
                      },
                    );
                  },
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
              ),
              body: Column(
                children: [
                  Divider(thickness: 1.5),
                  TextFormField(
                    controller: searchController,
                    onChanged: provider.filterCustomers,
                    decoration: InputDecoration(
                      prefixIcon: searchController.text.isEmpty
                          ? Icon(Icons.search, size: 30)
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                searchController.clear();
                                provider.clearSearch();
                              },
                            ),
                      hintText: 'Search customers',
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  Center(
                    child: TextButton(
                      onPressed: () async {
                        // Navigator.pushNamed(context, RoutesName.addCustomer);
                        final result = await Navigator.pushNamed(
                          context,
                          RoutesName.addCustomer,
                        );

                        if (result == true) {
                          // 👇 refresh customers after coming back
                          Provider.of<CustomerProvider>(
                            context,
                            listen: false,
                          ).fetchCustomers();
                        }
                        searchController.clear();
                      },
                      child: Text(
                        "ADD NEW CUSTOMER",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1.5),
                  Expanded(child: _buildCustomerList(provider)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomerList(CustomerProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (provider.errorMessage != null) {
      return Center(child: Text("Error: ${provider.errorMessage}"));
    } else if (provider.filterCustomer.isEmpty) {
      return const Center(child: Text("No customers found"));
    }

    return ListView.builder(
      itemCount: provider.filterCustomer.length,
      itemBuilder: (context, index) {
        final customer = provider.filterCustomer[index];

        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    child: GestureDetector(
                      onTap: () async {
                        final result =
                            await provider.currentFilter ==
                                CustomerFilter.credit
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerProfile(
                                    customerId: customer.customerId!,
                                    creditBalance: customer.customerBalance,
                                  ),
                                ),
                              )
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomerProfile(
                                    customerId: customer.customerId!,
                                    creditBalance: null,
                                  ),
                                ),
                              );

                        if (result == true) {
                          // Refresh the customer list when coming back from profile
                          Provider.of<CustomerProvider>(
                            context,
                            listen: false,
                          ).fetchCustomers();
                        }
                        searchController.clear();
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child:
                            (customer.customerName != null &&
                                customer.customerName!.isNotEmpty)
                            ? Text(customer.customerName![0].toUpperCase())
                            : const Text("N"),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          customer.customerName.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Text(
                          customer.customerEmail.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          customer.customerMobile.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Center(
                    child: IconButton(
                      onPressed: () {
                        showMyAnimatedDialog(
                          context: context,
                          title: 'Delete User',
                          content: 'do you really want to delete this user ?',
                          actionText: 'YES',
                          onActionPressed: (isConfirmed) {
                            if (isConfirmed) {
                              provider.deleteCustomer(
                                uId: customer.customerId!,
                                context: context,
                              );
                            } else {
                              // Navigator.pop(context);
                            }
                          },
                        );
                      },
                      icon: Icon(Icons.delete, size: 30, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
          ],
        );
      },
    );
  }
}
